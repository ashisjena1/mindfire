
<cfcomponent accessors="true" output="false" persistent="false">

	<cffunction name="getEmployeeDetails" hint="fetch the details of employee" output="false" access="public" returntype="query">
		<cfquery name="employeeDetails">
			SELECT emp.empId "EmployeeID",concat(isNull(emp.firstName,''),' ',isNull(emp.middleName,''),' ',isNull(emp.lastName,'')) "Name",emp.joiningDate "JoiningDate",dept.departmentName "Department"
			FROM employees emp join department dept on emp.departmentId = dept.departmentId
		</cfquery>
		<cfreturn employeeDetails/>
	</cffunction>

	<cffunction name="getManager" hint="fetch the manager details" output="false" access="public" returntype="query">
		<cfquery name="managerDetails">
			select empId,concat(isNull(emp.firstName,''),' ',isNull(emp.middleName,''),' ',isNull(emp.lastName,'')) "Name"
			FROM employees emp join employeeRole empRole on emp.roleId=empRole.roleId WHERE empRole.roleName = 'MANAGER';
		</cfquery>
		<cfreturn managerDetails/>
	</cffunction>
</cfcomponent>