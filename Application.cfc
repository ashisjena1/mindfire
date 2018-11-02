
<cfcomponent accessors="true" output="false" persistent="false">

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
		<!--- Declare name of the Applcation --->

		<cfset APPLICATION.applicationName="Employee Management System"/>
		<cfset APPLICATION.adminService=createObject('component','components.adminService')/>
		<cfset APPLICATION.loginService=createObject('component','components.loginService')/>
		<cfset APPLICATION.employeeService=createObject('component','components.employeeService')/>
		<cfreturn true/>
	</cffunction>
	<cffunction name="onRequestStart" returntype="boolean">
		<cfargument name="targetPage" type="string" required="true"/>
		<cfif isDefined('url.restartApp')>
			<cfset this.onApplicationStart()/>
		</cfif>
		<cfreturn true/>
	</cffunction>

	<cffunction name="onMissingTemplate">
		<cfargument name="targetPage" type="string" required=true/>
		<!--- Use a try block to catch errors. --->
		<cftry>
		<!--- Log all errors. --->
			<cflog type="error" text="Missing template: #Arguments.targetPage#">
			<!--- Display an error message. --->
			<cfoutput>
				<h3>#Arguments.targetPage# could not be found.</h3>
				<p>You requested a non-existent ColdFusion page.<br />
				Please check the URL.</p>
			</cfoutput>
			<cfreturn true />
		<cfcatch>
			<cfreturn false />
		</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="onError">

		<cfargument name="Except" required=true/>
		<cfargument type="String" name = "EventName" required=true/>
		<!--- Log all errors in an application-specific log file. --->
		<cflog file="#This.Name#" type="error" text="Event Name: #Eventname#" >
		<cflog file="#This.Name#" type="error" text="Message: #except.message#">

		<cfmail
			to="vssut.ashis@gmail.com"
			from="ashis.jena96@gmail.com"
			subject="Warnig"
			type="text">
			Dear Ashis

			There is some issue in the code.
			Have a look on it

			<cfoutput>
				<p>Error Event: #EventName#</p>
				<p>Error details:<br>
				#except#></p>
			</cfoutput>

			Best wishes,
			Ashis
		</cfmail>
		<!--- Throw validation errors to ColdFusion for handling. --->
		<cfif Find("coldfusion.filter.FormValidationException", Arguments.Except.StackTrace)>
			<cfthrow object="#except#">
		<cfelse>
		<!--- You can replace this cfoutput tag with application-specific error-handling code. --->
			<cfoutput>
				<p>Error Event: #EventName#</p>
				<p>Error details:<br>
				<cfdump var=#except#></p>
			</cfoutput>
		</cfif>
	</cffunction>

</cfcomponent>

