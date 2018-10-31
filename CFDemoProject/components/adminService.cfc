
<cfcomponent>
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

		<!--- Insert a new project in to the project table --->
		<cffunction name="addProject" hint="Insert new entry into project Table " access="public" output="false" returntype="boolean">
			<!--- Arguments --->
			<cfargument  name="projectName" type="string" required="true"/>
			<cfargument  name="managerID" type="string" required="true"/>
			<cfargument  name="startDate" type="string" required="true"/>
			<cfargument  name="endDate" type="string" required="true"/>


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

			<cftry>		<!--- try block for handle exception --->
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
			<cfcatch type="Database">	<!--- catch block for database exception --->
				<cflog file="EmployeeManagementSystemLog" application="no" text="Database Error on component : adminService on function : addEmployee"/>
				<cflocation url="../../common/error.cfm">
			</cfcatch>	<!--- end database exception --->
			<cfcatch type="any">	<!--- catch block for any exception --->
				<cflog file="EmployeeManagementSystemLog" application="no" text="Any Error on component : adminService on function : addEmployee "/>
				<cflocation url="../../common/error.cfm">
			</cfcatch>	<!--- end any exception --->
			</cftry>	<!--- end dtry block --->
			<cfreturn true/>
		</cffunction><!--- end function --->

		<!--- Fetch project data from project table --->
		<cffunction name="getProjectDetails" hint="fetch the project details from the project table" access="public" output="false" returntype="query">
			<cftry>		<!--- try block for handle exception --->
				<cfquery name="projectDetails">
					SELECT proj.projectName,(SELECT CONCAT(emp.firstName,' ',emp.middleName,' ',emp.lastName) name
					FROM employees emp WHERE emp.empId = proj.projectMgrId) manager, proj.startDate,proj.endDate FROM project proj
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

		<!--- Checking for mapping project --->
		<cffunction name="checkProjectMappingDetails" hint="check project entry" access="public" output="false" returntype="Struct">
			<!--- Initialize assignProjectErrorMessage structure --->
			<cfset var assignProjectErrorMessage={employeeName="",projectName="",assignDate="",completionDate=""}/>
			<!--- call getPerticularProjectDetails() --->
			<cfset var perticularProjectDetails = getPerticularProjectDetails(FORM.projectName)/>
			<cfset var employees = getPerticularProjectEmployeeDetails(FORM.projectName)/>
			<!--- check for project name --->
			<cfif FORM.employeeName EQ "">
				<cfset assignProjectErrorMessage.employeeName="please select the Employee Name"/>
			<cfelseif ArrayContains(employees,FORM.employeeName)>
					<cfset assignProjectErrorMessage.employeeName="Employee is already assigned"/>
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


		<!--- insert data to employee project --->
		<cffunction name="addProjectMapping" hint="insert project mapping entry" access="public" output="false" returntype="boolean">
			<!--- Arguments for the function --->
			<cfargument name="employeeId" type="numeric" required="true"/>
			<cfargument  name="projectName" type="string" required="true"/>
			<cfargument  name="assignDate" type="date" required="true"/>
			<cfargument  name="completionDate" type="date" required="true"/>
			<cftry>		<!--- try block for handle exception --->
				<cfquery name="projectMapping">
					INSERT INTO employeeProject VALUES (
													<cfqueryparam cfsqltype="CF_SQL_INT" value="#ARGUMENTS.employeeId#"/>,
													<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ARGUMENTS.projectName#"/>,
													<cfqueryparam cfsqltype="CF_SQL_DATE" value="#ARGUMENTS.assignDate#"/>,
													<cfqueryparam cfsqltype="CF_SQL_INT" value="#ARGUMENTS.completionDate#"/>
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
</cfcomponent>