

<cfcomponent accessors="true" output="false" persistent="false">
	<--- 1 --->
	<!--- Fetch employee details  --->
	<cffunction name="getEmployeeDetail" hint="fetch the employee details" access="public" output="false" returntype="query">
		<cfargument name="employeeId" type="numeric" required="true"/>
		<cftry>		<!--- try block for handle exception --->
			<cfquery name="employeeDetails">
				SELECT CONCAT(e.firstName,' ',e.middleName,' ',e.lastName) manager,
				dept.departmentName,empRole.roleName, proj.projectName,skill.skillName
				 FROM
				employees emp JOIN employeeRole empRole ON emp.roleId = empRole.roleId JOIN department dept ON
				empRole.departmentId = dept.departmentId JOIN employees e on dept.departmentHead = e.empId JOIN
				employeeProject empProject ON emp.empId = empProject.empId JOIN project proj ON empProject.projectId = proj.projectId
				JOIN employeeSkills empSkills ON emp.empId = empSkills.empId JOIN skills skill ON empSkills.skillId = skill.skillId
				WHERE  empProject.status = 1 AND emp.empId =
				<cfqueryparam cfsqltype="CF_SQL_INT" value="#ARGUMENTS.employeeId#"/>
			</cfquery>
		<cfcatch type="Database">	<!--- catch block for database exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Database Error on component : employeeService on function : getEmployeeDetail"/>
			<cflocation url="../common/error.cfm">
		</cfcatch>	<!--- end database exception --->
		<cfcatch type="any">	<!--- catch block for any exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Any Error on component : employeeService on function : getEmployeeDetail "/>
			<cflocation url="../../error.cfm">
		</cfcatch>	<!--- end any exception --->
		</cftry>	<!--- end dtry block --->
		<cfreturn employeeDetails/>
	</cffunction>

	<!--- 2 --->
	<!--- Fetch annual leave details of current year for an employee --->
	<cffunction name="getLeaveDetails" hint="fetch the leave details" access="public" output="false" returntype="query">
		<cfargument name="employeeId" type="numeric" required="true"/>
		<cfargument name="year" type="numeric" required="true"/>
		<cftry>		<!--- try block for handle exception --->
			<cfquery name="leaveDetails">
				SELECT totalLeaveAssigned,totalLeaveTaken,totalRemainingLeave FROM employeeAnnualLeave WHERE
													empId = <cfqueryparam cfsqltype="CF_SQL_INT" value="#ARGUMENTS.employeeId#"/>
												AND leaveYear = <cfqueryparam cfsqltype="CF_SQL_INT" value="#ARGUMENTS.year#"/>
			</cfquery>
		<cfcatch type="Database">	<!--- catch block for database exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Database Error on component : employeeService on function : getLeaveDetails"/>
			<cflocation url="../common/error.cfm">
		</cfcatch>	<!--- end database exception --->
		<cfcatch type="any">	<!--- catch block for any exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Any Error on component : employeeService on function : getLeaveDetails "/>
			<cflocation url="../common/error.cfm">
		</cfcatch>	<!--- end any exception --->
		</cftry>	<!--- end dtry block --->
		<cfreturn leaveDetails/>
	</cffunction>

	<!--- 3 --->
	<!--- check for leave daetais --->
	<cffunction name="checkApplyLeaveDetails" hint="check for apply Leave entry" access="public" output="false" returntype="Struct">
		<cfargument name="employeeId" type="numeric" required="true"/>

		<cfset var applyLeaveErrorMessage = {fromDate="",toDate="",numberOfDays="",reason=""}/>

		<cfif FORM.fromDate EQ "">
			<cfset applyLeaveErrorMessage.fromDate="From Date should not be empty"/>
		<cfelse>
			<cfset var date = #DateFORMat(FORM.fromDate)#>
			<cfset var today = #DateFORMat(now())#>
			<cfif date LT today>
				<cfset applyLeaveErrorMessage.fromDate="From Date can not be previous date"/>
			</cfif>
		</cfif>

		<cfif FORM.toDate EQ "">
			<cfset applyLeaveErrorMessage.toDate = "To Date should not be empty"/>
		<cfelse>
			<cfset var fDate = #DateFORMat(FORM.fromDate)#>
			<cfset var tDate = #DateFORMat(FORM.toDate)#>
			<cfif tDate LT fDate>
				<cfset applyLeaveErrorMessage.toDate = "To Date can not be before from date"/>
			</cfif>
		</cfif>

		<cfif Trim(FORM.totalDays) EQ "">
			<cfset applyLeaveErrorMessage.numberOfDays="Total number days should not be empty"/>
		<cfelse>
			<cfset var days = dateDiff("d",FORM.fromDate,FORM.toDate) + 1/>
			<cfset var remainingDays = getLeaveDetails("#ARGUMENTS.employeeId#",FORM.year)>
			<cfif days neq Trim(FORM.totalDays)>
				<cfset applyLeaveErrorMessage.numberOfDays="Please select number of days correctly"/>
			<cfelseif days gt remainingDays.totalRemainingLeave>
				<cfset applyLeaveErrorMessage.numberOfDays="You dont have enough leaves"/>
			</cfif>
		</cfif>
		<cfif Trim(FORM.reason) EQ "">
			<cfset applyLeaveErrorMessage.reason="Reason should be filled"/>
		</cfif>
		<cfreturn applyLeaveErrorMessage/>
	</cffunction>

	<!--- 4 --->
	<!--- update leaves --->
	<cffunction name="addLeave" hint="insert Leave details to leave table" access="public" output="false" returntype="boolean">
		<!--- Arguments --->
		<cfargument name="employeeId" type="numeric" required="true"/>
		<cfargument  name="fromDate" type="date" required="true"/>
		<cfargument  name="toDate" type="date" required="true"/>
		<cfargument  name="numberDays" type="numeric" required="true"/>
		<cfargument name="reason" type="string" required="true"/>
		<cfargument name="year" type="string" required="true"/>
		<cftry>		<!--- try block for handle exception --->
			<!--- insert into leave taken table --->
			<cfquery name="addLeave">
				INSERT INTO leaveTaken VALUES(
									<cfqueryparam cfsqltype="CF_SQL_INT" value="#ARGUMENTS.employeeId#"/>,
									<cfqueryparam cfsqltype="CF_SQL_DATE" value="#ARGUMENTS.fromDate#"/>,
									<cfqueryparam cfsqltype="CF_SQL_DATE" value="#ARGUMENTS.toDate#"/>,
									<cfqueryparam cfsqltype="CF_SQL_INT" value="#ARGUMENTS.numberDays#"/>,
									<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ARGUMENTS.reason#"/>
									);

			</cfquery>

			<!--- update into employeeAnnualLeave --->
			<cfquery name="updateAnnualLeave">
				UPDATE employeeAnnualLeave SET
						totalLeaveTaken = totalLeaveTaken + <cfqueryparam cfsqltype="CF_SQL_INT" value="#ARGUMENTS.numberDays#"/>,
						totalRemainingLeave = totalRemainingLeave - <cfqueryparam cfsqltype="CF_SQL_INT" value="#ARGUMENTS.numberDays#"/>
						WHERE  empId = <cfqueryparam cfsqltype="CF_SQL_INT" value="#ARGUMENTS.employeeId#"/> and
						leaveYear = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ARGUMENTS.year#"/>

			</cfquery>
		<cfcatch type="Database">	<!--- catch block for database exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Database Error on component : employeeService on function : addLeave"/>
			<cflocation url="../common/error.cfm">
		</cfcatch>	<!--- end database exception --->
		<cfcatch type="any">	<!--- catch block for any exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Any Error on component : employeeService on function : addLeave "/>
			<cflocation url="../common/error.cfm">
		</cfcatch>	<!--- end any exception --->
		</cftry>	<!--- end dtry block --->
		<cfreturn true/>
	</cffunction>

	<!--- 4 --->
	<!--- Fetch salary details of an employee --->
	<cffunction name="getSalaryDetails" hint="fetch the salary details of the employee" access="public" output="false" returntype="query">
		<cfargument name="employeeId" type="numeric" required="true"/>
		<cftry>		<!--- try block for handle exception --->
			<cfquery name="salaryDetails">
				SELECT emp.basicSalary,sal.hra,sal.otherAllowances,sal.deduction,emp.basicSalary+sal.hra+otherAllowances-deduction total ,
				sal.creditDate FROM employees emp JOIN salaries sal ON emp.empId = sal.empId
				WHERE  emp.empId = <cfqueryparam cfsqltype="CF_SQL_INT" value="#ARGUMENTS.employeeId#"/>
			</cfquery>
		<cfcatch type="Database">	<!--- catch block for database exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Database Error on component : employeeService on function : getSalaryDetails"/>
			<cflocation url="../../common/error.cfm">
		</cfcatch>	<!--- end database exception --->
		<cfcatch type="any">	<!--- catch block for any exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Any Error on component : employeeService on function : getSalaryDetails "/>
			<cflocation url="../../common/error.cfm">
		</cfcatch>	<!--- end any exception --->
		</cftry>	<!--- end dtry block --->
		<cfreturn salaryDetails/>
	</cffunction>

	<!--- 5 --->
	<!--- check for update personal information --->
	<cffunction name="checkUpdatePersonalDetails" hint="check employee entry" access="public" output="false" returntype="Struct">

		<cfset var updatePersonalDetailsErrorMessage={dob="",phoneNumber=""}/>

		<cfif FORM.dateOfBirth EQ "">
			<cfset updatePersonalDetailsErrorMessage.dob="Date of Birth should not be empty"/>
		<cfelse>
			<cfset var date = #DateFORMat(FORM.dateOfBirth)#>
			<cfset var today = #DateFORMat(now())#>
			<cfif date gt today>
				<cfset updatePersonalDetailsErrorMessage.dob="Date of Birth should not be greater than today's date"/>
			</cfif>
		</cfif>

		<cfif Trim(FORM.phoneNumber) EQ "">
			<cfset updatePersonalDetailsErrorMessage.phoneNumber="PhoneNumber should not be empty"/>
		<cfelseif REFind("^[1-9][0-9]{9}$",Trim(FORM.phoneNumber),1) EQ 0>
			<cfset updatePersonalDetailsErrorMessage.phoneNumber="Phone number must be 10 numbers (Ex:98XXXXXX66)"/>
		</cfif>
		<cfreturn updatePersonalDetailsErrorMessage/>
	</cffunction>

	<!--- 6 --->
	<!--- update personal information --->
	<cffunction name="updatePersonalDetails" hint="Update personal details in Employee Table " access="public" output="false" returntype="boolean">
		<cfargument name="employeeId" type="numeric" required="true"/>
		<cfargument  name="dob" type="date" required="true"/>
		<cfargument  name="gender" type="string" required="true"/>
		<cfargument  name="phoneNumber" type="numeric" required="true"/>

		<cftry>		<!--- try block for handle exception --->
			<cfquery name="employee">

				UPDATE employees SET dateOfBirth = <cfqueryparam cfsqltype="CF_SQL_DATE" value="#ARGUMENTS.dob#"/> ,
									  gender = <cfqueryparam cfsqltype="CF_SQL_CHAR" value="#ARGUMENTS.gender#"/> ,
									  phoneNumber = <cfqueryparam cfsqltype="CF_SQL_BIGINT" value="#ARGUMENTS.phoneNumber#"/>
									  WHERE empId = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ARGUMENTS.employeeId#"/>

			</cfquery>
		<cfcatch type="Database">	<!--- catch block for database exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Database Error on component : employeeService on function : updatePersonalDetails"/>
			<cflocation url="../common/error.cfm">
		</cfcatch>	<!--- end database exception --->
		<cfcatch type="any">	<!--- catch block for any exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Any Error on component : employeeService on function : updatePersonalDetails "/>
			<cflocation url="../common/error.cfm">
		</cfcatch>	<!--- end any exception --->
		</cftry>	<!--- end dtry block --->
		<cfreturn true/>
	</cffunction>

	<!--- 7 --->
	<!--- add skills --->
	<cffunction name="addSkill" hint="insert skill in to employee skill table" access="remote" output="false" returntype="boolean"  returnformat = "JSON">
		<!--- Arguments --->
		<cfargument name="employeeId" type="numeric" required="true"/>
		<cfargument  name="skillId" type="numeric" required="true"/>

		<cftry>		<!--- try block for handle exception --->

			<cfquery name="checkSkill">
				SELECT skillId FROM employeeSkills WHERE
									empId = <cfqueryparam cfsqltype="CF_SQL_INT" value="#ARGUMENTS.employeeId#"/> AND
									skillId = <cfqueryparam cfsqltype="CF_SQL_INT" value="#ARGUMENTS.skillId#"/>
			</cfquery>

			<cfif checkSkill.recordCount EQ 0>
				<!--- insert into employee skills table --->
				<cfquery name="addSkill">
					INSERT INTO employeeSkills VALUES(
									<cfqueryparam cfsqltype="CF_SQL_INT" value="#ARGUMENTS.employeeId#"/>,
									<cfqueryparam cfsqltype="CF_SQL_INT" value="#ARGUMENTS.skillId#"/>
									);
				</cfquery>
			<cfelse>
				<cfreturn false>
			</cfif>
		<cfcatch type="Database">	<!--- catch block for database exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Database Error on component : employeeService on function : addSkill"/>
			<cflocation url="../common/error.cfm">
		</cfcatch>	<!--- end database exception --->
		<cfcatch type="any">	<!--- catch block for any exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Any Error on component : employeeService on function : addSkill "/>
			<cflocation url="../common/error.cfm">
		</cfcatch>	<!--- end any exception --->
		</cftry>	<!--- end dtry block --->

		<cfreturn true/>
	</cffunction>

	<!--- 8 --->
	<!--- Fetch employee personal details  --->
	<cffunction name="getPersonalDetail" hint="fetch the employee personal details" access="public" output="false" returntype="query">
		<cfargument name="employeeId" type="numeric" required="true"/>
		<cftry>		<!--- try block for handle exception --->
			<cfquery name="personalDetails">
				SELECT emp.firstName,emp.middleName,emp.lastName,emp.email,emp.dateOfBirth,
				CONCAT(e.firstName,' ',e.middleName,' ',e.lastName) manager,
				CASE emp.gender WHEN 'm' THEN 'Male'
								WHEN 'f' THEN 'Female'
								WHEN 'O' THEN 'Other'
				END gender,
				emp.joiningDate,dept.departmentName,emp.basicSalary,empRole.roleName,emp.phoneNumber,emp.isActive FROM
				employees emp JOIN employeeRole empRole ON emp.roleId = empRole.roleId JOIN department dept ON
				empRole.departmentId = dept.departmentId JOIN employees e on dept.departmentHead = e.empId WHERE emp.empId =
				<cfqueryparam cfsqltype="CF_SQL_INT" value="#ARGUMENTS.employeeId#"/>

			</cfquery>
		<cfcatch type="Database">	<!--- catch block for database exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Database Error on component : employeeService on function : getPersonalDetail"/>
			<cflocation url="../common/error.cfm">
		</cfcatch>	<!--- end database exception --->
		<cfcatch type="any">	<!--- catch block for any exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Any Error on component : employeeService on function : getPersonalDetail "/>
			<cflocation url="../common/error.cfm">
		</cfcatch>	<!--- end any exception --->
		</cftry>	<!--- end dtry block --->
		<cfreturn personalDetails/>
	</cffunction>

	<!--- 9 --->
	<!--- Fetch leave history an employee --->
	<cffunction name="getLeaveTakenDetails" hint="fetch the past leave details" access="public" output="false" returntype="query">
		<cfargument name="employeeId" type="numeric" required="true"/>
		<cftry>		<!--- try block for handle exception --->
			<cfquery name="leaveTakenDetails">
				SELECT reason,leaveFromDate,leaveToDate,totalNumberOfDays FROM leaveTaken
				WHERE empId = <cfqueryparam cfsqltype="CF_SQL_INT" value="#ARGUMENTS.employeeId#"/>
			</cfquery>
		<cfcatch type="Database">	<!--- catch block for database exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Database Error on component : employeeService on function : getLeaveTakenDetails"/>
			<cflocation url="../common/error.cfm">
		</cfcatch>	<!--- end database exception --->
		<cfcatch type="any">	<!--- catch block for any exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Any Error on component : employeeService on function : getLeaveTakenDetails "/>
			<cflocation url="../common/error.cfm">
		</cfcatch>	<!--- end any exception --->
		</cftry>	<!--- end dtry block --->
		<cfreturn leaveTakenDetails/>
	</cffunction>

	<!--- 10 --->
	<!--- Fetch project details of an employee --->
	<cffunction name="getEmployeeProjectDetails" hint="fetch the project details of the employee" access="public" output="false" returntype="query">
		<cfargument name="employeeId" type="numeric" required="true"/>
		<cftry>		<!--- try block for handle exception --->
			<cfquery name="employeeProjectDetails">
				SELECT proj.projectName,(SELECT CONCAT(ISNULL(e.firstName,''),' ',ISNULL(e.middleName,''),' ',ISNULL(e.lastName,'')) name
				FROM employees e WHERE e.empId = proj.projectMgrId) as manager,empProject.projectjoinDate,empProject.projectFinishDate FROM project proj
				JOIN employeeProject empProject ON proj.projectId = empProject.projectId JOIN employees emp ON emp.empId = empProject.empId WHERE
				emp.empId = <cfqueryparam cfsqltype="CF_SQL_INT" value="#ARGUMENTS.employeeId#"/>
			</cfquery>
		<cfcatch type="Database">	<!--- catch block for database exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Database Error on component : employeeService on function : getEmployeeProjectDetails"/>
			<cflocation url="../common/error.cfm">
		</cfcatch>	<!--- end database exception --->
		<cfcatch type="any">	<!--- catch block for any exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Any Error on component : employeeService on function : getEmployeeProjectDetails "/>
			<cflocation url="../common/error.cfm">
		</cfcatch>	<!--- end any exception --->
		</cftry>	<!--- end dtry block --->
		<cfreturn employeeProjectDetails/>
	</cffunction>

	<!--- 11 --->
	<!--- Fetch skills of a perticular employee  --->
	<cffunction name="getSkillDetails" hint="fetch the skills of employee" access="remote" output="false" returntype="query" returnformat = "JSON">
		<cfargument name="employeeId" type="numeric" required="true"/>
		<cftry>		<!--- try block for handle exception --->
			<cfquery name="skillDetails">
				SELECT skill.skillName FROM skills skill JOIN employeeSkills empSkill ON skill.skillId=empSkill.skillId JOIN employees emp
				ON emp.empId = empSkill.empId WHERE emp.empId = <cfqueryparam cfsqltype="CF_SQL_INT" value="#ARGUMENTS.employeeId#"/>
			</cfquery>
		<cfcatch type="Database">	<!--- catch block for database exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Database Error on component : employeeService on function : getSkillDetails"/>
			<cflocation url="../common/error.cfm">
		</cfcatch>	<!--- end database exception --->
		<cfcatch type="any">	<!--- catch block for any exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Any Error on component : employeeService on function : getSkillDetails "/>
			<cflocation url="../common/error.cfm">
		</cfcatch>	<!--- end any exception --->
		</cftry>	<!--- end dtry block --->
		<cfreturn skillDetails/>
	</cffunction>

	<!--- 12 --->
	<!--- Fetch all the skill from skills table --->
	<cffunction name="getSkills" hint="fetch all the skills" access="public" output="false" returntype="query">
		<cftry>		<!--- try block for handle exception --->
			<cfquery name="skills">
				SELECT skillId,skillName FROM skills;
			</cfquery>
		<cfcatch type="Database">	<!--- catch block for database exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Database Error on component : employeeService on function : getSkills"/>
			<cflocation url="../common/error.cfm">
		</cfcatch>	<!--- end database exception --->
		<cfcatch type="any">	<!--- catch block for any exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Any Error on component : employeeService on function : getSkills "/>
			<cflocation url="../common/error.cfm">
		</cfcatch>	<!--- end any exception --->
		</cftry>	<!--- end dtry block --->
		<cfreturn skills/>
	</cffunction>

	<!--- 13 --->
	<!--- Fetch all the skill from skills table --->
	<cffunction name="getGoals" hint="fetch goals from the Goal table" access="public" output="false" returntype="query">
		<cfargument name="employeeId" type="numeric" required="true"/>
		<cfargument name="date" type="date" required="true"/>
		<cftry>		<!--- try block for handle exception --->
			<cfquery name="goal">
				SELECT date,goal FROM goal WHERE empId = <cfqueryparam cfsqltype="CF_SQL_INT" value="#ARGUMENTS.employeeId#"/> AND
													date = <cfqueryparam cfsqltype="CF_SQL_DATE" value="#ARGUMENTS.date#"/>;
			</cfquery>
		<cfcatch type="Database">	<!--- catch block for database exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Database Error on component : employeeService on function : getSkills"/>
			<cflocation url="../common/error.cfm">
		</cfcatch>	<!--- end database exception --->
		<cfcatch type="any">	<!--- catch block for any exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Any Error on component : employeeService on function : getSkills "/>
			<cflocation url="../common/error.cfm">
		</cfcatch>	<!--- end any exception --->
		</cftry>	<!--- end dtry block --->
		<cfreturn goal/>
	</cffunction>

	<!--- 14 --->
	<!--- add goal --->
	<cffunction name="addGoal" hint="insert skill in to employee skill table" access="remote" output="false" returntype="boolean" returnformat = "JSON">
		<!--- Arguments --->
		<cfargument name="employeeId" type="numeric" required="true"/>
		<cfargument  name="goal" type="string" required="true"/>
		<cftry>		<!--- try block for handle exception --->

			<cfquery name="checkGoal">
				SELECT empId FROM goal WHERE
									empId = <cfqueryparam cfsqltype="CF_SQL_INT" value="#ARGUMENTS.employeeId#"/> AND
									date =GETDATE() AND goal = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ARGUMENTS.goal#"/>
			</cfquery>

			<cfif checkGoal.recordCount EQ 0>
				<!--- insert into employee skills table --->
				<cfquery name="addGoal">
					INSERT INTO goal (empId,goal) VALUES(
									<cfqueryparam cfsqltype="CF_SQL_INT" value="#ARGUMENTS.employeeId#"/>,
									<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ARGUMENTS.goal#"/>
									);

				</cfquery>
			<cfelse>
				<cfreturn false/>
			</cfif>
		<cfcatch type="Database">	<!--- catch block for database exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Database Error on component : employeeService on function : addGoal"/>
			<cflocation url="../common/error.cfm">
		</cfcatch>	<!--- end database exception --->
		<cfcatch type="any">	<!--- catch block for any exception --->
			<cflog file="EmployeeManagementSystemLog" application="no" text="Any Error on component : employeeService on function : addGoal "/>
			<cflocation url="../common/error.cfm">
		</cfcatch>	<!--- end any exception --->
		</cftry>	<!--- end dtry block --->

		<cfreturn true/>
	</cffunction>
</cfcomponent>