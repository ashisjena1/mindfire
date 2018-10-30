<cfcomponent output="false">
	<!--- Declare name of the Applcation --->
	<cfset this.name="EmployeeManagementSystem"/>
	<!--- Declare timeout for the Applcation --->
    <cfset this.ApplicationTimeout = "#CreateTimeSpan(1, 0, 0, 0)#"/>
	<!--- Configure the datasource for the Application --->
    <cfset this.datasource = "EmployeeMangementSystem"/>
	<!--- Enable the session management --->
	<cfset this.sessionManagement = true/>
	<!--- Declare the session timeout --->
    <cfset this.sessionTimeout = "#CreateTimeSpan(0, 0, 30, 0)#" />
	<!--- Declaring the path for the custom tag --->
	<cfset this.customTagPaths = expandPath('/customTags')>

	<cffunction name="onApplicationStart" returntype="boolean">
		<cfset APPLICATION.loginService=createObject('component','components.loginService')/>
		<cfset APPLICATION.employeeService=createObject('component','components.employeeService')/>
		<cfset APPLICATION.adminService=createObject('component','components.adminService')/>
		<cfset APPLICATION.personalService=createObject('component','components.personalService')/>
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


