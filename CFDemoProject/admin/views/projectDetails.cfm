<!--- Checking for user Login --->
<cfif structKeyExists(SESSION,"setLoggedInUser")>
	<!--- Checking for Logout --->
	<cfif structKeyExists(URL,"logout")>
		<cfset APPLICATION.loginService.doLogout()/>
		<cflocation url="../../index.cfm">
	</cfif>
	<!--- Checking the user is HR or Not --->
	<cfif #SESSION.setLoggedInUser.empRole# eq "HR">
		<cfset name="#SESSION.setLoggedInUser.firstName# #SESSION.setLoggedInUser.lastName#">
		<!--- Fetch the project list from the project table --->
		<cfset project=APPLICATION.adminService.getProjectDetails()/>
		<!--- Custom tags for header footer--->
		<cf_headerFooter title="Show Project">
				<!--- Import external style sheet --->
				<link rel="stylesheet" type="text/css" href="../../assets/css/admin.css">
				<link rel="stylesheet" type="text/css" href="../../assets/css/adminPageStyle.css">

			</head>
			<body>
				<!--- Custom tag for top nav bar --->
				<cf_navbar name="#name#" source="../../assets/images/" homeSource="../"	profileSource="profile.cfm"></cf_navbar>
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
					<h3 class="text-center">Project Details</h3>
					<!--- Data Tables for the project Data --->
					<table id="projectDetails" class="display">
						<thead>
				            <tr>
				                <th>Project Name</th>
				                <th>Manager</th>
				                <th>Start Date</th>
				                <th>End Date</th>
				            </tr>
				        </thead>
						<tbody>
							<!--- Loop over the project Details --->
				        	<cfoutput query="project">
					        	<tr>
						        	<td>#project.projectName#</td>
					        		<td>#project.manager#</td>
					        		<td>#DateFormat(project.startDate,"mmm-dd-yyyy")#</td>
					        		<td>#DateFormat(project.endDate,"mmm-dd-yyyy")#</td>

							 	</tr>
				        	</cfoutput>
						</tbody>
					</table><!--- end table --->
				</div><!--- end main --->

			<script type = "text/javascript">
					$(document).ready(function() {
						$("#projectDetails").DataTable();
					});
			</script>
		</cf_headerFooter>
	<cfelse>
		You are not authorized to open this page.
	</cfif>
<!--- If employee notlogged in it will redirect to login page --->
<cfelse>
	<cflocation url="../../index.cfm">
</cfif>