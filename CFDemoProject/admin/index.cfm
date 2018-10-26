<cfif structKeyExists(URL,'logout')>
	<cfset APPLICATION.userService.doLogout()/>
	<cflocation url="../index.cfm">
</cfif>
<cfif structKeyExists(SESSION,'setLoggedInUser')>
	<cfset name="#SESSION.setLoggedInUser.firstName# #SESSION.setLoggedInUser.lastName#">
<cf_headerFooter title="Admin page">
		<link rel="stylesheet" type="text/css" href="../assets/css/admin.css">
		<script type = "text/javascript" src = "../assets/javaScript/admin.js"></script>
		</head>
		<body class>
			<cf_navbar name="#name#" source="../assets/images/"></cf_navbar>
				<div class="sidenav">
				  <a href="views/addEmployee.cfm">Add Employee</a>
				  <a href="views/addProject.cfm">Add Project</a>
				</div>
				<div class="main">
					<cfset employees=Application.employeeService.getEmployeeDetails()/>
					<table id="example" class="display" width="100%">
						<thead>
				            <tr>
				                <th>Employee ID</th>
				                <th>Employee Name</th>
				                <th>Date Of Joining</th>
				                <th>Department</th>
				            </tr>
				        </thead>
						<tbody>
				        	<cfoutput query="employees">
					        	<tr>
						        	<td>#employees.employeeId#</td>
					        		<td>#employees.name#</td>
					        		<td>#employees.joiningDate#</td>
					        		<td>#employees.department#</td>
							 	</tr>
				        	</cfoutput>
						</tbody>
					</table>
				</div>
	</cf_headerFooter>
<cfelse>
	<cflocation url="../index.cfm">
</cfif>