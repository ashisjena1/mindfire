<!--- Checking for user Login --->
<cfif structKeyExists(SESSION,'setLoggedInUser')>
	<!--- Checking for Logout --->
	<cfif structKeyExists(URL,'logout')>
		<cfset APPLICATION.loginService.doLogout()/>
		<cflocation url="../../index.cfm">
	</cfif>
	<!--- Checking for submit button click --->
	<cfif not structKeyExists(FORM,'updateDetails')>
		<!--- Initializing the error message in updatePersonalDetailsErrorMessage structure --->
		<cfset VARIABLES.updatePersonalDetailsErrorMessage ={dob='',phoneNumber=''}/>
		<cfelse>
			<!--- Checking input data for server side validation --->
			<cfset VARIABLES.updatePersonalDetailsErrorMessage=APPLICATION.personalService.checkUpdatePersonalDetails()/>
			<cfif VARIABLES.updatePersonalDetailsErrorMessage.dob eq '' and VARIABLES.updatePersonalDetailsErrorMessage.phoneNumber eq ''>
				<!--- If no error then update data to the employee table --->
				<cfset VARIABLES.isPersonalDetailsUpdated = APPLICATION.personalService.updatePersonalDetails(SESSION.setLoggedInUser.empId,FORM.dateOfBirth,FORM.gender,FORM.phoneNumber)/>
			</cfif>
	</cfif>
	<cfif structKeyExists(FORM,'addSkill')>
		<cfset VARIABLES.isSkillAdded = APPLICATION.personalService.addSkill(SESSION.setLoggedInUser.empId,FORM.newSkill)/>
	</cfif>

	<!--- Fetch personal details of the employee --->
	<cfset VARIABLES.personalDetails = APPLICATION.personalService.getPersonalDetail(SESSION.setLoggedInUser.empId)/>
	<!--- Fetch leave history of the employee --->
	<cfset VARIABLES.leaveTakenDetails = APPLICATION.personalService.getLeaveTakenDetails(SESSION.setLoggedInUser.empId)/>
	<!--- Fetch project details of the employee --->
	<cfset VARIABLES.employeeProjectDetails = APPLICATION.personalService.getEmployeeProjectDetails(SESSION.setLoggedInUser.empId)/>
	<!--- Fetch skills of the current employee --->
	<cfset VARIABLES.skillDetails = APPLICATION.personalService.getSkillDetails(SESSION.setLoggedInUser.empId)/>
	<!--- Fetch leave details of the employee of the current year --->
	<cfset VARIABLES.leaveDetails = APPLICATION.personalService.getLeaveDetails(SESSION.setLoggedInUser.empId,#Year(now())#)/>

	<cfset VARIABLES.name="#SESSION.setLoggedInUser.firstName# #SESSION.setLoggedInUser.lastName#">
	<!--- custom tag for headerfooter --->
	<cf_headerFooter title="profile Page">
		<!--- import external stylesheet --->
		<link rel="stylesheet" type="text/css" href="../../assets/css/admin.css">
		<link rel="stylesheet" type="text/css" href="../../assets/css/profile.css">

		</head>
		<body>
			<!--- custom tag for top nav bar --->
			<cf_navbar name="#VARIABLES.name#" source="../assets/images/" homeSource="../"></cf_navbar>
			<cfoutput>
				<div class="sidenav">
					<cfif #UCase(SESSION.setLoggedInUser.empRole)# EQ "HR">
					 	<a href="../admin/views/addEmployee.cfm">Add Employee</a>
					 	<a href="../admin/views/addProject.cfm">Add Project</a>
					 	<a href="../admin/views/projectDetails.cfm">Project Details</a>
					 	<a href="../admin/views/assignProject.cfm">Assign Project</a>
					</cfif>
					<a href="applyLeaves.cfm">Apply Leaves</a>
					<a href="salary.cfm">Salary</a>
				</div>
			</cfoutput>
				<div class="main">

					<div class="row topbar">
						<button class="tablink" id = "personalDetails">Personal Details</button>
						<button class="tablink" id= "projectDetails">Project Details</button>
						<button class="tablink" id= "skillsDetails">Skills Details</button>
						<button class="tablink" id= "annualLeaveDetails">Leave Balance</button>
						<button class="tablink" id= "leaveHistory">Leave History</button>
					</div>

					<div class = "profile">
						<div id="personalDetailsTemplate" class="tabcontent">
							<cfinclude template="../include/personalDetails.cfm"/>
						</div>

						<div id="projectDetailsTemplate" class="tabcontent">
							<cfinclude template="../include/projectDetails.cfm"/>
						</div>

						<div id="skillDetailsTemplate" class="tabcontent">
							<cfinclude template="../include/skillDetails.cfm"/>
						</div>

						<div id="annualLeaveDetailsTemplate" class="tabcontent">
							<cfinclude template="../include/annualLeaveDetails.cfm"/>
						</div>

						<div id="leaveHistoryTemplate" class="tabcontent">
							<cfinclude template="../include/leaveHistory.cfm"/>
						</div>
					</div> <!---End profile --->


				</div>	<!---End main --->

		<!--- import external stylesheet --->
		<script type = "text/javascript" src = "../../assets/javaScript/profile.js"></script>
	</cf_headerFooter>
<cfelse>
	<cflocation url="../index.cfm">
</cfif>
