
<cfcomponent>
	<cffunction name="getDepartment" access="public" output="false" returntype="query">
		<cfquery name="department">
			select departmentId,departmentName FROM department
		</cfquery>
		<cfreturn department/>
	</cffunction>

	<cffunction name="getEmployeeRole" access="public" output="false" returntype="query">
		<cfquery name="employeeRole">
			select roleId,roleName FROM employeeRole
		</cfquery>
		<cfreturn employeeRole/>
	</cffunction>

	<cffunction name="checkProject" access="public" output="false" returntype="boolean">
		<cfargument  name="projectName" type="string" required="true"/>
		<cfquery name="project">
			select * FROM project WHERE projectName= <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.projectName#"/>
		</cfquery>
		<cfif project.recordCount eq 0>
			<cfreturn true/>
		</cfif>
		<cfreturn false>
	</cffunction>

	<cffunction name="checkProjectDetails" hint="check project entry" access="public" output="false" returntype="Struct">
	<cfset var addProjectErrorMessage={projectName='',managerName='',startDate='',endDate=''}/>

	<cfif Trim(FORM.projectName) eq ''>
		<cfset addProjectErrorMessage.projectName='Project Name should not be empty'/>
	<cfelseif REFind('.{5,50}',Trim(FORM.projectName),1) eq 0>
		<cfset addProjectErrorMessage.projectName='Project name should be more than 5 characters and less than 50 character'/>
	<cfelseif not checkProject(FORM.projectName)>
		<cfset addProjectErrorMessage.projectName='Project already added'/>
	</cfif>

	<cfif FORM.managerId eq ''>
		<cfset addProjectErrorMessage.managerName='please select the Manager Name'/>
	</cfif>

	<cfif FORM.projectStartDate eq ''>
		<cfset addProjectErrorMessage.startDate='Project Start Date should not be empty'/>
	<cfelse>
		<cfset var date = #DateFORMat(FORM.projectStartDate)#>
		<cfset var today = #DateFORMat(now())#>
		<cfif date lt today>
			<cfset addProjectErrorMessage.startDate='Project start date can not be previous date'/>
		</cfif>
	</cfif>

	<cfif FORM.projectEndDate eq ''>
		<cfset addProjectErrorMessage.endDate='Project End Date should not be empty'/>
	<cfelse>
		<cfset var startDate = #DateFORMat(FORM.projectStartDate)#>
		<cfset var endDate = #DateFORMat(FORM.projectEndDate)#>
		<cfif startDate gt endDate>
			<cfset addProjectErrorMessage.endDate='Project End date can not be after project Start Date'/>
		</cfif>
	</cfif>
	<cfreturn addProjectErrorMessage/>
	</cffunction>

	<cffunction name="addProject" hint="Insert new entry into project Table " access="public" output="false" returntype="boolean">
	<cfargument  name="projectName" type="string" required="true"/>
	<cfargument  name="managerID" type="string" required="true"/>
	<cfargument  name="startDate" type="string" required="true"/>
	<cfargument  name="endDate" type="string" required="true"/>

	<cfquery name="project">
		INSERT INTO PROJECT (projectName,projectMgrId,startDate,endDate)
		values	(<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.projectName#"/>,
				<cfqueryparam cfsqltype="cf_sql_int" value="#ARGUMENTS.managerID#"/>,
				<cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.startDate#"/>,
				<cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.endDate#"/>
				)
	</cfquery>

	<cfreturn true/>
	</cffunction>

	<cffunction access="public" name="checkEmail" output="false" returntype="boolean">
		<cfargument name="email" type="string" required="yes"/>
		<cfquery name="emailQuery">
			SELECT * FROM employees WHERE email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.email#"/>
		</cfquery>
		<cfif emailQuery.recordCount gt 0>
			<cfreturn true>
		</cfif>
		<cfreturn false/>
	</cffunction>


	<cffunction name="checkEmployeeDetails" hint="check employee entry" access="public" output="false" returntype="Struct">

		<cfset var addEmployeeErrorMessage=
				{firstName='',middleName='',lastName='',email='',dob='',phoneNumber='',joiningDate='',departmentName='',basicSalary='',roleName=''}/>


		<cfif Trim(FORM.firstName) eq ''>
			<cfset addEmployeeErrorMessage.firstName='First name should not be empty'/>
		<cfelseif REFind('^[a-zA-Z]+$',Trim(FORM.firstName),1) eq 0>
			<cfset addEmployeeErrorMessage.firstName='First name should contain only alphabet'/>
		</cfif>

		<cfif Trim(FORM.middleName) eq ''>
			<cfset addEmployeeErrorMessage.middleName=''/>
		<cfelseif REFind('^[a-zA-Z]*$',Trim(FORM.middleName),1) eq 0>
			<cfset addEmployeeErrorMessage.middleName='Middle name should contain only alphabet'/>
		</cfif>

		<cfif Trim(FORM.lastName) eq ''>
			<cfset addEmployeeErrorMessage.lastName='Last name should not be empty'/>
		<cfelseif REFind('^[a-zA-Z]+$',Trim(FORM.lastName),1) eq 0>
			<cfset addEmployeeErrorMessage.lastName='Last name should contain only alphabet'/>
		</cfif>

		<cfif Trim(FORM.email) eq ''>
			<cfset addEmployeeErrorMessage.email='Email should not be empty'/>
		<cfelseif REFind('^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$',Trim(FORM.email),1) eq 0>
			<cfset addEmployeeErrorMessage.email='Please enter a valid email address (Ex:abc@cd.com)'/>
		<cfelseif checkEmail(form.email) >
			<cfset addEmployeeErrorMessage.email='Email is already exists'/>
		</cfif>

		<cfif FORM.dateOfBirth eq ''>
			<cfset addEmployeeErrorMessage.dob="Date of Birthshould not be empty"/>
		<cfelse>
			<cfset var date = #DateFORMat(FORM.dateOfBirth)#>
			<cfset var today = #DateFORMat(now())#>
			<cfif date gt today>
				<cfset addEmployeeErrorMessage.dob="Date of Birth should not be greater than today's date"/>
			</cfif>
		</cfif>

		<cfif Trim(FORM.phoneNumber) eq ''>
			<cfset addEmployeeErrorMessage.phoneNumber='PhoneNumber should not be empty'/>
		<cfelseif REFind('^[1-9][0-9]{9}$',Trim(FORM.phoneNumber),1) eq 0>
			<cfset addEmployeeErrorMessage.phoneNumber='Phone number must be 10 numbers (Ex:98XXXXXX66)'/>
		</cfif>

		<cfif FORM.joiningDate eq ''>
			<cfset addEmployeeErrorMessage.joiningDate="Joining Date should not be empty"/>
		<cfelse>
			<cfset var date = #DateFORMat(FORM.joiningDate)#>
			<cfset var today = #DateFORMat(now())#>
			<cfif date lt today>
				<cfset addEmployeeErrorMessage.joiningDate="Joining Date can not be previous Date"/>
			</cfif>
		</cfif>

		<cfif FORM.departmentId eq ''>
			<cfset addEmployeeErrorMessage.departmentName='Department Name should be select'/>
		</cfif>

		<cfif Trim(FORM.basicSalary) eq ''>
			<cfset addEmployeeErrorMessage.basicSalary='Basic Salary should not be empty'/>
		<cfelseif REFind('[0-9]*',Trim(FORM.basicSalary),1) eq 0>
			<cfset addEmployeeErrorMessage.basicSalary='Salary should be a number'/>
		</cfif>

		<cfif FORM.roleId eq ''>
			<cfset addEmployeeErrorMessage.roleName='Role of the employee should be select'/>
		</cfif>
		<cfreturn addEmployeeErrorMessage/>
	</cffunction>

	<cffunction name="addEmployee" hint="Insert new entry into Employee Table " access="public" output="false" returntype="boolean">

		<cfargument  name="firstName" type="string" required="true"/>
		<cfargument  name="middleName" type="string" required="true"/>
		<cfargument  name="lastName" type="string" required="true"/>
		<cfargument  name="email" type="string" required="true"/>
		<cfargument  name="dob" type="date" required="true"/>
		<cfargument  name="phoneNumber" type="numeric" required="true"/>
		<cfargument  name="gender" type="string" required="true"/>
		<cfargument  name="joiningDate" type="date" required="true"/>
		<cfargument  name="departmentId" type="numeric" required="true"/>
		<cfargument  name="basicSalry" type="numeric" required="true"/>
		<cfargument  name="roleId" type="numeric" required="true"/>

		<cfquery name="employee">
			insert into employees(firstName,middleName,lastName,email,dateOfBirth,phoneNumber,gender,joiningDate,departmentId,basicSalary,roleId)
			values(<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.firstName#"/>,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.middleName#"/>,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.lastName#"/>,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.email#"/>,
					<cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.dob#"/>,
					<cfqueryparam cfsqltype="cf_sql_bigint" value="#ARGUMENTS.phoneNumber#"/>,
					<cfqueryparam cfsqltype="cf_sql_char" value="#ARGUMENTS.gender#"/>,
					<cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.joiningDate#"/>,
					<cfqueryparam cfsqltype="cf_sql_int" value="#ARGUMENTS.departmentId#"/>,
					<cfqueryparam cfsqltype="cf_sql_money" value="#ARGUMENTS.basicSalry#"/>,
					<cfqueryparam cfsqltype="cf_sql_int" value="#ARGUMENTS.roleId#"/>)

					<!---insert into employees(firstName,middleName,lastName,email,dateOfBirth,phoneNumber,gender,joiningDate,departmentId,basicSalary,roleId)
			values('asd','sad','asd','a12@gmail.com',GETDATE(),1233122131,'f',GETDATE(),11,40000,3)--->
		</cfquery>
	<cfreturn true/>
	</cffunction>

</cfcomponent>