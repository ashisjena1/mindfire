<!--- Checking for user Login --->
<cfif structKeyExists(SESSION,"setLoggedInUser")>
	<!--- Checking for Logout --->
	<cfif structKeyExists(URL,"logout")>
		<cfset APPLICATION.loginService.doLogout()/>
		<cflocation url="../../index.cfm">
	</cfif>
	<!--- Checking the user is HR or Not --->
	<cfif #SESSION.setLoggedInUser.empRole# eq "HR">
		<cfset VARIABLES.name="#SESSION.setLoggedInUser.firstName# #SESSION.setLoggedInUser.lastName#">
		<!--- Fetch the project list from the project table --->
		<cfset VARIABLES.project=APPLICATION.adminService.getProjectDetails()/>
		<!--- Custom tags for header footer--->
		<cf_headerFooter title="Show Project">
				<!--- Import external style sheet --->
				<link rel="stylesheet" type="text/css" href="../../assets/css/admin.css">
				<link rel="stylesheet" type="text/css" href="../../assets/css/adminPageStyle.css">

			</head>
			<body>
				<!--- Custom tag for top nav bar --->
				<cf_navbar name="#VARIABLES.name#" source="../../assets/images/" homeSource="../"	profileSource="../../common/profile.cfm"></cf_navbar>
				<!--- Side navbar --->
				<div class="sidenav">
					  <a href="addEmployee.cfm">Add Employee</a>
					  <a href="addProject.cfm">Add Project</a>
					  <a href="">Project Details</a>
					  <a href="assignProject.cfm">Assign Project</a>
					  <a href="../../common/applyLeaves.cfm">Apply Leaves</a>
					  <a href="../../common/salary.cfm">Salary</a>
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
				        	<cfoutput query="VARIABLES.project">
					        	<tr>
						        	<td>#VARIABLES.project.projectName#</td>
					        		<td>#VARIABLES.project.manager#</td>
					        		<td>#DateFormat(VARIABLES.project.startDate,"mmm-dd-yyyy")#</td>
					        		<td>#DateFormat(VARIABLES.project.endDate,"mmm-dd-yyyy")#</td>

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