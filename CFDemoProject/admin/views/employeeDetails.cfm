<!--- Checking for user Login--->
<cfif structKeyExists(SESSION,"setLoggedInUser")>
	<cfparam name="VARIABLE.show" default="false">
	<cfif structKeyExists(SESSION,"employees")>
		<cfset VARIABLE.employees = "#SESSION.employees#"/>
		<cfset structdelete(SESSION,"employees")>
		<cfset VARIABLE.show="true">
	</cfif>

	<cfset VARIABLES.name="#SESSION.setLoggedInUser.firstName# #SESSION.setLoggedInUser.lastName#">
	<cfdocument format="PDF">

		<html>
		<head>
			<style>
				table {
		    		border-collapse: collapse;
					width : 100%;
				}
				table, th, td {
		    		border: 1px solid black;
				}
				th{
					height:50px;
				}
				h1{
					text-align: center;
				}
				h4{
					text-align: right;
				}
			</style>
		</head>

		<cfoutput>
			<div style="margin:30px">
			   	<h1>#APPLICATION.applicationName#</h1>
				<h4 style="  margin-bottom : 2px;">#dateformat(now(), "short")#</h4>
				<h4 style=" text-align: right; margin-top : 2px;">#VARIABLES.name#</h4>
				<h2>Employee Details</h2>
				<table style="text-align: center;">

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

				            </tr>
					    </thead>
						<cfif VARIABLE.show>
							<tbody>
								<!--- Loop over the employee Details --->
						        <cfloop query="VARIABLE.employees">
							       	<tr>
							        	<td>#VARIABLE.employees.empId#</td>
						        		<td>#VARIABLE.employees.name#</td>
						        		<td>#VARIABLE.employees.email#</td>
						        		<td>#DateFormat(VARIABLE.employees.joiningDate,"mmm-dd-yyyy")#</td>
						        		<td>#VARIABLE.employees.phoneNumber#</td>
						        		<td>#VARIABLE.employees.departmentName#</td>
						        		<td>#VARIABLE.employees.roleName#</td>
						        		<td>#VARIABLE.employees.basicSalary#</td>

									 </tr>
						        </cfloop>
							</tbody>
						</cfif>
					</table><!--- end table --->
			</div>
		  </cfoutput>
		</html>
	 </cfdocument>
</cfif>