<cfcomponent output="false">
		<cffunction access="public" name="checkEmail" output="false" returntype="boolean">
			<cfargument name="email" type="string" required="yes"/>
			<cfquery name="emailQuery">
				select * from employees where email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.email#"/>
			</cfquery>
			<cfif emailQuery.RecordCount eq 1>
				<cfreturn true>
			</cfif>
			<cfreturn false/>
		</cffunction>

		<cffunction access="public" name="checkPassword" output="false" returntype="boolean">
			<cfargument name="email" type="string" required="yes"/>
			<cfargument name="password" type="string" required="yes"/>
			<cfquery name="passwordQuery">
				select password from employees where email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.email#"/>
			</cfquery>
			<cfif emailQuery.RecordCount eq 1 and passwordQuery.password eq #arguments.password#>
				<cfreturn true>
			</cfif>
			<cfreturn false/>
		</cffunction>

		<cffunction name="registerUser" hint="register new user" access="public" output="false" returntype="struct">
				<cfset errorMessage={firstName='',lastName='',email='',phoneNumber='',password='',cPassword=''}/>

					<cfset var condition=true/>
					<cfif Trim(form.firstName) eq ''>
						<cfset errorMessage.firstName='First name should not be empty'/>
						<cfset condition=false/>
					<cfelseif REMatch('[a-zA-Z]+',Trim(form.firstName))[1] neq Trim(form.firstName)>
						<cfset errorMessage.firstName='First name should contain only alphabet'/>
						<cfset condition=false/>
					<cfelse>
						<cfset errorMessage.firstName=''/>
					</cfif>

					<cfif Trim(form.lastName) eq ''>
						<cfset errorMessage.lastName='Last name should not be empty'/>
						<cfset condition=false/>
					<cfelseif REMatch('[a-zA-Z]+',Trim(form.lastName))[1] neq Trim(form.lastName)>
						<cfset errorMessage.lastName='Last name should contain only alphabet'/>
						<cfset condition=false/>
					<cfelse>
						<cfset errorMessage.lastName=''/>
					</cfif>

					<cfif Trim(form.email) eq ''>
						<cfset errorMessage.email='Email should not be empty'/>
						<cfset condition=false/>
					<cfelseif REFind('^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$',Trim(form.email),1) eq 0>
						<cfset errorMessage.email='Please enter a valid email address (Ex:abc@cd.com)'/>
						<cfset condition=false/>
					<cfelseif checkEmail(form.email) >
						<cfset errorMessage.email='You alredy registered'/>
						<cfset condition=false/>
					<cfelse>
						<cfset errorMessage.email=''/>
					</cfif>

					<cfif Trim(form.phoneNumber) eq ''>
						<cfset errorMessage.phoneNumber='PhoneNumber should not be empty'/>
						<cfset condition=false/>
					<cfelseif REFind('^[1-9][0-9]{9}$',Trim(form.phoneNumber),1) eq 0>
						<cfset errorMessage.phoneNumber='Phone number must be 10 numbers (Ex:98XXXXXX66)'/>
						<cfset condition=false/>
					<cfelse>
						<cfset errorMessage.phoneNumber=''/>
					</cfif>
					<cfif Trim(form.password) eq ''>
						<cfset errorMessage.password='password should not be empty'/>
						<cfset condition=false/>
					<cfelseif REFind('(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}',form.password,1) eq 0>
						<cfset errorMessage.password='Password must contain at least 8 characters, including UPPER/lowercase and numbers'/>
						<cfset condition=false/>
					<cfelse>
						<cfset errorMessage.password=''/>
					</cfif>
					<cfif Trim(form.cPassword) eq ''>
						<cfset errorMessage.cPassword='Confirm password should not be empty'/>
						<cfset condition=false/>
					<cfelseif REFind('(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}',form.cPassword,1) eq 0>
						<cfset errorMessage.cPassword='Password must contain at least 8 characters, including UPPER/lowercase and numbers'/>
						<cfset condition=false/>
					<cfelseif form.password neq form.cPassword>
						<cfset errorMessage.cPassword='Confirm Password should match with the password'/>
						<cfset condition=false/>
					<cfelse>
						<cfset errorMessage.cPassword=''/>
					</cfif>
					<cfif condition>
						<cfquery>
							insert into Employees(firstName,lastName,email,phoneNumber,password,gender)
							values(<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.firstName#">,
				         		   <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.lastName#"/>,
									<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.email#"/>,
									<cfqueryparam cfsqltype="cf_sql_bigint" value="#form.phoneNumber#"/>,
									<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.password#"/>,
									<cfqueryparam cfsqltype="cf_sql_char" value="#form.gender#"/>
								);

						</cfquery>
						<cflocation url="/views/login.cfm">
					</cfif>
				<cfreturn errorMessage/>
		</cffunction>

		<cffunction name="loginUser" hint="login user" access="public" output="false" returntype="struct">
			<cfset var loginErrorMessage={email='',password=''}/>
				<cfif Trim(form.email) eq ''>
					<cfset loginErrorMessage.email='Email should not be empty'/>
				<cfelseif REFind('^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$',Trim(form.email),1) eq 0>
					<cfset loginErrorMessage.email='Please enter a valid email address (Ex:abc@cd.com)'/>
				<cfelseif not checkEmail(form.email) >
					<cfset loginErrorMessage.email='You are not registered yet'/>
				</cfif>

				<cfif Trim(form.password) eq ''>
					<cfset loginErrorMessage.password='password should not be empty'/>
				<cfelseif REFind('(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}',form.password,1) eq 0>
					<cfset loginErrorMessage.password='Please enter a valid password'/>
				<cfelseif not checkPassword(form.email,form.password)>
						<cfset loginErrorMessage.password='Password is incorrect'/>
				</cfif>
				<cfreturn loginErrorMessage/>
		</cffunction>


		<cffunction name="doLogin" acces="public" output="false" returntype="boolean">
			<cfargument  name="userEmail" type="string" required="true"/>
			<cfargument  name="userPassword" type="string" required="true"/>

			<cfset var isUserLoggedIn = false/>

			<cfquery name="fetchLoginUser">
				select * from employees where email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.userEmail#"/>
			</cfquery>

			<cfif fetchLoginUser.recordCount eq 1>
				<cfset session.stLoggedInUser={'userFirstName'=fetchLoginUser.firstName,'userLastName'=fetchLoginUser.firstName,'userId'=fetchLoginUser.empId}/>
				<cfset var isUserLoggedIn=true/>
			</cfif>

			<cfreturn isUserLoggedIn/>
		</cffunction>
		<cffunction name="doLogout" acces="public" output="false" returntype="void">
			<cfset structdelete(session,'stLoggedInUser')>
		</cffunction>
</cfcomponent>
