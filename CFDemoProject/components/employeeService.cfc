

<cfcomponent accessors="true" output="false" persistent="false">
	<!--- Fetch all the employee  data --->
	<cffunction name="getEmployeeDetails" hint="fetch the details of employee" output="false" access="public" returntype="query">
		<cfquery name="employeeDetails">
			SELECT emp.empId,CONCAT(ISNULL(emp.firstName,''),' ',ISNULL(emp.middleName,''),' ',ISNULL(emp.lastName,'')) "Name",
			emp.email,emp.joiningDate,emp.phoneNumber,dept.departmentName,empRole.roleName,emp.basicSalary,
			CASE WHEN emp.isActive = 1 THEN 'Active'
				 WHEN emp.isActive =0 THEN 'Not Active'
			END status
			FROM employees emp JOIN employeeRole empRole ON emp.roleId = empRole.roleId JOIN department dept ON
			empRole.departmentId =dept.departmentId
		</cfquery>
		<cfreturn employeeDetails/>
	</cffunction>

	<!--- Fetch all the manager details --->
	<cffunction name="getManager" hint="fetch the manager name" output="false" access="public" returntype="query">
		<cfquery name="managerDetails">
			SELECT emp.empId,CONCAT(ISNULL(emp.firstName,''),' ',ISNULL(emp.middleName,''),' ',ISNULL(emp.lastName,'')) "Name"
			FROM employees emp JOIN employeeRole empRole ON emp.roleId=empRole.roleId WHERE empRole.roleName = 'MANAGER';
		</cfquery>
		<cfreturn managerDetails/>
	</cffunction>

	<!--- Fetch all employee name who are belong to engineering department --->
	<cffunction name="getEmployeeName" hint="fetch the name of the employee" output="false" access="public" returntype="query">
		<cfquery name="employeeName">
			SELECT emp.empId,CONCAT(ISNULL(emp.firstName,''),' ',ISNULL(emp.middleName,''),' ',ISNULL(emp.lastName,'')) "Name"
			FROM employees emp JOIN employeeRole empRole on emp.roleId = empRole.roleId JOIN department dept on
			empRole.departmentId = dept.departmentId where dept.departmentName = 'ENGINEERING'
		</cfquery>
		<cfreturn employeeName/>
	</cffunction>

	<!--- Fetch project name from project table which are not completed --->
	<cffunction name="getProjectName" hint="fetch the name of the current project" output="false" access="public" returntype="query">
		<cfquery name="projectName">
			SELECT projectId,projectName from project WHERE endDate>getDate()
		</cfquery>
		<cfreturn projectName/>
	</cffunction>
</cfcomponent>