
<cfcomponent>

	<!--- 1 --->
	<!--- check for user login data --->
	<cffunction access="public" name="checkLoginUser" output="false" returntype="boolean">
		<cfargument name="email" type="string" required="yes"/>
		<cfargument name="password" type="string" required="yes"/>
		 <cftry>
			<cfquery name="loginUser">
					SELECT adminId FROM admin WHERE email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.email#"/> AND
													password = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.password#"/>
			</cfquery>
		 <cfcatch type="Database">
		<cflog file="EmployeeManagementSystemLog" application="no" text="Database Error on component : adminService on function : checkLoginUser & User : #ARGUMENTS.email#"/> --->
 			<cflocation url="../../common/error.cfm">
 		</cfcatch>
 		<cfcatch type="any">
 			<cflog file="EmployeeManagementSystemLog" application="no" text="Any Error on component : adminService on function : checkLoginUser & User : #ARGUMENTS.email#"/> --->
 			<cflocation url="../../common/error.cfm">
 		</cfcatch>
		</cftry>
		<cfif loginUser.recordCount EQ 1>
			<cfreturn true/>
		</cfif>
		<cfreturn false/>
	</cffunction>

	<!--- 2 --->
	<!--- check for login input --->
	<cffunction name="checkAdminLogin" hint="login user" access="public" output="false" returntype="string">
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

	<!--- 3 --->
	<!--- create a seesion for admin logged in user --->
	<cffunction name="doLogin" acces="public" output="false" >

		<cfargument  name="loginEmail" type="string" required="true"/>
		<cfargument  name="loginPassword" type="string" required="true"/>
		 <cftry>
			<cfquery name="fetchLoginEmployee">
					SELECT adminId,firstName,lastName,password FROM admin  WHERE
								email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.loginEmail#"/>
								and password =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.loginPassword#"/>
			</cfquery>
			<cfif fetchLoginEmployee.recordCount eq 1>
				<cfset SESSION.setAdmin={'firstName'=fetchloginEmployee.firstName,'lastName'=fetchloginEmployee.lastName,'adminId'=fetchloginEmployee.adminId,'role'='ADMIN'}/>
			</cfif>
			<cfcatch type="Database">
				<cflog file="EmployeeManagementSystemLog" application="no" text="Database Error on component : adminService on function : doLogin & User : #ARGUMENTS.loginEmail# "/>
				<cflocation url="../../common/error.cfm">
			</cfcatch>
			<cfcatch type="any">
				<cflog file="EmployeeManagementSystemLog" application="no" text="Any Error on component : adminService on function : checkLoginUser & User : #ARGUMENTS.loginEmail#"/>
				<cflocation url="../../common/error.cfm">
			</cfcatch>
		</cftry>
	</cffunction>

	<!--- 4 --->
	<!--- logout functionality --->
	<cffunction name="doLogout" acces="public" output="false" returntype="void">
		<cfset structdelete(SESSION,'setAdmin')>
	</cffunction>

	<!--- 5 --->
	<!--- Fetch all the employee  data --->
	<cffunction name="getEmployeeDetails" hint="fetch the details of employee" output="false" access="public" returntype="query">
		<cftry>
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
			<cflog file="EmployeeManagementSystemLog" application="no" text="Database Error on component : adminService on function : getEmployeeDetails"/>
			<cflocation url="../common/error.cfm">
		</cfcatch>	<!--- end database exception --->
		<cfcatch type="any">	<!--- catch block for any exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Any Error on component : adminService on function : getEmployeeDetails "/>
			<cflocation url="../common/error.cfm">
		</cfcatch>	<!--- end any exception --->
		</cftry>	<!--- end dtry block --->
		<cfreturn employeeDetails/>
	</cffunction>

	<!--- 6 --->
	<!--- Checking admin input data for adding new employee --->
	<cffunction name="checkEmployeeDetails" hint="check employee entry" access="public" output="false" returntype="Struct">

			<!--- initialize addEmployeeErrorMessage structure --->
			<cfset var addEmployeeErrorMessage=
					{firstName="",middleName="",lastName="",email="",dob="",phoneNumber="",joiningDate="",basicSalary="",roleName=""}/>

			<!--- check for first name --->
			<cfif Trim(FORM.firstName) EQ "">
				<cfset addEmployeeErrorMessage.firstName="First name should not be empty"/>
			<cfelseif REFind("^[a-zA-Z]+$",Trim(FORM.firstName),1) EQ 0>
				<cfset addEmployeeErrorMessage.firstName="First name should contain only alphabet"/>
			</cfif>

			<!--- check for middle name --->
			<cfif Trim(FORM.middleName) EQ "">
				<cfset addEmployeeErrorMessage.middleName=""/>
			<cfelseif REFind("^[a-zA-Z]*$",Trim(FORM.middleName),1) EQ 0>
				<cfset addEmployeeErrorMessage.middleName="Middle name should contain only alphabet"/>
			</cfif>
			<!--- check for last name --->
			<cfif Trim(FORM.lastName) EQ "">
				<cfset addEmployeeErrorMessage.lastName="Last name should not be empty"/>
			<cfelseif REFind("^[a-zA-Z]+$",Trim(FORM.lastName),1) EQ 0>
				<cfset addEmployeeErrorMessage.lastName="Last name should contain only alphabet"/>
			</cfif>
			<!--- check for email --->
			<cfif Trim(FORM.email) EQ "">
				<cfset addEmployeeErrorMessage.email="Email should not be empty"/>
			<cfelseif REFind("^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$",Trim(FORM.email),1) EQ 0>
				<cfset addEmployeeErrorMessage.email="Please enter a valid email address (Ex:abc@cd.com)"/>
			<cfelseif checkEmail(form.email) >
				<cfset addEmployeeErrorMessage.email="Email is already exists"/>
			</cfif>

			<!--- check for Date of birth,date of birth should be previous date --->
			<cfif FORM.dateOfBirth EQ "">
				<cfset addEmployeeErrorMessage.dob="Date of Birthshould not be empty"/>
			<cfelse>
				<cfset var date = #DateFORMat(FORM.dateOfBirth)#>
				<cfset var today = #DateFORMat(now())#>
				<cfif date GT today>
					<cfset addEmployeeErrorMessage.dob="Date of Birth should not be greater than today's date"/>
				</cfif>
			</cfif>

			<!--- check for phone number, phone number mustbe 10 digit long --->
			<cfif Trim(FORM.phoneNumber) EQ "">
				<cfset addEmployeeErrorMessage.phoneNumber="PhoneNumber should not be empty"/>
			<cfelseif REFind("^[1-9][0-9]{9}$",Trim(FORM.phoneNumber),1) EQ 0>
				<cfset addEmployeeErrorMessage.phoneNumber="Phone number must be 10 numbers (Ex:98XXXXXX66)"/>
			</cfif>

			<!--- check for joining date, joining date should not be previous date --->
			<cfif FORM.joiningDate EQ "">
				<cfset addEmployeeErrorMessage.joiningDate="Joining Date should not be empty"/>
			<cfelse>
				<cfset var date = #DateFORMat(FORM.joiningDate)#>
				<cfset var today = #DateFORMat(now())#>
				<cfif date LT today>
					<cfset addEmployeeErrorMessage.joiningDate="Joining Date can not be previous Date"/>
				</cfif>
			</cfif>

			<!--- check for basic salary --->
			<cfif Trim(FORM.basicSalary) EQ "">
				<cfset addEmployeeErrorMessage.basicSalary="Basic Salary should not be empty"/>
			<cfelseif REFind("[0-9]*",Trim(FORM.basicSalary),1) EQ 0>
				<cfset addEmployeeErrorMessage.basicSalary="Salary should be a number"/>
			</cfif>

			<!--- check for role name --->
			<cfif FORM.roleId EQ "">
				<cfset addEmployeeErrorMessage.roleName="Role of the employee should be select"/>
			</cfif>
			<!--- return the structure --->
			<cfreturn addEmployeeErrorMessage/>
	</cffunction><!--- end function --->

	<!--- 7 --->
	<!--- Insert employee data into employee table --->
	<cffunction name="addEmployee" hint="Insert new entry into Employee Table " access="public" output="false" returntype="boolean">
			<!--- Arguments for the function --->
			<cfargument  name="firstName" type="string" required="true"/>
			<cfargument  name="middleName" type="string" required="true"/>
			<cfargument  name="lastName" type="string" required="true"/>
			<cfargument  name="email" type="string" required="true"/>
			<cfargument  name="dob" type="date" required="true"/>
			<cfargument  name="phoneNumber" type="numeric" required="true"/>
			<cfargument  name="gender" type="string" required="true"/>
			<cfargument  name="joiningDate" type="date" required="true"/>
			<cfargument  name="basicSalry" type="numeric" required="true"/>
			<cfargument  name="roleId" type="numeric" required="true"/>

			<!--- <cftry>	 --->	<!--- try block for handle exception --->
				<!--- query for Insert employee data into employee table --->
				<cfquery name="employee">
					INSERT INTO employees(firstName,middleName,lastName,email,dateOfBirth,phoneNumber,gender,joiningDate,basicSalary,roleId)
					VALUES(<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ARGUMENTS.firstName#"/>,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ARGUMENTS.middleName#"/>,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ARGUMENTS.lastName#"/>,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ARGUMENTS.email#"/>,
							<cfqueryparam cfsqltype="CF_SQL_DATE" value="#ARGUMENTS.dob#"/>,
							<cfqueryparam cfsqltype="CF_SQL_BIGINT" value="#ARGUMENTS.phoneNumber#"/>,
							<cfqueryparam cfsqltype="CF_SQL_CHAR" value="#ARGUMENTS.gender#"/>,
							<cfqueryparam cfsqltype="CF_SQL_DATE" value="#ARGUMENTS.joiningDate#"/>,
							<cfqueryparam cfsqltype="CF_SQL_MONEY" value="#ARGUMENTS.basicSalry#"/>,
							<cfqueryparam cfsqltype="CF_SQL_INT" value="#ARGUMENTS.roleId#"/>)

				</cfquery>

			<cfreturn true/>
	</cffunction><!--- end function --->

	<!--- 8 --->
	<!---Fetch role name from role table --->
	<cffunction name="getEmployeeRole" access="public" hint="fetch role dtails" output="false" returntype="query">
			<cftry>		<!--- try block for handle exception --->
				<cfquery name="employeeRole">
					SELECT roleId,roleName FROM employeeRole
				</cfquery>
			<cfcatch type="Database">	<!--- catch block for database exception --->
				<cflog file="EmployeeManagementSystemLog" application="no" text="Database Error on component : adminService on function : getEmployeeRole"/>
				<cflocation url="../../common/error.cfm">
			</cfcatch>	<!--- end database exception --->
			<cfcatch type="any">	<!--- catch block for any exception --->
				<cflog file="EmployeeManagementSystemLog" application="no" text="Any Error on  component : adminService on function : getEmployeeRole "/>
				<cflocation url="../../common/error.cfm">
			</cfcatch>	<!--- end any exception --->
			</cftry>	<!--- end dtry block --->
			<cfreturn employeeRole/>
	</cffunction>

	<!--- 9 --->
	<!--- Checking admin input data for adding new project --->
		<cffunction name="checkProjectDetails" hint="check project entry" access="public" output="false" returntype="Struct">
			<!--- Initialize addProjectErrorMessage structure --->
			<cfset var addProjectErrorMessage={projectName="",managerName="",startDate="",endDate=""}/>

			<!--- check for project name --->
			<cfif Trim(FORM.projectName) EQ "">
				<cfset addProjectErrorMessage.projectName="Project Name should not be empty"/>
			<cfelseif REFind(".{5,50}",Trim(FORM.projectName),1) EQ 0>
				<cfset addProjectErrorMessage.projectName="Project name should be more than 5 characters and less than 50 character"/>
			<cfelseif not checkProject(FORM.projectName)>
				<cfset addProjectErrorMessage.projectName="Project already added"/>
			</cfif>

			<!--- check for manager name --->
			<cfif FORM.managerId EQ "">
				<cfset addProjectErrorMessage.managerName="please select the Manager Name"/>
			</cfif>

			<!--- cheeck for project start date it should not be previous date --->
			<cfif FORM.projectStartDate EQ "">
				<cfset addProjectErrorMessage.startDate="Project Start Date should not be empty"/>
			<cfelse>
				<cfset var date = #DateFORMat(FORM.projectStartDate)#>
				<cfset var today = #DateFORMat(now())#>
				<cfif date LT today>
					<cfset addProjectErrorMessage.startDate="Project start date can not be previous date"/>
				</cfif>
			</cfif>

			<!--- cheeck for project end date it should not befor start date --->
			<cfif FORM.projectEndDate EQ "">
				<cfset addProjectErrorMessage.endDate="Project End Date should not be empty"/>
			<cfelse>
				<cfset var startDate = #DateFORMat(FORM.projectStartDate)#>
				<cfset var endDate = #DateFORMat(FORM.projectEndDate)#>
				<cfif startDate GT endDate>
					<cfset addProjectErrorMessage.endDate="Project End date can not be before project Start Date"/>
				</cfif>
			</cfif>
			<cfreturn addProjectErrorMessage/>
	</cffunction>

	<!--- 10 --->
	<!--- Fetch all the manager details --->
	<cffunction name="getManager" hint="fetch the manager name" output="false" access="public" returntype="query">
		<cftry>		<!--- try block for handle exception --->
			<cfquery name="managerDetails">
				SELECT emp.empId,CONCAT(ISNULL(emp.firstName,''),' ',ISNULL(emp.middleName,''),' ',ISNULL(emp.lastName,'')) "Name"
				FROM employees emp JOIN employeeRole empRole ON emp.roleId=empRole.roleId WHERE empRole.roleName = 'MANAGER';
			</cfquery>
		<cfcatch type="Database">	<!--- catch block for database exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Database Error on component : adminService on function : getManager"/>
			<cflocation url="../../common/error.cfm">
		</cfcatch>	<!--- end database exception --->
		<cfcatch type="any">	<!--- catch block for any exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Any Error on component : adminService on function : getManager "/>
			<cflocation url="../../common/error.cfm">
		</cfcatch>	<!--- end any exception --->
		</cftry>	<!--- end dtry block --->
		<cfreturn managerDetails/>
	</cffunction>

	<!--- 11 --->
	<!--- Insert a new project in to the project table --->
	<cffunction name="addProject" hint="Insert new entry into project Table " access="public" output="false" returntype="boolean">
			<!--- Arguments --->
			<cfargument  name="projectName" type="string" required="true"/>
			<cfargument  name="managerID" type="numeric" required="true"/>
			<cfargument  name="startDate" type="date" required="true"/>
			<cfargument  name="endDate" type="date" required="true"/>


			<cftry>		<!--- try block for handle exception --->
				<!--- Query for the insert project --->
				<cfquery name="project">
					INSERT INTO project (projectName,projectMgrId,startDate,endDate)
					VALUES	(<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ARGUMENTS.projectName#"/>,
							<cfqueryparam cfsqltype="CF_SQL_INT" value="#ARGUMENTS.managerID#"/>,
							<cfqueryparam cfsqltype="CF_SQL_DATE" value="#ARGUMENTS.startDate#"/>,
							<cfqueryparam cfsqltype="CF_SQL_DATE" value="#ARGUMENTS.endDate#"/>
							)
				</cfquery>
			<cfcatch type="Database">	<!--- catch block for database exception --->
				<cflog file="EmployeeManagementSystemLog" application="no" text="Database Error on component : adminService on function : addProject"/>
				<cflocation url="../../common/error.cfm">
			</cfcatch>	<!--- end database exception --->
			<cfcatch type="any">	<!--- catch block for any exception --->
				<cflog file="EmployeeManagementSystemLog" application="no" text="Any Error on component : adminService on function : addProject "/>
				<cflocation url="../../common/error.cfm">
			</cfcatch>	<!--- end any exception --->
			</cftry>	<!--- end dtry block --->

			<cfreturn true/>
	</cffunction>

	<!--- 12 --->
	<!--- Fetch department details from departmennt table --->
		<cffunction name="checkNameForProjec" access="public" hint="check if employee is assigned to the project or not" output="false" returntype="boolean">
			<cfargument  name="employeeId" type="numeric" required="true"/>
			<cftry>		<!--- try block for handle exception --->
				<cfquery name="employeeName">
						SELECT empId FROM employeeProject WHERE status = 1 AND empId =
						<cfqueryparam cfsqltype="CF_SQL_INT" value="#ARGUMENTS.employeeId#"/>
				</cfquery>
			<cfcatch type="Database">	<!--- catch block for database exception --->
					<cflog file="EmployeeManagementSystemLog" application="no" text="Database Error on component : adminService on function : checNameForProjec"/>
					<cflocation url="../../common/error.cfm">
			</cfcatch>	<!--- end database exception --->
			<cfcatch type="any">	<!--- catch block for any exception --->
					<cflog file="EmployeeManagementSystemLog" application="no" text="Any Error on component : adminService on function : checNameForProjec "/>
					<cflocation url="../../common/error.cfm">
			</cfcatch>	<!--- end any exception --->
			</cftry>	<!--- end dtry block --->
			<cfif employeeName.recordCount EQ 0>
				<cfreturn true/>
			</cfif>
			<cfreturn false/>
	</cffunction>


	<!--- 13 --->
	<!--- Checking for mapping project --->
	<cffunction name="checkProjectMappingDetails" hint="check project entry" access="public" output="false" returntype="Struct">
			<!--- Initialize assignProjectErrorMessage structure --->
			<cfset var assignProjectErrorMessage={employeeName="",projectName="",assignDate="",completionDate=""}/>



			<!--- call getPerticularProjectDetails() --->
			<cfset var perticularProjectDetails = getPerticularProjectDetails(FORM.projectName)/>
			<cfset var employees = getPerticularProjectEmployeeDetails(FORM.projectName)/>






			<!--- check for employee name --->
			<cfif FORM.employeeName EQ "">
				<cfset assignProjectErrorMessage.employeeName="please select the Employee Name"/>
			<cfelseif NOT checkNameForProjec(FORM.employeeName)>
					<cfset assignProjectErrorMessage.employeeName="Employee is already assigned to a project"/>
			</cfif>

			<!--- check for manager name --->
			<cfif FORM.projectName EQ "">
				<cfset assignProjectErrorMessage.projectName="please select the Project Name"/>
			</cfif>

			<!--- cheeck for project start date it should not be previous date --->
			<cfif FORM.projectAssignDate EQ "">
				<cfset assignProjectErrorMessage.assignDate="Assign Date should not be empty"/>
			<cfelse>
				<cfset var date = #DateFORMat(FORM.projectAssignDate)#>
				<cfset var today = #DateFORMat(now())#>
				<cfif date LT today>
					<cfset assignProjectErrorMessage.assignDate="Assign date can not be previous date"/>
				<cfelseif date LT perticularProjectDetails.startDate>
					<cfset assignProjectErrorMessage.assignDate="Assign date can not be before project start date"/>
				</cfif>
			</cfif>

			<!--- cheeck for project end date it should not befor start date --->
			<cfif FORM.projectcompletionDate EQ "">
				<cfset assignProjectErrorMessage.completionDate="Completion Date should not be empty"/>
			<cfelse>
				<cfset var aDate = #DateFORMat(FORM.projectAssignDate)#>
				<cfset var cDate = #DateFORMat(FORM.projectcompletionDate)#>
				<cfif aDate GT cDate>
					<cfset assignProjectErrorMessage.completionDate="Project completion date can not be before project assign Date"/>
				<cfelseif cDate GT perticularProjectDetails.endDate>
					<cfset assignProjectErrorMessage.completionDate="Completion date can not be after project end date"/>
				</cfif>
			</cfif>
			<cfreturn assignProjectErrorMessage/>
	</cffunction>

	<!--- 14 --->
	<!--- insert data to employee project --->
	<cffunction name="addProjectMapping" hint="insert project mapping entry" access="public" output="false" returntype="boolean">
			<!--- Arguments for the function --->
			<cfargument name="employeeId" type="numeric" required="true"/>
			<cfargument  name="projectName" type="numeric" required="true"/>
			<cfargument  name="assignDate" type="date" required="true"/>
			<cfargument  name="completionDate" type="date" required="true"/>
			<cftry>		<!--- try block for handle exception --->
				<cfquery name="projectMapping">
					INSERT INTO employeeProject (empId,projectId,projectJoinDate,projectFinishDate) VALUES (
													<cfqueryparam cfsqltype="CF_SQL_INT" value="#ARGUMENTS.employeeId#"/>,
													<cfqueryparam cfsqltype="CF_SQL_INT" value="#ARGUMENTS.projectName#"/>,
													<cfqueryparam cfsqltype="CF_SQL_DATE" value="#ARGUMENTS.assignDate#"/>,
													<cfqueryparam cfsqltype="CF_SQL_DATE" value="#ARGUMENTS.completionDate#"/>
													);
				</cfquery>
			<cfcatch type="Database">	<!--- catch block for database exception --->
				<cflog file="EmployeeManagementSystemLog" application="no" text="Database Error on component : adminService on function : addProjectMapping"/>
				<cflocation url="../../common/error.cfm">
			</cfcatch>	<!--- end database exception --->
			<cfcatch type="any">	<!--- catch block for any exception --->
				<cflog file="EmployeeManagementSystemLog" application="no" text="Any Error on component : adminService on function : addProjectMapping "/>
				<cflocation url="../../common/error.cfm">
			</cfcatch>	<!--- end any exception --->
			</cftry>	<!--- end dtry block --->

		<cfreturn true/>
	</cffunction>

	<!--- 15 --->
	<!--- Fetch all employee name who are belong to engineering department --->
	<cffunction name="getEmployeeName" hint="fetch the name of the employee" output="false" access="public" returntype="query">
		<cftry>		<!--- try block for handle exception --->
			<cfquery name="employeeName">
				SELECT emp.empId,CONCAT(ISNULL(emp.firstName,''),' ',ISNULL(emp.middleName,''),' ',ISNULL(emp.lastName,'')) "Name"
				FROM employees emp JOIN employeeRole empRole on emp.roleId = empRole.roleId JOIN department dept on
				empRole.departmentId = dept.departmentId where dept.departmentName = 'ENGINEERING'
			</cfquery>
		<cfcatch type="Database">	<!--- catch block for database exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Database Error on component : adminService on function : getEmployeeName"/>
			<cflocation url="../../common/error.cfm">
		</cfcatch>	<!--- end database exception --->
		<cfcatch type="any">	<!--- catch block for any exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Any Error on component : adminService on function : getEmployeeName "/>
			<cflocation url="../../common/error.cfm">
		</cfcatch>	<!--- end any exception --->
		</cftry>	<!--- end dtry block --->
		<cfreturn employeeName/>
	</cffunction>

	<!--- 16 --->
	<!--- Fetch project name from project table which are not completed --->
	<cffunction name="getProjectName" hint="fetch the name of the current project" output="false" access="public" returntype="query">
		<cftry>		<!--- try block for handle exception --->
			<cfquery name="projectName">
				SELECT projectId,projectName from project WHERE endDate >= getDate()
			</cfquery>
		<cfcatch type="Database">	<!--- catch block for database exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Database Error on component : adminService on function : getProjectName"/>
			<cflocation url="../../common/error.cfm">
		</cfcatch>	<!--- end database exception --->
		<cfcatch type="any">	<!--- catch block for any exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Any Error on component : adminService on function : getProjectName "/>
			<cflocation url="../../common/error.cfm">
		</cfcatch>	<!--- end any exception --->
		</cftry>	<!--- end dtry block --->
		<cfreturn projectName/>
	</cffunction>

	<!--- 17 --->
	<!--- Fetch project data from project table --->
		<cffunction name="getProjectDetails" hint="fetch the project details from the project table" access="public" output="false" returntype="query">
			<cftry>		<!--- try block for handle exception --->
				<cfquery name="projectDetails">
					SELECT proj.projectName, proj.startDate,proj.endDate,CONCAT(emp.firstName,' ',emp.middleName,' ',emp.lastName) manager,
					CONCAT(e.firstName,' ',e.middleName,' ',e.lastName) name ,
					empProject.projectJoinDate, empProject.projectFinishDate,
						CASE empProject.status WHEN 1 THEN 'MAPPED'
							WHEN 0 THEN 'REMOVED'
							WHEN 2 THEN 'COMPLETED'
						END status
					FROM project proj LEFT OUTER JOIN employeeProject empProject ON proj.projectId = empProject.projectId
					JOIN employees emp ON proj.projectMgrId = emp.empId LEFT OUTER JOIN
					employees e ON empProject.empId = e.empId ORDER BY proj.projectName
				</cfquery>
			<cfcatch type="Database">	<!--- catch block for database exception --->
				<cflog file="EmployeeManagementSystemLog" application="no" text="Database Error on component : adminService on function : getProjectDetails"/>
				<cflocation url="../../common/error.cfm">
			</cfcatch>	<!--- end database exception --->
			<cfcatch type="any">	<!--- catch block for any exception --->
				<cflog file="EmployeeManagementSystemLog" application="no" text="Any Error on component : adminService on function : getProjectDetails "/>
				<cflocation url="../../common/error.cfm">
			</cfcatch>	<!--- end any exception --->
			</cftry>	<!--- end dtry block --->
			<cfreturn projectDetails/>
		</cffunction>

	<!--- 18 --->
	<!--- check for update employee personal information --->
	<cffunction name="checkUpdateEmployeeDetails" hint="check admin entry" access="public" output="false" returntype="Struct">

			<cfset var updateEmployeeDetailsErrorMessage ={salary=''}/>

			<cfif Trim(FORM.basicSalary) EQ "">
				<cfset updateEmployeeDetailsErrorMessage.salary="Basic Salry should not be empty"/>
			<cfelseif REFind("\d+(\.\d+)?",Trim(FORM.basicSalary),1) EQ 0>
				<cfset updateEmployeeDetailsErrorMessage.salary="Basic salary must be integer or float number"/>
			</cfif>
			<cfreturn updateEmployeeDetailsErrorMessage/>
	</cffunction>

	<!--- 19 --->
	<!--- update employee information --->
		<cffunction name="updateEmployeeDetails" hint="Update employee details in Employee Table " access="public" output="false" returntype="boolean">
			<cfargument name="employeeId" type="numeric" required="true"/>
			<cfargument  name="roleId" type="numeric" required="true"/>
			<cfargument  name="basicSalary" type="numeric" required="true"/>

			<cftry>		<!--- try block for handle exception --->
				<cfquery name="employee">

					UPDATE employees SET roleId = <cfqueryparam cfsqltype="CF_SQL_INT" value="#ARGUMENTS.roleId#"/> ,
									  basicSalary = <cfqueryparam cfsqltype="CF_SQL_INT" value="#ARGUMENTS.basicSalary#"/>
									  WHERE empId = <cfqueryparam cfsqltype="CF_SQL_INT" value="#ARGUMENTS.employeeId#"/>

			</cfquery>
		<cfcatch type="Database">	<!--- catch block for database exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Database Error on component : adminService on function : updateEmployeeDetails"/>
			<cflocation url="../../common/error.cfm">
		</cfcatch>	<!--- end database exception --->
		<cfcatch type="any">	<!--- catch block for any exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Any Error on component : adminService on function : updateEmployeeDetails "/>
			<cflocation url="../../common/error.cfm">
		</cfcatch>	<!--- end any exception --->
		</cftry>	<!--- end dtry block --->
		<cfreturn true/>
	</cffunction>

	<!--- 20 --->
	<!--- get role details --->
	<cffunction name="getRollName" hint="fetch the role name from the employee role table" access="public" output="false" returntype="query">
		<cfargument name="departmentName" type="string" required="true"/>
		<cftry>		<!--- try block for handle exception --->
			<cfquery name="roleName">
				SELECT empRole.roleId,empRole.roleName FROM employeeRole empRole JOIN department dept ON
				empRole.departmentId = dept.departmentId where dept.departmentName =
					<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ARGUMENTS.departmentName#"/>
			</cfquery>
		<cfcatch type="Database">	<!--- catch block for database exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Database Error on component : adminService on function : getRollName"/>
			<cflocation url="../../common/error.cfm">
		</cfcatch>	<!--- end database exception --->
		<cfcatch type="any">	<!--- catch block for any exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Any Error on component : adminService on function : getRollName "/>
			<cflocation url="../../common/error.cfm">
		</cfcatch>	<!--- end any exception --->
		</cftry>	<!--- end dtry block --->
		<cfreturn roleName/>
	</cffunction>








		<!--- Fetch department details from departmennt table --->
		<cffunction name="getDepartment" access="public" hint="fetch department details" output="false" returntype="query">
			<cftry>		<!--- try block for handle exception --->
				<cfquery name="department">
						SELECT departmentId,departmentName FROM department
				</cfquery>
			<cfcatch type="Database">	<!--- catch block for database exception --->
					<cflog file="EmployeeManagementSystemLog" application="no" text="Database Error on function : getDepartment"/>
					<cflocation url="../../common/error.cfm">
			</cfcatch>	<!--- end database exception --->
			<cfcatch type="any">	<!--- catch block for any exception --->
					<cflog file="EmployeeManagementSystemLog" application="no" text="Any Error on function : getDepartment "/>
					<cflocation url="../../common/error.cfm">
			</cfcatch>	<!--- end any exception --->
			</cftry>	<!--- end dtry block --->
			<cfreturn department/>
		</cffunction>



		<!--- check if project is alreay exists or not --->
		<cffunction name="checkProject" access="public" hint="fetch project details from project table" output="false" returntype="boolean">
			<cfargument  name="projectName" type="string" required="true"/>
			<cftry>		<!--- try block for handle exception --->
				<cfquery name="project">
					SELECT projectId FROM project WHERE projectName = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ARGUMENTS.projectName#"/>
				</cfquery>
			<cfcatch type="Database">	<!--- catch block for database exception --->
				<cflog file="EmployeeManagementSystemLog" application="no" text="Database Error on component : adminService on function : checkProject"/>
				<cflocation url="../../common/error.cfm">
			</cfcatch>	<!--- end database exception --->
			<cfcatch type="any">	<!--- catch block for any exception --->
				<cflog file="EmployeeManagementSystemLog" application="no" text="Any Error on component : adminService on function : checkProject "/>
				<cflocation url="../../common/error.cfm">
			</cfcatch>	<!--- end any exception --->
			</cftry>	<!--- end dtry block --->

			<cfif project.recordCount EQ 0>
				<cfreturn true/>
			</cfif>
			<cfreturn false>
		</cffunction>





		<!--- check if email is alreadyexists or not --->
		<cffunction access="public" name="checkEmail" output="false" returntype="boolean">
			<cfargument name="email" type="string" required="yes"/>
			<cftry>
				<cfquery name="emailQuery">
					SELECT empId FROM employees WHERE email = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ARGUMENTS.email#"/>
				</cfquery>
			<cfcatch type="Database">	<!--- catch block for database exception --->
				<cflog file="EmployeeManagementSystemLog" application="no" text="Database Error on component : adminService on function : checkEmail"/>
				<cflocation url="../../common/error.cfm">
			</cfcatch>	<!--- end database exception --->
			<cfcatch type="any">	<!--- catch block for any exception --->
				<cflog file="EmployeeManagementSystemLog" application="no" text="Any Error on component : adminService on function : checkEmail "/>
				<cflocation url="../../common/error.cfm">
			</cfcatch>	<!--- end any exception --->
			</cftry>	<!--- end dtry block --->
			<cfif emailQuery.recordCount GT 0>
				<cfreturn true>
			</cfif>
			<cfreturn false/>
		</cffunction>







		<!--- Fetch data of a perticular project from project table --->
		<cffunction name="getPerticularProjectDetails" hint="fetch the project details of the employee" access="public" output="false" returntype="query">
			<!--- Arguments --->
			<cfargument name="projectId" type="string" required="true"/>
			<cftry>		<!--- try block for handle exception --->
				<cfquery name="perticularProjectDetails">
					SELECT  proj.startDate,proj.endDate FROM project proj WHERE
					projectId = <cfqueryparam cfsqltype="CF_SQL_INT" value="#ARGUMENTS.projectId#"/>
				</cfquery>
			<cfcatch type="Database">	<!--- catch block for database exception --->
				<cflog file="EmployeeManagementSystemLog" application="no" text="Database Error on component : adminService on function : getPerticularProjectDetails"/>
				<cflocation url="../../common/error.cfm">
			</cfcatch>	<!--- end database exception --->
			<cfcatch type="any">	<!--- catch block for any exception --->
				<cflog file="EmployeeManagementSystemLog" application="no" text="Any Error on component : adminService on function : getPerticularProjectDetails "/>
				<cflocation url="../../common/error.cfm">
			</cfcatch>	<!--- end any exception --->
			</cftry>	<!--- end dtry block --->
			<cfreturn perticularProjectDetails/>
		</cffunction>

		<!--- Fetch data of a perticular project employee from employeeProject table --->
		<cffunction name="getPerticularProjectEmployeeDetails" hint="fetch the project details of the employee" access="public" output="false" returntype="array">
			<!--- Arguments --->
			<cfargument name="projectId" type="string" required="true"/>
			<cftry>		<!--- try block for handle exception --->
				<cfquery name="perticularProjectEmployeeDetails">
					SELECT  empProject.empId FROM employeeProject empProject WHERE
					projectId  = <cfqueryparam cfsqltype="CF_SQL_INT" value="#ARGUMENTS.projectId#"/>
				</cfquery>
				<cfset employee=[]>
				<cfloop query="perticularProjectEmployeeDetails">
					<cfset ArrayAppend(employee,perticularProjectEmployeeDetails.empId)/>
				</cfloop>
			<cfcatch type="Database">	<!--- catch block for database exception --->
				<cflog file="EmployeeManagementSystemLog" application="no" text="Database Error on component : adminService on function : getPerticularProjectEmployeeDetails"/>
				<cflocation url="../../common/error.cfm">
			</cfcatch>	<!--- end database exception --->
			<cfcatch type="any">	<!--- catch block for any exception --->
				<cflog file="EmployeeManagementSystemLog" application="no" text="Any Error on component : adminService on function : getPerticularProjectEmployeeDetails "/>
				<cflocation url="../../common/error.cfm">
			</cfcatch>	<!--- end any exception --->
			</cftry>	<!--- end dtry block --->
			<cfreturn employee/>
		</cffunction>









</cfcomponent>