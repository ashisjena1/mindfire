<!--- Checking for user Login --->
<cfif structKeyExists(SESSION,"setLoggedInUser")>
	<!--- Checking for Logout --->
	<cfif structKeyExists(URL,"logout")>
		<cfset APPLICATION.loginService.doLogout()/>
		<cflocation url="../index.cfm">
	</cfif>

		<cfset VARIABLES.name="#SESSION.setLoggedInUser.firstName# #SESSION.setLoggedInUser.lastName#">


			<cf_headerFooter title="Salary Details">
				<!--- Import external stylesheet --->
				<link rel="stylesheet" type="text/css" href="../../assets/css/admin.css">
				<link rel="stylesheet" type="text/css" href="../../assets/css/adminPageStyle.css">

				</head>
				<body>
					<!--- custom tag for top nav bar --->
					<cf_navbar name="#VARIABLES.name#" source="../assets/images/" homeSource="../" profileSource="profile.cfm"></cf_navbar>
					<!--- Side navbar --->
					<div class="sidenav">

					 	<cfif #UCase(SESSION.setLoggedInUser.empRole)# EQ "HR">
					  		<a href="../admin/views/addEmployee.cfm">Add Employee</a>
					  		<a href="../admin/views/addProject.cfm">Add Project</a>
					  		<a href="../admin/views/projectDetails.cfm">Project Details</a>
					  		<a href="../admin/views/assignProject.cfm">Assign Project</a>
					 	</cfif>
					  	<a href="applyLeaves.cfm">Apply Leaves</a>
					 	<a href="">Salary</a>

					</div><!--- end side navbar --->
					<!--- main content --->
					<div class="main">
						<cfset salaryDetails = APPLICATION.personalService.getSalaryDetails(SESSION.setLoggedInUser.empId)/>

						<table id="showSalary" class="display">
							<thead>
					            <tr>

					                <th>Credit Date</th>
					                <th>Basic Salary</th>
					                <th>Home Rent Allowance</th>
					                <th>Other Allowances</th>
					                <th>Deduction</th>
					                <th>Total</th>
					            </tr>
						    </thead>
							<tbody>
								<!--- Loop over the Salary Details --->
						        <cfoutput query="salaryDetails">
							       	<tr>
								       	<td>#DateFormat(salaryDetails.creditdate,"mmm-dd-yyyy")#</td>
							        	<td>#salaryDetails.basicSalary#</td>
						        		<td>#salaryDetails.hra#</td>
						        		<td>#salaryDetails.otherAllowances#</td>
						        		<td>#salaryDetails.deduction#</td>
						        		<td>#salaryDetails.total#</td>

									 </tr>
						        </cfoutput>
							</tbody>
						</table><!--- end table --->
					</div><!--- end main --->
					<!--- import external javascript --->
					<script type = "text/javascript">
					$(document).ready(function() {
						$("#showSalary").DataTable();
					});
			</script>
			</cf_headerFooter><!--- end header footer custom tag --->

<cfelse><!--- if employee is not logged in then it will redirect to login page --->
	<cflocation url="../index.cfm">
</cfif>











