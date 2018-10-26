	<cfcomponent output="false">
	<cfset this.name="EmployeeManagementSystem"/>
    <cfset this.ApplicationTimeout = "#CreateTimeSpan(1, 0, 0, 0)#"/>
    <cfset this.datasource = "EmployeeMangementSystem"/>
	<cfset this.sessionManagement = true/>
    <cfset this.sessionTimeout = "#CreateTimeSpan(0, 0, 30, 0)#" />
	<cfset this.customTagPaths = expandPath('/customTags')>

	<cffunction name="onApplicationStart" returntype="boolean">
		<cfset Application.userService=createObject('component','components.userService')/>
		<cfset Application.employeeService=createObject('component','components.employeeService')/>
		<cfset Application.adminService=createObject('component','components.adminService')/>
		<cfreturn true/>
	</cffunction>
	<cffunction name="onRequestStart" returntype="boolean">
		<cfargument name="targetPage" type="string" required="true"/>
		<cfif isDefined('url.restartApp')>
			<cfset this.onApplicationStart()/>
		</cfif>
		<cfreturn true/>
	</cffunction>
</cfcomponent>


