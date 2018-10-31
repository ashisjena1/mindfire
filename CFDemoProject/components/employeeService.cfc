

<cfcomponent accessors="true" output="false" persistent="false">
	<!--- Fetch all the employee  data --->
	<cffunction name="getEmployeeDetails" hint="fetch the details of employee" output="false" access="public" returntype="query">
		<cftry>
		<!--- <cfargument name="search" type="string" required="false"/> --->
			<cfquery name="employeeDetails">
				SELECT emp.empId,CONCAT(ISNULL(emp.firstName,''),' ',ISNULL(emp.middleName,''),' ',ISNULL(emp.lastName,'')) "Name",
				emp.email,emp.joiningDate,emp.phoneNumber,dept.departmentName,empRole.roleName,emp.basicSalary,
					CASE WHEN emp.isActive = 1 THEN 'Active'
						 WHEN emp.isActive =0 THEN 'Not Active'
					END status
				FROM employees emp JOIN employeeRole empRole ON emp.roleId = empRole.roleId JOIN department dept ON
				empRole.departmentId =dept.departmentId where emp.email LIKE '%%'
				<cfoutput>
					<cfif structKeyExists(FORM,"department")>
						AND UPPER(dept.departmentName) LIKE <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="%#Ucase(FORM.search)#%"/>
					</cfif>
					<cfif structKeyExists(FORM,"name")>
						AND (UPPER(emp.firstName) LIKE <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="%#Ucase(FORM.search)#%"/> OR
						UPPER(emp.lastName) LIKE <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="%#Ucase(FORM.search)#%"/> OR
						UPPER(emp.middleName) LIKE <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="%#Ucase(FORM.search)#%"/>)
					</cfif>
					<cfif structKeyExists(FORM,"empId")>
						AND emp.EmpId like <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#FORM.search#"/>
					</cfif>
				</cfoutput>
		</cfquery>
		<cfcatch type="Database">	<!--- catch block for database exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Database Error on component : employeeService on function : getEmployeeDetails"/>
			<cflocation url="../common/error.cfm">
		</cfcatch>	<!--- end database exception --->
		<cfcatch type="any">	<!--- catch block for any exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Any Error on component : employeeService on function : getEmployeeDetails "/>
			<cflocation url="../common/error.cfm">
		</cfcatch>	<!--- end any exception --->
		</cftry>	<!--- end dtry block --->
		<cfreturn employeeDetails/>
	</cffunction>

	<!--- Fetch all the manager details --->
	<cffunction name="getManager" hint="fetch the manager name" output="false" access="public" returntype="query">
		<cftry>		<!--- try block for handle exception --->
			<cfquery name="managerDetails">
				SELECT emp.empId,CONCAT(ISNULL(emp.firstName,''),' ',ISNULL(emp.middleName,''),' ',ISNULL(emp.lastName,'')) "Name"
				FROM employees emp JOIN employeeRole empRole ON emp.roleId=empRole.roleId WHERE empRole.roleName = 'MANAGER';
			</cfquery>
		<cfcatch type="Database">	<!--- catch block for database exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Database Error on component : employeeService on function : getManager"/>
			<cflocation url="../../common/error.cfm">
		</cfcatch>	<!--- end database exception --->
		<cfcatch type="any">	<!--- catch block for any exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Any Error on component : employeeService on function : getManager "/>
			<cflocation url="../../common/error.cfm">
		</cfcatch>	<!--- end any exception --->
		</cftry>	<!--- end dtry block --->
		<cfreturn managerDetails/>
	</cffunction>

	<!--- Fetch all employee name who are belong to engineering department --->
	<cffunction name="getEmployeeName" hint="fetch the name of the employee" output="false" access="public" returntype="query">
		<cftry>		<!--- try block for handle exception --->
			<cfquery name="employeeName">
				SELECT emp.empId,CONCAT(ISNULL(emp.firstName,''),' ',ISNULL(emp.middleName,''),' ',ISNULL(emp.lastName,'')) "Name"
				FROM employees emp JOIN employeeRole empRole on emp.roleId = empRole.roleId JOIN department dept on
				empRole.departmentId = dept.departmentId where dept.departmentName = 'ENGINEERING'
			</cfquery>
		<cfcatch type="Database">	<!--- catch block for database exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Database Error on component : employeeService on function : getEmployeeName"/>
			<cflocation url="../../common/error.cfm">
		</cfcatch>	<!--- end database exception --->
		<cfcatch type="any">	<!--- catch block for any exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Any Error on component : employeeService on function : getEmployeeName "/>
			<cflocation url="../../common/error.cfm">
		</cfcatch>	<!--- end any exception --->
		</cftry>	<!--- end dtry block --->
		<cfreturn employeeName/>
	</cffunction>

	<!--- Fetch project name from project table which are not completed --->
	<cffunction name="getProjectName" hint="fetch the name of the current project" output="false" access="public" returntype="query">

		<cftry>		<!--- try block for handle exception --->
			<cfquery name="projectName">
				SELECT projectId,projectName from project WHERE endDate >= getDate()
			</cfquery>
		<cfcatch type="Database">	<!--- catch block for database exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Database Error on component : employeeService on function : getProjectName"/>
			<cflocation url="../../common/error.cfm">
		</cfcatch>	<!--- end database exception --->
		<cfcatch type="any">	<!--- catch block for any exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Any Error on component : employeeService on function : getProjectName "/>
			<cflocation url="../../common/error.cfm">
		</cfcatch>	<!--- end any exception --->
		</cftry>	<!--- end dtry block --->

		<cfreturn projectName/>
	</cffunction>

</cfcomponent>