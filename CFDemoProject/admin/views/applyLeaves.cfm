<!--- Checking for user Login --->
<cfif structKeyExists(SESSION,"setLoggedInUser")>
	<!--- Checking for Logout --->
	<cfif structKeyExists(URL,"logout")>
		<cfset APPLICATION.loginService.doLogout()/>
		<cflocation url="../../index.cfm">
	</cfif>
	<!--- Checking the user is HR or Not --->
	<cfif #UCase(SESSION.setLoggedInUser.empRole)# EQ "HR">
		<cfset name="#SESSION.setLoggedInUser.firstName# #SESSION.setLoggedInUser.lastName#">

		<cfparam name="isLeaveApplied" default="false">
		<!--- Checking for submit button click --->
		<cfif not structKeyExists(FORM,"applyLeaveSubmit")>
			<!--- Setting the error message in addProjectErrorMessage structure --->
			<cfset applyLeaveErrorMessage = {fromDate="",toDate="",numberOfDays="",reason=""}/>
		<cfelse>
			<!--- Checking admin input data for server side validation --->
			<cfset applyLeaveErrorMessage=APPLICATION.personalService.checkApplyLeaveDetails(SESSION.setLoggedInUser.empId)/>
			<cfif applyLeaveErrorMessage.fromDate EQ ""  and applyLeaveErrorMessage.toDate EQ "" and
					applyLeaveErrorMessage.numberOfDays EQ "" and applyLeaveErrorMessage.reason EQ "">
					<!--- If no error then add data to the employee table --->
					<cfset isLeaveApplied = APPLICATION.personalService.addLeave(SESSION.setLoggedInUser.empId,FORM.fromDate,FORM.toDate,FORM.totalDays,FORM.reason,FORM.year)/>
			</cfif>
		</cfif>

		<!--- If Leave added successfully then redirect to home page --->
		<cfif isLeaveApplied>
			<cflocation url="../index.cfm">
		<cfelse><!--- else show the add project form --->
			<cf_headerFooter title="Apply Leaves">
				<!--- Import external stylesheet --->
				<link rel="stylesheet" type="text/css" href="../../assets/css/admin.css">
				<link rel="stylesheet" type="text/css" href="../../assets/css/adminPageStyle.css">

				</head>
				<body>
					<!--- custom tag for top nav bar --->
					<cf_navbar name="#name#" source="../../assets/images/" homeSource="../" profileSource="profile.cfm"></cf_navbar>
					<!--- Side navbar --->
					<div class="sidenav">
					  <a href="addEmployee.cfm">Add Employee</a>
					  <a href="addProject.cfm">Add Project</a>
					  <a href="projectDetails.cfm">Project Details</a>
					  <a href="assignProject.cfm">Assign Project</a>
					  <a href="applyLeaves.cfm">Apply Leaves</a>
					  <a href="salary.cfm">Salary</a>
					</div><!--- end side navbar --->
					<!--- main content --->
					<div class="main">
							<div class="container"><!--- container --->
								<div class="card card-container">
									<cfform class="form-horizontal" id="applyLeave">
										<cfoutput>
											<h2>Apply Leave</h2>
											<div class="form-group">
												<label for="fromDate" class="col-sm-4 control-label">From Date*</label>
												<div class="col-sm-8">
													<input type="date" id="fromDate" name="fromDate" class="form-control">
												</div>
												 <div class="col-sm-4"></div>
												<div class="col-sm-8"><span class="text-danger" id="fromDateError">#applyLeaveErrorMessage.fromDate#</span></div>
											</div>
											<div class="form-group">
												<label for="toDate" class="col-sm-4 control-label">To Date*</label>
												<div class="col-sm-8">
													<input type="date" id="toDate" name="toDate" class="form-control">
												</div>
												 <div class="col-sm-4"></div>
												<div class="col-sm-8"><span class="text-danger" id="toDateError">#applyLeaveErrorMessage.toDate#</span></div>
											</div>
											<div class="form-group">
												<label for="totalDays" class="col-sm-4 control-label">Total Days*</label>
												<div class="col-sm-8">
													<input type="number" id="totalDays" name="totalDays" placeholder="Number of Days" class="form-control" >
												</div>
												<div class="col-sm-4"></div>
												<div class="col-sm-8"><span class="text-danger" id="totalDaysError">#applyLeaveErrorMessage.numberOfDays#</span></div>
											</div>
											<div class="form-group">
												<label for="reason" class="col-sm-4 control-label">Reason*</label>
												<div class="col-sm-8">
													<textarea id="reason" name="reason"  class="form-control" placeholder="Reason for leave"></textarea>
												</div>
												 <div class="col-sm-4"></div>
												<div class="col-sm-8"><span class="text-danger" id="reasonError">#applyLeaveErrorMessage.reason#</span></div>
											</div>
											<input type="hidden" name="year" value="#Year(now())#">
											<input type="submit" class="btn btn-primary btn-block" value="Apply Leave" name="applyLeaveSubmit"/>
										</cfoutput>
									</cfform>
								</div>
							 </div><!--- end container --->
					</div><!--- end main --->
					<!--- import external javascript --->
					<script type = "text/javascript" src = "../../assets/javaScript/applyLeave.js"></script>
			</cf_headerFooter><!--- end header footer custom tag --->
		</cfif><!--- end if clause for leave Applied successfully or not added or not --->
	<cfelse><!--- if employee is not hr then it will show a message --->
		You are not authorized to open this page.
	</cfif>
<cfelse><!--- if employee is not logged in then it will redirect to login page --->
	<cflocation url="../../index.cfm">
</cfif>