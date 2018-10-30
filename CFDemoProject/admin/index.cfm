
<!--- Checking for user Login--->
<cfif structKeyExists(SESSION,"setLoggedInUser")>
	<!--- Checking for Logout--->
	<cfif structKeyExists(URL,"logout")>
		<cfset APPLICATION.loginService.doLogout()/>
		<cflocation url="../index.cfm">
	</cfif>
	<!--- Checking the user is HR or Not --->
	<cfif #UCase(SESSION.setLoggedInUser.empRole)# EQ "HR">
		<cfset name="#SESSION.setLoggedInUser.firstName# #SESSION.setLoggedInUser.lastName#">
		<!--- Custom Tag for header and footer--->
		<cf_headerFooter title="Admin page">
				<!--- import the admin stylesheet --->
				<link rel="stylesheet" type="text/css" href="../assets/css/admin.css">

			</head>
			<body class>
				<!--- custom Tag for top navBar --->
				<cf_navbar name="#name#" source="../assets/images/" profileSource="views/profile.cfm"></cf_navbar>
				<!--- Side navbar --->
				<div class="sidenav">
				  <a href="views/addEmployee.cfm">Add Employee</a>
				  <a href="views/addProject.cfm">Add Project</a>
				  <a href="views/projectDetails.cfm">Project Details</a>
				  <a href="views/assignProject.cfm">Assign Project</a>
				  <a href="views/applyLeaves.cfm">Apply Leaves</a>
				  <a href="views/salary.cfm">Salary</a>
				</div><!--- end side navbar --->
				<!--- main content --->
				<div class="main">
					<!--- Fetch the employee Details from the table --->
					<cfset employees=APPLICATION.employeeService.getEmployeeDetails()/>
					<h3 class="text-center">Employee Details</h3>
					<!--- Data Tables for the employee Data --->
					<table id="showEmployees" class="display">
						<thead>
				            <tr>
				                <th>Employee ID</th>
				                <th>Employee Name</th>
				                <th>Email</th>
				                <th>Date Of Joining</th>
				                <th>Phone Number</th>
				                <th>Department</th>
				                <th>Role</th>
				                <th>Basic Salary</th>
				                <th>status</th>
				            </tr>
					    </thead>
						<tbody>
							<!--- Loop over the employee Details --->
					        <cfoutput query="employees">
						       	<tr>
						        	<td>#employees.empId#</td>
					        		<td>#employees.name#</td>
					        		<td>#employees.email#</td>
					        		<td>#DateFormat(employees.joiningDate,"mmm-dd-yyyy")#</td>
					        		<td>#employees.phoneNumber#</td>
					        		<td>#employees.departmentName#</td>
					        		<td>#employees.roleName#</td>
					        		<td>#employees.basicSalary#</td>
					        		<td>#employees.status#</td>
								 </tr>
					        </cfoutput>
						</tbody>
						</table><!--- end table --->
					</div><!--- end main --->

			<!--- import the admin script --->
			<script type = "text/javascript" src = "../assets/javaScript/admin.js"></script>
		</cf_headerFooter>
	<cfelse><!--- if employee is not hr then it will show a message --->
		You are not authorized to open this page.
	</cfif>
<!--- If employee notlogged in it will redirect to login page --->
<cfelse>
	<cflocation url="../index.cfm">
</cfif>