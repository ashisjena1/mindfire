<cfcomponent output="false">
	<cfset this.name="assignment"/>
    <cfset this.applicationTimeout = "#CreateTimeSpan(1, 0, 0, 0)#"/>
    <cfset this.datasource = "Assignments"/>
    <cfset this.sessionManagement = true/>
    <cfset this.sessionTimeout = "#CreateTimeSpan(0, 0, 30, 0)#" />
	<!--- <cfset this.setClientCookies = false/> --->
	<cfset this.customTagPaths = expandPath('/customTags')>

	<cffunction name="onApplicationStart" returntype="boolean">
		<cfset application.loginService=createObject('component','components.loginService')/>
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


