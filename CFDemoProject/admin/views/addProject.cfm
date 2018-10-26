<cfif structKeyExists(SESSION,'setLoggedInUser')>
	<cfif structKeyExists(URL,'logout')>
		<cfset APPLICATION.userService.doLogout()/>
		<cflocation url="../../index.cfm">
	</cfif>
	<cfif #SESSION.setLoggedInUser.empRole# eq "HR">
		<cfset name="#SESSION.setLoggedInUser.firstName# #SESSION.setLoggedInUser.lastName#">
		<cfparam name="isProjectAdded" default="false">

		<cfif not structKeyExists(FORM,'addProject')>
			<cfset addProjectErrorMessage={projectName='',managerName='',startDate='',endDate=''}/>
		<cfelse>
			<cfset addProjectErrorMessage=APPLICATION.adminService.checkProjectDetails()/>
			<cfif addProjectErrorMessage.projectName eq ''  and addProjectErrorMessage.managerName eq '' and
					addProjectErrorMessage.startDate eq '' and addProjectErrorMessage.endDate eq ''>
					<cfset isProjectAdded = APPLICATION.adminService.addProject(FORM.projectName,FORM.managerID,FORM.projectStartDate,FORM.projectEndDate)/>
			</cfif>
		</cfif>

		<cfif isProjectAdded>
			<cflocation url="../index.cfm">
		<cfelse>

			<cf_headerFooter title="Add Project">
				<link rel="stylesheet" type="text/css" href="../../assets/css/admin.css">
				<link rel="stylesheet" type="text/css" href="../../assets/css/addEmployee.css">
				<script type = "text/javascript" src = "../../assets/javaScript/addProject.js"></script>
				</head>
				<body>
					<cf_navbar name="#name#" source="../../assets/images/"></cf_navbar>
					<div class="container">
						<div class="card card-container">
							<cfform class="form-horizontal" id="addProject">
								<cfoutput>
								<h2>Add New Project</h2>
								<div class="form-group">
									<cfif isProjectAdded>
										<span class="text-success"><h4>Project Added successfully</h4></span>
									</cfif>
									<label for="projectName" class="col-sm-4 control-label">Project Name*</label>
									<div class="col-sm-8">
										<input type="text" id="projectName" name="projectName" placeholder="Project Name" class="form-control" >
									</div>
									<div class="col-sm-4"></div>
									<div class="col-sm-8"><span class="text-danger" id="projectNameError">#addProjectErrorMessage.projectName#</span></div>
								</div>
								<cfset manager=Application.employeeService.getManager()/>
								<div class="form-group">
									<label for="managerName" class="col-sm-4 control-label">Project Manger*</label>
									<div class="col-sm-8">
										<select class="form-control" id="managerName" name="managerID">
												<option value="">-- select --</option>
												<cfloop query="manager">
													<option value="#manager.empId#">#manager.name#</option>
												</cfloop>
										</select>
									</div>
									 <div class="col-sm-4"></div>
									<div class="col-sm-8"><span class="text-danger" id="projectManagerError">#addProjectErrorMessage.managerName#</span></div>
								</div>
								<div class="form-group">
									<label for="startDate" class="col-sm-4 control-label">Start Date*</label>
									<div class="col-sm-8">
										<input type="date" id="startDate" name="projectStartDate" class="form-control">
									</div>
									 <div class="col-sm-4"></div>
									<div class="col-sm-8"><span class="text-danger" id="projectStartDateError">#addProjectErrorMessage.startDate#</span></div>
								</div>
								<div class="form-group">
									<label for="endDate" class="col-sm-4 control-label">End Date*</label>
									<div class="col-sm-8">
										<input type="date" id="endDate" name="projectEndDate" class="form-control">
									</div>
									 <div class="col-sm-4"></div>
									<div class="col-sm-8"><span class="text-danger" id="projectEndDateError">#addProjectErrorMessage.endDate#</span></div>
								</div>
								<input type="submit" class="btn btn-primary btn-block" value="Add Project" name="addProject"/>
							</cfoutput>
							</cfform>
						</div>

					 </div>
			</cf_headerFooter>
		</cfif>
	<cfelse>
		You are not authorized to open this page.
	</cfif>
<cfelse>
	<cflocation url="../index.cfm">
</cfif>