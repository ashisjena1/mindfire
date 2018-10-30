<!--- Checking for user Login --->
<cfif structKeyExists(SESSION,'setLoggedInUser')>
	<!--- Checking for Logout --->
	<cfif structKeyExists(URL,'logout')>
		<cfset APPLICATION.loginService.doLogout()/>
		<cflocation url="../../index.cfm">
	</cfif>
	<!--- Checking for submit button click --->
	<cfif not structKeyExists(FORM,'updateDetails')>
		<!--- Initializing the error message in updatePersonalDetailsErrorMessage structure --->
		<cfset updatePersonalDetailsErrorMessage ={dob='',phoneNumber=''}/>
		<cfelse>
			<!--- Checking input data for server side validation --->
			<cfset updatePersonalDetailsErrorMessage=APPLICATION.personalService.checkUpdatePersonalDetails()/>
			<cfif updatePersonalDetailsErrorMessage.dob eq '' and updatePersonalDetailsErrorMessage.phoneNumber eq ''>
				<!--- If no error then update data to the employee table --->
				<cfset isPersonalDetailsUpdated = APPLICATION.personalService.updatePersonalDetails(SESSION.setLoggedInUser.empId,FORM.dateOfBirth,FORM.gender,FORM.phoneNumber)/>
			</cfif>
	</cfif>

	<cfset name="#SESSION.setLoggedInUser.firstName# #SESSION.setLoggedInUser.lastName#">
	<!--- custom tag for headerfooter --->
	<cf_headerFooter title="profile Page">
		<!--- import external stylesheet --->
		<link rel="stylesheet" type="text/css" href="../../assets/css/admin.css">
		<link rel="stylesheet" type="text/css" href="../../assets/css/profile.css">

		</head>
		<body>
			<!--- custom tag for top nav bar --->
			<cf_navbar name="#name#" source="../../assets/images/" homeSource="../"></cf_navbar>
			<cfoutput>
				<!--- Fetch personal details of the employee --->
				<cfset personalDetails = APPLICATION.personalService.getPersonalDetail(SESSION.setLoggedInUser.empId)/>
				<!--- Fetch skills of the current employee --->
				<cfset skillDetails = APPLICATION.personalService.getSkillDetails(SESSION.setLoggedInUser.empId)/>
				<!--- Fetch leave details of the employee of the current year --->
				<cfset leaveDetails = APPLICATION.personalService.getLeaveDetails(SESSION.setLoggedInUser.empId,#Year(now())#)/>
				<!--- Fetch leave history of the employee --->
				<cfset leaveTakenDetails = APPLICATION.personalService.getLeaveTakenDetails(SESSION.setLoggedInUser.empId)/>
				<!--- Fetch pall skills from skill table --->
				<cfset skills = APPLICATION.personalService.getSkills()/>
				<!--- Fetch project details of the employee --->
				<cfset employeeProjectDetails = APPLICATION.personalService.getEmployeeProjectDetails(SESSION.setLoggedInUser.empId)/>
				<!--- <div class="sidenav"></div>
				<div class="main"> --->
				<div class="profile">
					<div class="row">
						<div class="col-md-5">
							<div class="row">
							  <div class="panel panel-info">
								<div class="panel-heading">
								  <h3 class="panel-title">#personalDetails.firstName# #personalDetails.middleName# #personalDetails.lastName#</h3>
								</div><!--- End panel heading --->
								<div class="panel-body">
									<cfform id="updateProfile">
										<table class="table table-user-information">
											<tbody>
											  <tr>
												<td>Department:</td>
												<td>#personalDetails.departmentName#</td>
											  </tr>
											  <tr>
												<td>Role Of The Employee:</td>
												<td>#personalDetails.roleName#</td>
											  </tr>
											  <tr>
												<td>Joining Date:</td>
												<td>#DATEFORMAT(personalDetails.joiningDate,"mmm-dd-yyyy")#</td>
											  </tr>
											  <tr>
												<td>Date of Birth</td>
												<td>
													<span id="dob">#DATEFORMAT(personalDetails.dateOfBirth,"mmm-dd-yyyy")#</span>
													<span id="editDob">
														<input type="date" id="dateOfBirthInput" name="dateOfBirth" class="form-control" value="#DATEFORMAT(personalDetails.dateOfBirth,"yyyy-MM-dd")#">
													</span>
													<span id="dobError" class="text-danger">#updatePersonalDetailsErrorMessage.dob#</span>
												</td>
											  </tr>
											  <tr>
												<td>Gender</td>
												<td>
													<span id="gender">#personalDetails.gender#</span>
													<input type="hidden" id="genderHidden" value="#personalDetails.gender#">
													<span id="editGender">
														<div class="form-group">
															<div class="row">
																<div class="col-sm-4">
																	<label class="radio-inline">
																		<input type="radio" name="gender" value="f" id="female">Female
																	</label>
																</div>
																<div class="col-sm-4">
																	<label class="radio-inline">
																		<input type="radio" name="gender" value="m" id="male">Male
																	</label>
																</div>
																<div class="col-sm-4">
																	<label class="radio-inline">
																		<input type="radio" name="gender" value="o" id="other">Other
																	</label>
																</div>
															</div>
														</div>
													</span>
												</td>
											  </tr>
											  <tr>
												<td>Email</td>
												<td><a href="#personalDetails.email#">#personalDetails.email#</a></td>
											  </tr>
											  <tr>
												<td>Phone Number</td>
												<td>
													<span id="phoneNumber">#personalDetails.phoneNumber#</span>
													<span id="editPhoneNumber">
														<input type="number" id="phoneNumberInput" name="phoneNumber" class="form-control" value="#personalDetails.phoneNumber#">
													</span>
													<span id="phoneNumberError" class="text-danger">#updatePersonalDetailsErrorMessage.phoneNumber#</span>
												</td>
											  </tr>
											  <tr>
												<td>Basic Salary</td>
												<td>#personalDetails.basicSalary#</td>
											  </tr>
											</tbody>
										</table>
										<!--- Back Buuton --->
										<input type="button" value="Back" class="btn btn-primary" id="back">
										<!--- Update Buuton --->
										<input type="submit" value="Update Details" class="btn btn-primary pull-right" id="updateDetails" name="updateDetails">
									</cfform><!--- End cfform --->
								</div><!--- End panel body --->
							  </div><!--- End panel --->
							</div><!--- End row --->
							<!--- Edit button --->
							<input type="button" value="Edit details" class="btn btn-primary " id="edit">
						</div><!--- End column --->

						<div class="col-md-7">
							<div class="row">
								<div class = "col-md-7">
									<div class="card">
										<div class="panel">
											<div class="row">
												<div class="col-md-1"></div>
												<div class="col-md-10"><h4>Leave Balance of the employee</h4></div>
												<div class="col-md-1"></div>
											</div>
											<div class="row">
												<div class="panel-info panel-body">
													<table class="table table-responsive">
														<thead>
															<tr>
															<th>Total Leave Assigned</th>
															<th>Total Leave Taken</th>
															<th>Total Remaining leave</th>
															</tr>
														</thead>
														<tbody>
														<!--- loop over leave details --->
														<cfloop query="leaveDetails">
															<tr>
																<td>#leaveDetails.totalLeaveAssigned#</td>
																<td>#leaveDetails.totalLeaveTaken#</td>
																<td>#leaveDetails.totalRemainingLeave#</td>
															</tr>
														</cfloop>
														</tbody>
													</table><!--- End table --->
												</div><!--- End panel info --->
											</div><!--- End row --->
										</div><!--- End panel --->
									</div><!--- End card --->
								</div><!--- End column --->
								<div class="col-md-5">
									<div class="card">
										<div class="panel">
											<div class="row">
												<div class="col-md-2"></div>
												<div class="col-md-8"><h4>Skills of the employee</h4></div>
												<div class="col-md-2"></div>
											</div><!--- End row --->
											<div class="row">
												<div class="panel-info panel-body">
													<table class="table table-responsive">
														<thead>
															<tr>
																<th>Skills</th>
															</tr>
														</thead>
														<tbody>
															<tr>
																<!--- loop over employee personal skills --->
																<cfloop query="skillDetails">
																		<td>skillDetails.skillName</td>
																</cfloop>
															</tr>

														</tbody>
													</table><!--- End table --->
												</div><!--- End panel info --->
											</div><!--- End row --->
										</div><!--- End panel --->
									</div><!--- End card --->

									<div class="row">
										<cfform>
											<div class="form-group">
												<div class="col-md-4"><label class="form-label">Add skills</label></div>
												<div class="col-md-5">
													<select class="form-control">
														<option value="">--select--</option>
														<!--- loop over skills --->
														<cfloop query="skills">
															<option value="#skills.skillId#">#skills.skillName#</option>
														</cfloop>
													</select>
												</div><!--- End column --->
												<div class="col-md-3"><input type="button" value="Add Skills" class="btn btn-primary"></div>
											</div>
										</cfform>
									</div><!--- End row --->

								</div><!--- End column --->
							</div><!--- End row --->


							<div class="row">
								<div class="card">
									<div class="panel">
										<div class="row">
											<div class="col-md-4"></div>
											<div class="col-md-4"><h3>Project Details</h3></div>
											<div class="col-md-4"></div>
										</div><!--- End row --->
										<div class="row">
											<div class="panel-info panel-body">
												<table class="table table-responsive">
													<thead>
														<tr>
															<th class="col-md-4">ProjectName</th>
															<th class="col-md-4">Manager</th>
															<th class="col-md-2">Start Date</th>
															<th class="col-md-2">Finish Date</th>
														</tr>
													</thead>
													<tbody>
														<!--- loop over employee project --->
														<cfloop query="leaveDetails">
															<tr>
																<td class="col-md-4">#employeeProjectDetails.projectName#</td>
																<td class="col-md-4">#employeeProjectDetails.manager#</td>
																<td class="col-md-2">#employeeProjectDetails.projectJoinDate#</td>
																<td class="col-md-2">#employeeProjectDetails.projectFinishDate#</td>
															</tr>
														</cfloop><!--- End cfloop --->
													</tbody>
												</table><!--- End table --->
											</div><!--- End panel-info panel-body --->
										</div><!--- End row --->
									</div><!--- End panel --->
								</div><!--- End card --->
							</div><!--- End row --->



							<div class="row">
								<div class="card">
									<div class="panel">
										<div class="row">
											<div class="col-md-4"></div>
											<div class="col-md-4"><h3>Leave history</h3></div>
											<div class="col-md-4"></div>
										</div><!--- End row --->
										<div class="row">
											<div class="panel-info panel-body">
												<table class="table table-responsive">
													<thead>
														<tr>
															<th class="col-md-7">Reason</th>
															<th class="col-md-2">From</th>
															<th class="col-md-2">To</th>
															<th class="col-md-1">Number of Days</th>
														</tr>
													</thead>
													<tbody>
													<cfloop query="leaveTakenDetails">
														<!--- loop over leaveTakenDetails --->
														<tr>
															<td class="col-md-7">#leaveTakenDetails.reason#</td>
															<td class="col-md-2">#DATEFORMAT(leaveTakenDetails.leaveFromDate,"mmm-dd-yyyy")#</td>
															<td class="col-md-2">#DATEFORMAT(leaveTakenDetails.leaveToDate,"mmm-dd-yyyy")#</td>
															<td class="col-md-1">#leaveTakenDetails.totalNumberOfDays#</td>
														</tr>
													</cfloop>
													</tbody>
												</table><!--- End table --->
											</div><!--- End panel-body panel-info --->
										</div><!--- End row --->
									</div><!--- End panel --->
								</div><!--- End card --->
							</div><!--- End row --->
						</div><!--- End column --->
					</div><!--- End row --->
				</div><!--- End profile --->
				<!--- </div> --->
			</cfoutput>
		<!--- import external stylesheet --->
		<script type = "text/javascript" src = "../../assets/javaScript/profile.js"></script>
	</cf_headerFooter>
<cfelse>
	<cflocation url="../index.cfm">
</cfif>
