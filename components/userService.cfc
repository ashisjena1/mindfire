<cfcomponent accessors="true" output="false" persistent="false">

	<cffunction name="getAllInfo" displayname="Information about user" hint="Fetch all details about user" access="public" output="false">
		<cfargument name="employeeId" type="numeric" required="true"/>
		<!--- TODO: Implement Method --->
		<cftry>		<!--- try block for handle exception --->
			<cfquery name="userDetails">
				SELECT CONCAT(e.firstName,' ',e.middleName,' ',e.lastName) manager,dept.departmentName,empRole.roleName,
				proj.projectName,skill.skillName
 				FROM
				employees emp JOIN employeeRole empRole ON emp.roleId = empRole.roleId JOIN department dept ON
				empRole.departmentId = dept.departmentId JOIN employees e on dept.departmentHead = e.empId JOIN
				employeeProject empProject ON emp.empId = empProject.empId JOIN project proj ON empProject.projectId = proj.projectId
				JOIN employeeSkills empSkills ON emp.empId = empSkills.empId JOIN skills skill ON empSkills.skillId = skill.skillId
				WHERE  empProject.projectFinishDate >= GETDATE() AND emp.empId =
				<cfqueryparam cfsqltype="CF_SQL_INT" value="#ARGUMENTS.employeeId#"/>

			</cfquery>
		<cfcatch type="Database">	<!--- catch block for database exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Database Error on component : personalService on function : getPersonalDetail"/>
			<cflocation url="error.cfm">
		</cfcatch>	<!--- end database exception --->
		<cfcatch type="any">	<!--- catch block for any exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Any Error on component : personalService on function : getPersonalDetail "/>
			<cflocation url="error.cfm">
		</cfcatch>	<!--- end any exception --->
		</cftry>	<!--- end dtry block --->
		<cfreturn personalDetails/>
		<cfreturn userDetails/>
	</cffunction>

</cfcomponent>