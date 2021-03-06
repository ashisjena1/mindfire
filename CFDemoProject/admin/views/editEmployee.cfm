<!--- Checking for user Login --->
<cfif structKeyExists(SESSION,'setLoggedInUser')>
	<!--- Checking for Logout --->
	<cfif structKeyExists(URL,'logout')>
		<cfset APPLICATION.loginService.doLogout()/>
		<cflocation url="../../index.cfm">
	</cfif>
	<cfif #UCase(SESSION.setLoggedInUser.empRole)# EQ "HR">
	<!--- Checking for submit button click --->
	<cfif not structKeyExists(FORM,'updateDetails')>
		<!--- Initializing the error message in updateEmployeeDetailsErrorMessage structure --->
		<cfset VARIABLES.updateEmployeeDetailsErrorMessage ={salary=''}/>
		<cfelse>
			<!--- Checking input data for server side validation --->
			<cfset VARIABLES.updateEmployeeDetailsErrorMessage=APPLICATION.adminService.checkUpdateEmployeeDetails()/>
			<cfif VARIABLES.updateEmployeeDetailsErrorMessage.salary eq ''>
				<!--- If no error then update data to the employee table --->
				<cfset VARIABLES.isEmployeeDetailsUpdated = APPLICATION.adminService.updateEmployeeDetails(URL.Id,FORM.roleId,FORM.basicSalary)/>
			</cfif>
	</cfif>

	<cfset VARIABLES.name="#SESSION.setLoggedInUser.firstName# #SESSION.setLoggedInUser.lastName#">
	<!--- custom tag for headerfooter --->
	<cf_headerFooter title="profile Page">
		<!--- import external stylesheet --->
		<link rel="stylesheet" type="text/css" href="../../assets/css/admin.css">
		<link rel="stylesheet" type="text/css" href="../../assets/css/profile.css">

		</head>
		<body>
			<!--- custom tag for top nav bar --->
			<cf_navbar name="#VARIABLES.name#" source="../../assets/images/" homeSource="../" profileSource="../../common/profile.cfm"></cf_navbar>
			<cfoutput>
				<!--- Fetch personal details of the employee --->
				<cfset VARIABLES.employeePersonalDetails = APPLICATION.personalService.getPersonalDetail(URL.id)/>
				<!--- Fetch leave details of the employee of the current year --->
				<cfset VARIABLES.leaveDetails = APPLICATION.personalService.getLeaveDetails(URL.id,#Year(now())#)/>
				<!--- Fetch leave history of the employee --->
				<cfset VARIABLES.leaveTakenDetails = APPLICATION.personalService.getLeaveTakenDetails(URL.id)/>
				<!--- Fetch project details of the employee --->
				<cfset VARIABLES.employeeProjectDetails = APPLICATION.personalService.getEmployeeProjectDetails(URL.id)/>
				<!--- Fetch skills of the current employee --->
				<cfset VARIABLES.skillDetails = APPLICATION.personalService.getSkillDetails(URL.id)/>
			</cfoutput>
				 <div class="sidenav">
					<a href="addEmployee.cfm">Add Employee</a>
					  <a href="addProject.cfm">Add Project</a>
					  <a href="projectDetails.cfm">Project Details</a>
					  <a href="assignProject.cfm">Assign Project</a>
					  <a href="../../common/applyLeaves.cfm">Apply Leaves</a>
					  <a href="../../common/salary.cfm">Salary</a>
				</div>

				<div class="main">
					<div class="row topbar">
						<button class="tablink" id = "personalDetails">Personal Details</button>
						<button class="tablink" id= "projectDetails">Project Details</button>
						<button class="tablink" id= "skillsDetails">Skills Details</button>
						<button class="tablink" id= "annualLeaveDetails">Leave Balance</button>
						<button class="tablink" id= "leaveHistory">Leave History</button>
					</div>
					<div class="profile">
						<div id="personalDetailsTemplate" class="tabcontent">
							<cfinclude template="../../include/employeePersonalDetails.cfm"/>
						</div>

						<div id="projectDetailsTemplate" class="tabcontent">
							<cfinclude template="../../include/projectDetails.cfm"/>
						</div>

						<div id="skillDetailsTemplate" class="tabcontent">
							<cfinclude template="../../include/skillDetails.cfm"/>
						</div>

						<div id="annualLeaveDetailsTemplate" class="tabcontent">
							<cfinclude template="../../include/annualLeaveDetails.cfm"/>
						</div>

						<div id="leaveHistoryTemplate" class="tabcontent">
							<cfinclude template="../../include/leaveHistory.cfm"/>
						</div>
					</div>


				</div>	<!---End main --->
		<!--- import external stylesheet --->
		<script type = "text/javascript" src = "../../assets/javaScript/editEmployee.js"></script>
	</cf_headerFooter>
	<cfelse><!--- if employee is not hr then it will show a message --->
		You are not authorized to open this page.
	</cfif>
<cfelse>
	<cflocation url="../index.cfm">
</cfif>
