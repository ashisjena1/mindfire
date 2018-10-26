<cfcomponent output="false">
		<cffunction access="public" name="getPassword" output="false" returntype="query">
			<cfargument name="email" type="string" required="yes"/>
			<cfquery name="passwordQuery">
				SELECT password FROM employees WHERE email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.email#"/>
			</cfquery>
			<cfreturn passwordQuery/>
		</cffunction>

		<cffunction name="loginUser" hint="login user" access="public" output="false" returntype="string">
			<cfset var loginErrorMessage=''/>
				<cfif Trim(FORM.email) eq '' or Trim(FORM.password) eq ''>
					<cfset loginErrorMessage='Email and password should be filled'/>
				<cfelseif REFind('^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$',Trim(FORM.email),1) eq 0 or REFind('(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}',FORM.password,1) eq 0>
					<cfset loginErrorMessage='Please enter a valid email address (Ex:abc@cd.com) or a valid password'/>
				<cfelse>
					<cfset var emailPassword = getPassword(FORM.email)/>
					<cfif emailPassword.RecordCount eq 1>
						<cfif emailPassword.password neq FORM.password >
							<cfset loginErrorMessage='Password is incorrect'/>
						</cfif>
					<cfelse>
						<cfset loginErrorMessage='You are not registered yet'/>
					</cfif>
				</cfif>
				<cfreturn loginErrorMessage/>
		</cffunction>

		<cffunction name="doLogin" acces="public" output="false" >
			<cfargument  name="loginEmail" type="string" required="true"/>
			<cfargument  name="loginPassword" type="string" required="true"/>

			<cfquery name="fetchLoginEmployee">
				SELECT emp.empId,emp.firstName,emp.lastName,emp.password,empRole.roleName FROM employees emp join employeeRole empRole
				on emp.roleId = empRole.roleId WHERE
						email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.loginEmail#"/>
						and password =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.loginPassword#"/>
			</cfquery>

			<cfif fetchLoginEmployee.recordCount eq 1>
				<cfset SESSION.setLoggedInUser={'firstName'=fetchloginEmployee.firstName,'lastName'=fetchloginEmployee.lastName,'empId'=fetchloginEmployee.empId,'empRole'=fetchloginEmployee.roleName}/>
			</cfif>
		</cffunction>

		<cffunction name="doLogout" acces="public" output="false" returntype="void">
			<cfset structdelete(SESSION,'setLoggedInUser')>
		</cffunction>
</cfcomponent>
