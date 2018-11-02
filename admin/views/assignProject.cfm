<!--- Checking for user Login --->
<cfif structKeyExists(SESSION,"setAdmin")>
	<!--- Checking for Logout --->
	<cfif structKeyExists(URL,"logout")>
		<cfset APPLICATION.adminService.doLogout()/>
		<cflocation url="adminLogin.cfm">
	</cfif>
		<cfset VARIABLES.name="#SESSION.setAdmin.firstName# #SESSION.setAdmin.lastName#">

		<cfif not structKeyExists(FORM,"assignProject")>
			<cfset VARIABLES.assignProjectErrorMessage={employeeName="",projectName="",assignDate="",completionDate=""}/>
		<cfelse>
			<cfset VARIABLES.assignProjectErrorMessage=APPLICATION.adminService.checkProjectMappingDetails()/>
			<cfif VARIABLES.assignProjectErrorMessage.employeeName EQ ""  and VARIABLES.assignProjectErrorMessage.projectName eq "" and
					VARIABLES.assignProjectErrorMessage.assignDate eq "" and VARIABLES.assignProjectErrorMessage.completionDate eq "">
					<cfset VARIABLES.isProjectMapped = APPLICATION.adminService.addProjectMapping(FORM.employeeName,FORM.projectName,FORM.projectAssignDate,FORM.projectcompletionDate)/>
			</cfif>

		</cfif>
		<cfparam name="VARIABLES.isProjectMapped" default="false">
		<cfif VARIABLES.isProjectMapped>
			<cflocation url="../index.cfm">
		<cfelse>
			<cf_headerFooter title="Assign Project">
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
						  <a href="addProject.cfm">Add Project</a>
						  <a href="projectDetails.cfm">Project Details</a>
						  <a href="">Assign Project</a>
					</div><!--- end side navbar --->
					<!--- main content --->
					<div class="main">
						<div class="container">
							<div class="card card-container">
								<cfform class="form-horizontal" id="assignProject">
									<cfoutput>
										<h2>Assign Project</h2>
										<!--- fetch the name of the employee who is under engineering department --->
										<cfset VARIABLES.employeeName=APPLICATION.adminService.getEmployeeName()/>
										<div class="form-group">
											<label for="name" class="col-sm-4 control-label">Name*</label>
											<div class="col-sm-8">
												<select class="form-control" id="name" name="employeeName">
														<option value="">-- select --</option>
														<cfloop query="VARIABLES.employeeName">
															<option value="#VARIABLES.employeeName.empId#">#VARIABLES.employeeName.name#</option>
														</cfloop>
												</select>
											</div>
											 <div class="col-sm-4"></div>
											 <div class="col-sm-8"><span class="text-danger" id="nameError">#VARIABLES.assignProjectErrorMessage.employeeName#</span></div>
										</div>

										<!--- fetch the name of the project which are not finished yet --->
										<cfset VARIABLES.projectName=APPLICATION.adminService.getProjectName()/>
										<div class="form-group">
											<label for="project" class="col-sm-4 control-label">Project*</label>
											<div class="col-sm-8">
												<select class="form-control" id="project" name="projectName">
														<option value="">-- select --</option>
														<cfloop query="VARIABLES.projectName">
															<option value="#VARIABLES.projectName.projectId#">#VARIABLES.projectName.projectName#</option>
														</cfloop>
												</select>
											</div>
											 <div class="col-sm-4"></div>
											<div class="col-sm-8"><span class="text-danger" id="projectNameError">#VARIABLES.assignProjectErrorMessage.projectName#</span></div>
										</div>

										<div class="form-group">
											<label for="assignDate" class="col-sm-4 control-label">Assign Date*</label>
											<div class="col-sm-8">
												<input type="date" id="assignDate" name="projectAssignDate" class="form-control">
											</div>
											 <div class="col-sm-4"></div>
											<div class="col-sm-8"><span class="text-danger" id="assignDateError">#VARIABLES.assignProjectErrorMessage.assignDate#</span></div>
										</div>

										<div class="form-group">
											<label for="completionDate" class="col-sm-4 control-label">Completion Date*</label>
											<div class="col-sm-8">
												<input type="date" id="completionDate" name="projectcompletionDate" class="form-control">
											</div>
											 <div class="col-sm-4"></div>
											<div class="col-sm-8"><span class="text-danger" id="completionDateError">#VARIABLES.assignProjectErrorMessage.completionDate#</span></div>
										</div>


									<input type="submit" class="btn btn-primary btn-block" value="Assign Project" name="assignProject"/>
									</cfoutput>
								</cfform>
							</div><!--- end card --->
						</div><!--- end container --->
					</div><!--- end main --->
					<!--- import external javascript --->
					<script type = "text/javascript" src = "../../assets/javaScript/assignProject.js"></script>
			</cf_headerFooter><!--- end header footer custom tag --->
		</cfif><!--- check project assigned or not --->
<cfelse><!--- if employee is not logged in then it will redirect to login page --->
	<cflocation url="adminLogin.cfm">
</cfif>