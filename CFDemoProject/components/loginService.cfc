<cfcomponent output="false">

			<!--- check for user login data --->
			<cffunction access="public" name="checkLoginUser" output="false" returntype="boolean">
				<cfargument name="email" type="string" required="yes"/>
				<cfargument name="password" type="string" required="yes"/>
				<cftry>
					<cfquery name="loginUser">
						SELECT * FROM employees WHERE email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.email#"/> AND
													password = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.password#"/>
					</cfquery>
				<cfcatch type="Database">
					<cflog file="EmployeeManagementSystemLog" application="no" text="Database Error on function : checkLoginUser & User : #ARGUMENTS.email#"/>
					<cflocation url="common/error.cfm">
				</cfcatch>
				<cfcatch type="any">
					<cflog file="EmployeeManagementSystemLog" application="no" text="Any Error on function : checkLoginUser & User : #ARGUMENTS.email#"/>
					<cflocation url="common/error.cfm">
				</cfcatch>
				</cftry>
				<cfif loginUser.recordCount EQ 1>
					<cfreturn true/>
				</cfif>
				<cfreturn false/>
			</cffunction>

			<!--- check for login input --->

			<cffunction name="loginUser" hint="login user" access="public" output="false" returntype="string">
				<cfset var loginErrorMessage=''/>
					<cfif Trim(FORM.email) eq '' or Trim(FORM.password) eq ''>
						<cfset loginErrorMessage='Email and password should be filled'/>
					<cfelseif REFind('^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$',Trim(FORM.email),1) eq 0 or REFind('(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}',FORM.password,1) eq 0>
						<cfset loginErrorMessage='Please enter a valid email address (Ex:abc@cd.com) or a valid password'/>
					<cfelse>
						<cfset var loginUser = checkLoginUser(FORM.email,FORM.password)/>
						<cfif not loginUser>
							<cfset loginErrorMessage='Email or password is incorrect'/>
						</cfif>
					</cfif>
					<cfreturn loginErrorMessage/>
			</cffunction>

			<!--- create a seesion for logged in user --->
			<cffunction name="doLogin" acces="public" output="false" >
				<cfargument  name="loginEmail" type="string" required="true"/>
				<cfargument  name="loginPassword" type="string" required="true"/>
				<cftry>
					<cfquery name="fetchLoginEmployee">
						SELECT emp.empId,emp.firstName,emp.lastName,emp.password,empRole.roleName FROM employees emp JOIN employeeRole empRole
						ON emp.roleId = empRole.roleId WHERE
								email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.loginEmail#"/>
								and password =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.loginPassword#"/>
					</cfquery>
					<cfif fetchLoginEmployee.recordCount eq 1>
						<cfset SESSION.setLoggedInUser={'firstName'=fetchloginEmployee.firstName,'lastName'=fetchloginEmployee.lastName,'empId'=fetchloginEmployee.empId,'empRole'=fetchloginEmployee.roleName}/>
					</cfif>
					<cfcatch type="Database">
						<cflog file="EmployeeManagementSystemLog" application="no" text="Database Error on function : doLogin & User : #ARGUMENTS.loginEmail# "/>
						<cflocation url="common/error.cfm">
					</cfcatch>
					<cfcatch type="any">
						<cflog file="EmployeeManagementSystemLog" application="no" text="Any Error on function : checkLoginUser & User : #ARGUMENTS.loginEmail#"/>
						<cflocation url="common/error.cfm">
					</cfcatch>
				</cftry>

				</cffunction>

			<!--- logout functionality --->
			<cffunction name="doLogout" acces="public" output="false" returntype="void">
				<cfset structdelete(SESSION,'setLoggedInUser')>
			</cffunction>
</cfcomponent>
