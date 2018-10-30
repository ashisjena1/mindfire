<!--- Checking for user Login --->
<cfif structKeyExists(SESSION,"setLoggedInUser")>
	<!--- Checking the user is HR or Not --->
	<cfif #UCase(SESSION.setLoggedInUser.empRole)# EQ "HR">
		<cfset name="#SESSION.setLoggedInUser.firstName# #SESSION.setLoggedInUser.lastName#">
		<cfparam name="isEmployeeAdded" default=false/>
		<!--- Checking for Logout --->
		<cfif structKeyExists(URL,"logout")>
			<cfset APPLICATION.loginService.doLogout()/>
			<cflocation url="../../index.cfm">
		</cfif>
		<!--- Checking for submit button click --->
		<cfif not structKeyExists(FORM,"addEmployee")>
			<!--- Setting the error message in addEmployeeErrorMessage structure --->
			<cfset addEmployeeErrorMessage =
				{firstName="",middleName="",lastName="",email="",dob="",phoneNumber="",joiningDate="",basicSalary="",roleName=""}/>
		<cfelse>
			<!--- Checking admin input data for server side validation --->
			<cfset addEmployeeErrorMessage=APPLICATION.adminService.checkEmployeeDetails()/>
			<!--- Checking for no error --->
			<cfif addEmployeeErrorMessage.firstName EQ ""  and addEmployeeErrorMessage.middleName EQ "" and addEmployeeErrorMessage.lastName EQ "" and
				  addEmployeeErrorMessage.email EQ "" and addEmployeeErrorMessage.dob EQ "" and addEmployeeErrorMessage.phoneNumber EQ "" and
				  addEmployeeErrorMessage.joiningDate EQ "" and addEmployeeErrorMessage.basicSalary EQ "" and addEmployeeErrorMessage.roleName EQ "">
					<!--- If no error then add data to the employee table --->
					<cfset isEmployeeAdded = APPLICATION.adminService.addEmployee(FORM.firstName,FORM.middleName,FORM.lastName,FORM.email,FORM.dateOfBirth,
										FORM.phoneNumber,FORM.gender,FORM.joiningDate,FORM.basicSalary,FORM.roleId)/>
			</cfif>
		</cfif>

		<!--- If employee added successfully then redirect to home page --->
		<cfif isEmployeeAdded>
				<cflocation url="../index.cfm">
		<cfelse><!--- else show the add employee form --->
			<cf_headerFooter title="Add Employee">
				<!--- Import stylesheet --->
				<link rel="stylesheet" type="text/css" href="../../assets/css/admin.css">
				<link rel="stylesheet" type="text/css" href="../../assets/css/adminPageStyle.css">

				</head>
				<body>
					<!--- custom tag for top nav bar --->
					<cf_navbar name="#name#" source="../../assets/images/" homeSource="../" profileSource="profile.cfm"></cf_navbar>
					<!--- Side navbar --->
					<div class="sidenav">
					  <a href="addEmployee.cfm">Add Employee</a>
					  <a href="addProject.cfm">Add Project</a>
					  <a href="projectDetails.cfm">Project Details</a>
					  <a href="assignProject.cfm">Assign Project</a>
					  <a href="applyLeaves.cfm">Apply Leaves</a>
					  <a href="salary.cfm">Salary</a>
					</div><!--- end side navbar --->
					<!--- main content --->
					<div class="main">
						<div class="container"><!--- container --->
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

										<!--- fetch the role name from the role table  --->
										<cfset employeeRole=APPLICATION.adminService.getEmployeeRole()/>
										<div class="form-group">
												<label for="roleName" class="col-sm-4 control-label">Role Name*</label>
												<div class="col-sm-8">
													<select class="form-control" id="roleName" name="roleID">
															<option value="">-- select --</option>
															<!--- loop over the employeeRole --->
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
									</cfform> <!--- form --->
								</cfoutput>
							</div>
						</div> <!--- end container --->
					</div><!--- end main --->
				<script type = "text/javascript" src = "../../assets/javaScript/addEmployee.js"></script>
			</cf_headerFooter><!--- end headerFooter custom tag --->
		</cfif><!--- end if clause for employee added or not --->
	<cfelse><!--- Show error msg for unauthorized user --->
		You are not authorized to open this page.
	</cfif><!--- end if clause for  checking authorized user--->
<cfelse><!--- if  user is not logged in then page will redirect to login page --->
	<cflocation url="../../">
</cfif>