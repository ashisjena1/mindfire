<cfif structKeyExists(SESSION,'setLoggedInUser')>
	<cfif #SESSION.setLoggedInUser.empRole# eq "HR">
		<cfset name="#SESSION.setLoggedInUser.firstName# #SESSION.setLoggedInUser.lastName#">
		<cfparam name="isEmployeeAdded" default=false/>
		<cfif structKeyExists(URL,'logout')>
			<cfset APPLICATION.userService.doLogout()/>
			<cflocation url="../../index.cfm">
		</cfif>

		<cfif not structKeyExists(FORM,'addEmployee')>
			<cfset addEmployeeErrorMessage =
				{firstName='',middleName='',lastName='',email='',dob='',phoneNumber='',joiningDate='',departmentName='',basicSalary='',roleName=''}/>
		<cfelse>
			<cfset addEmployeeErrorMessage=APPLICATION.adminService.checkEmployeeDetails()/>
			<cfif addEmployeeErrorMessage.firstName eq ''  and addEmployeeErrorMessage.middleName eq '' and addEmployeeErrorMessage.lastName eq '' and
				  addEmployeeErrorMessage.email eq '' and addEmployeeErrorMessage.dob eq '' and addEmployeeErrorMessage.phoneNumber eq '' and
				  addEmployeeErrorMessage.joiningDate eq '' and addEmployeeErrorMessage.departmentName eq '' and
				  addEmployeeErrorMessage.basicSalary eq '' and addEmployeeErrorMessage.roleName eq ''>
					 <cfset isEmployeeAdded = APPLICATION.adminService.addEmployee(FORM.firstName,FORM.middleName,FORM.lastName,FORM.email,FORM.dateOfBirth,
										FORM.phoneNumber,FORM.gender,FORM.joiningDate,FORM.departmentId,FORM.basicSalary,FORM.roleId)/>
			</cfif>
		</cfif>

		<cfif isEmployeeAdded>
				<cflocation url="../index.cfm">
		<cfelse>
			<cf_headerFooter title="Add Employee">
				<link rel="stylesheet" type="text/css" href="../../assets/css/admin.css">
				<link rel="stylesheet" type="text/css" href="../../assets/css/addEmployee.css">
				<script type = "text/javascript" src = "../../assets/javaScript/addEmployee.js"></script>
				</head>
				<body>
					<cf_navbar name="#name#" source="../../assets/images/"></cf_navbar>

					<div class="container">
						<div class="card card-container">
						<cfoutput>
							<cfform class="form-horizontal" id="addNewEmployee">
								<h2>Add New Employee</h2>
								<div class="form-group">
									<label for="firstName" class="col-sm-4 control-label">First Name*</label>
									<div class="col-sm-8">
										<input type="text" name="firstName" id="firstName" placeholder="First Name" class="form-control">
									</div>
									<div class="col-sm-4"></div>
									<div class="col-sm-8">
										<span class="text-danger" id="firstNameError">#addEmployeeErrorMessage.firstName#</span>
									</div>
								</div>

								<div class="form-group">
									<label for="middleName" class="col-sm-4 control-label">Middle Name</label>
									<div class="col-sm-8">
										<input type="text" name="middleName" id="middleName" placeholder="Middle Name" class="form-control" >
									</div>
									<div class="col-sm-4"></div>
									<div class="col-sm-8">
										<span class="text-danger" id="middleNameError">#addEmployeeErrorMessage.middleName#</span>
									</div>
								</div>

								<div class="form-group">
									<label for="lastName" class="col-sm-4 control-label">Last Name*</label>
									<div class="col-sm-8">
										<input type="text" id="lastName" name="lastName" placeholder="Last Name" class="form-control" >
									</div>
									<div class="col-sm-4"></div>
									<div class="col-sm-8">
										<span class="text-danger" id="lastNameError">#addEmployeeErrorMessage.lastName#</span>
									</div>
								</div>

								<div class="form-group">
									<label for="email" class="col-sm-4 control-label">Email* </label>
									<div class="col-sm-8">
										<input type="email" id="email" name="email" placeholder="Email" class="form-control" name= "email">
									</div>
									<div class="col-sm-4"></div>
									<div class="col-sm-8">
										<span class="text-danger" id="emailError">#addEmployeeErrorMessage.email#</span>
									</div>
								</div>


								<div class="form-group">
									<label for="dob" class="col-sm-4 control-label">Date of Birth*</label>
									<div class="col-sm-8">
										<input type="date" id="dob" name="dateOfBirth" class="form-control">
									</div>
									<div class="col-sm-4"></div>
									<div class="col-sm-8">
										<span class="text-danger" id="dobError">#addEmployeeErrorMessage.dob#</span>
									</div>
								</div>

								<div class="form-group">
									<label for="phoneNumber" class="col-sm-4 control-label">Phone number* </label>
									<div class="col-sm-8">
										<input type="number" id="phoneNumber" name="phoneNumber" placeholder="Phone number" class="form-control">
									 </div>
									 <div class="col-sm-4"></div>
									<div class="col-sm-8">
										<span class="text-danger" id="phoneNumberError">#addEmployeeErrorMessage.phoneNumber#</span>
									</div>
								</div>

								<div class="form-group">
									<label class="control-label col-sm-4">Gender*</label>
									<div class="col-sm-8">
										<div class="row">
											<div class="col-sm-4">
												<label class="radio-inline">
													<input type="radio" name="gender" value="f" checked>Female
												</label>
											</div>
											<div class="col-sm-4">
												<label class="radio-inline">
													<input type="radio" name="gender" value="m">Male
												</label>
											</div>
											<div class="col-sm-4">
												<label class="radio-inline">
													<input type="radio" name="gender" value="o">Other
												</label>
											</div>
										</div>
									</div>
								</div>

								<div class="form-group">
										<label for="joiningDate" class="col-sm-4 control-label">Joining Date* </label>
									<div class="col-sm-8">
										<input type="date" id="joiningDate" name="joiningDate" placeholder="Please enter the Joining Date" class="form-control">
									</div>
									<div class="col-sm-4"></div>
									<div class="col-sm-8">
										<span class="text-danger" id="joiningDateError">#addEmployeeErrorMessage.joiningDate#</span>
									</div>
								</div>

								<cfset department=Application.adminService.getDepartment()/>
								<div class="form-group">
										<label for="departmentName" class="col-sm-4 control-label">Department Name*</label>
										<div class="col-sm-8">
											<select class="form-control" id="departmentName" name="departmentId">
													<option value="">-- select --</option>
													<cfloop query="department">
														<option value="#department.departmentId#">#department.departmentName#</option>
													</cfloop>
											</select>
										</div>
										<div class="col-sm-4"></div>
										<div class="col-sm-8">
											<span class="text-danger" id="departmentNameError">#addEmployeeErrorMessage.departmentName#</span>
										</div>
								 </div>

								 <div class="form-group">
										<label for="basicSalary" class="col-sm-4 control-label">Basic Salary* </label>
									<div class="col-sm-8">
										<input type="number" id="basicSalary" name="basicSalary" placeholder="Please Enter the Basic Salary" class="form-control">
									</div>
									<div class="col-sm-4"></div>
										<div class="col-sm-8">
											<span class="text-danger" id="basicSalaryError">#addEmployeeErrorMessage.basicSalary#</span>
										</div>
								</div>

								<cfset employeeRole=Application.adminService.getEmployeeRole()/>
								<div class="form-group">
										<label for="roleName" class="col-sm-4 control-label">Role Name*</label>
										<div class="col-sm-8">
											<select class="form-control" id="roleName" name="roleID">
													<option value="">-- select --</option>

													<cfloop query="employeeRole">
														<option value="#employeeRole.roleId#">#employeeRole.roleName#</option>
													</cfloop>
											</select>
										</div>
										<div class="col-sm-4"></div>
										<div class="col-sm-8">
											<span class="text-danger" id="roleNameError">#addEmployeeErrorMessage.roleName#</span>
										</div>
								 </div>

								<input type="submit" class="btn btn-primary btn-block" value="Add Employee" name="addEmployee">
						</cfform> <!-- /form -->
						</cfoutput>
					</div>
				</div> <!-- ./container -->


			</cf_headerFooter>
		</cfif>
	<cfelse>
		You are not authorized to open this page.
	</cfif>
<cfelse>
	<cflocation url="../../index.cfm">
</cfif>