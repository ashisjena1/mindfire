
<!--- Checking for user Login--->
<cfif structKeyExists(SESSION,"setAdmin")>
	<!--- Checking for Logout--->
	<cfif structKeyExists(URL,"logout")>
		<cfset APPLICATION.adminService.doLogout()/>
		<cflocation url="views/adminLogin.cfm">
	</cfif>

	<cf	<cfset VARIABLES.name="#SESSION.setAdmin.firstName# #SESSION.setAdmin.lastName#">
		<!--- Custom Tag for header and footer--->
		<cf_headerFooter title="Admin page">
				<!--- import the admin stylesheet --->
				<link rel="stylesheet" type="text/css" href="../assets/css/admin.css">
			</head>
			<body>
				<!--- custom Tag for top navBar --->
				<cf_navbar name="#VARIABLES.name#" source="../assets/images/"></cf_navbar>
				<!--- Side navbar --->
				<div class="sidenav">
				  <a href="views/addEmployee.cfm">Add Employee</a>
				  <a href="">Employee Details</a>
				  <a href="views/addProject.cfm">Add Project</a>
				  <a href="views/projectDetails.cfm">Project Details</a>
				  <a href="views/assignProject.cfm">Assign Project</a>
				</div><!--- end side navbar --->
				<!--- main content --->
				<div class="main">
					<!--- Fetch the employee Details from the table --->
					<cfset VARIABLES.employees=APPLICATION.adminService.getEmployeeDetails()/>
					<h3 class="text-center">Employee Details</h3>
					<br/><br/>
					<div class="row">
						<div class="col-md-3"></div>
						<div class="col-md-7">
							<cfform name="searchForm">
							<div class="row">
								<label class="col-md-3 checkbox-inline"><input type="checkbox" id="empId" name="empId">Employee Id</label>
								<label class="col-md-2 checkbox-inline"><input type="checkbox" id="name" name="name">Name</label>
								<label class="col-md-2 checkbox-inline"><input type="checkbox" id="dept" name="department">Department</label>
  								<span class="col-md-3"><input type="text" name="search" class = "form-control"></span>
								<span class="col-md-1">
									<button type="submit" id="search" name="searchButton" class="btn">Search</button>
								</span>
							</div>
							</cfform>
						</div>
						<cfform action="views/employeeDetails.cfm" target = "_blank">
							<cfset SESSION.employees="#VARIABLES.employees#">
							<span class="col-md-2"><button id = "download" class="btn btn-success pull-right">Download</button></span>
						</cfform>
					</div>

					<!--- Data Tables for the employee Data --->
					<br/><br/>
					<table id="showEmployees" class="displayTable">
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
					        <cfoutput query="VARIABLES.employees">
						       	<tr>
						        	<td><a href="views/editEmployee.cfm?id=#VARIABLES.employees.empId#">#VARIABLES.employees.empId#</a></td>
					        		<td>#VARIABLES.employees.name#</td>
					        		<td>#VARIABLES.employees.email#</td>
					        		<td>#DateFormat(VARIABLES.employees.joiningDate,"mmm-dd-yyyy")#</td>
					        		<td>#VARIABLES.employees.phoneNumber#</td>
					        		<td>#VARIABLES.employees.departmentName#</td>
					        		<td>#VARIABLES.employees.roleName#</td>
					        		<td>#VARIABLES.employees.basicSalary#</td>
					        		<td>#VARIABLES.employees.status#</td>
								 </tr>
					        </cfoutput>
						</tbody>
						</table><!--- end table --->
					</div><!--- end main --->

			<!--- import the admin script --->
			<script type = "text/javascript" src = "../assets/javaScript/admin.js"></script>
		</cf_headerFooter>
<!--- If employee not logged in it will redirect to login page --->
<cfelse>
	<cflocation url="views/adminLogin.cfm">
</cfif>