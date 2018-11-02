<!--- Checking for user Login --->
<cfif structKeyExists(SESSION,"setAdmin")>
	<!--- Checking for Logout --->
	<cfif structKeyExists(URL,"logout")>
		<cfset APPLICATION.adminService.doLogout()/>
		<cflocation url="adminLogin.cfm">
	</cfif>
	<!--- Checking the user is Admin --->

		<cfset VARIABLES.name="#SESSION.setAdmin.firstName# #SESSION.setAdmin.lastName#">
		<cfparam name="VARIABLES.isProjectAdded" default="false">
		<!--- Checking for submit button click --->
		<cfif not structKeyExists(FORM,"addProject")>
			<!--- Initializing the error message in addProjectErrorMessage structure --->
			<cfset VARIABLES.addProjectErrorMessage={projectName="",managerName="",startDate="",endDate=""}/>
		<cfelse>
			<!--- Checking admin input data for server side validation --->
			<cfset VARIABLES.addProjectErrorMessage=APPLICATION.adminService.checkProjectDetails()/>
			<cfif VARIABLES.addProjectErrorMessage.projectName EQ ""  and VARIABLES.addProjectErrorMessage.managerName EQ "" and
					VARIABLES.addProjectErrorMessage.startDate EQ "" and VARIABLES.addProjectErrorMessage.endDate EQ "">
					<!--- If no error then add data to the employee table --->
					<cfset VARIABLES.isProjectAdded = APPLICATION.adminService.addProject(FORM.projectName,FORM.managerID,FORM.projectStartDate,FORM.projectEndDate)/>
			</cfif>
		</cfif>

		<!--- If project added successfully then redirect to home page --->
		<cfif VARIABLES.isProjectAdded>
			<cflocation url="../index.cfm">
		<cfelse><!--- else show the add project form --->
			<cf_headerFooter title="Add Project">
				<!--- Import external stylesheet --->
				<link rel="stylesheet" type="text/css" href="../../assets/css/admin.css">
				<link rel="stylesheet" type="text/css" href="../../assets/css/adminPageStyle.css">

				</head>
				<body>
					<!--- custom tag for top nav bar --->
					<cf_navbar name="#VARIABLES.name#" source="../../assets/images/" homeSource="../"></cf_navbar>
					<!--- Side navbar --->
					<div class="sidenav">
					  <a href="addEmployee.cfm">Add Employee</a>
					  <a href="../">Employee Details</a>
					  <a href="">Add Project</a>
					  <a href="projectDetails.cfm">Project Details</a>
					  <a href="assignProject.cfm">Assign Project</a>
					</div><!--- end side navbar --->
					<!--- main content --->
					<div class="main">
							<div class="container"><!--- container --->
								<div class="card card-container">
									<cfform class="form-horizontal" id="addProject">
										<cfoutput>
											<h2>Add New Project</h2>
											<div class="form-group">
												<label for="projectName" class="col-sm-4 control-label">Project Name*</label>
												<div class="col-sm-8">
													<input type="text" id="projectName" name="projectName" placeholder="Project Name" class="form-control" >
												</div>
												<div class="col-sm-4"></div>
												<div class="col-sm-8"><span class="text-danger" id="projectNameError">#VARIABLES.addProjectErrorMessage.projectName#</span></div>
											</div>
											<!--- fetch the manager name from the employee table  --->
											<cfset VARIABLES.manager=APPLICATION.adminService.getManager()/>
											<div class="form-group">
												<label for="managerName" class="col-sm-4 control-label">Project Manger*</label>
												<div class="col-sm-8">
													<select class="form-control" id="managerName" name="managerID">
															<option value="">-- select --</option>
															<!--- loop over the manager --->
															<cfloop query="VARIABLES.manager">
																<option value="#VARIABLES.manager.empId#">#VARIABLES.manager.name#</option>
															</cfloop>
													</select>
												</div>
												 <div class="col-sm-4"></div>
												<div class="col-sm-8"><span class="text-danger" id="projectManagerError">#VARIABLES.addProjectErrorMessage.managerName#</span></div>
											</div>
											<div class="form-group">
												<label for="startDate" class="col-sm-4 control-label">Start Date*</label>
												<div class="col-sm-8">
													<input type="date" id="startDate" name="projectStartDate" class="form-control">
												</div>
												 <div class="col-sm-4"></div>
												<div class="col-sm-8"><span class="text-danger" id="projectStartDateError">#VARIABLES.addProjectErrorMessage.startDate#</span></div>
											</div>
											<div class="form-group">
												<label for="endDate" class="col-sm-4 control-label">End Date*</label>
												<div class="col-sm-8">
													<input type="date" id="endDate" name="projectEndDate" class="form-control">
												</div>
												 <div class="col-sm-4"></div>
												<div class="col-sm-8"><span class="text-danger" id="projectEndDateError">#VARIABLES.addProjectErrorMessage.endDate#</span></div>
											</div>
											<input type="submit" class="btn btn-primary btn-block" value="Add Project" name="addProject"/>
										</cfoutput>
									</cfform>
								</div>
							 </div><!--- end container --->
					</div><!--- end main --->
					<!--- import external javascript --->
					<script type = "text/javascript" src = "../../assets/javaScript/addProject.js"></script>
			</cf_headerFooter><!--- end header footer custom tag --->
		</cfif><!--- end if clause for project added or not --->
<cfelse><!--- if employee is not logged in then it will redirect to login page --->
	<cflocation url="adminLogin.cfm">
</cfif>