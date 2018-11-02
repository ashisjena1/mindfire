<!--- Checking for user Login --->
<cfif structKeyExists(SESSION,"setLoggedInUser")>
		<!--- Checking for Logout --->
		<cfif structKeyExists(URL,"logout")>
			<cfset APPLICATION.loginService.doLogout()/>
			<cflocation url="../index.cfm">
		</cfif>

		<cfset VARIABLES.name="#SESSION.setLoggedInUser.firstName# #SESSION.setLoggedInUser.lastName#">

		<cfparam name="VARIABLES.isLeaveApplied" default="false">
		<!--- Checking for submit button click --->
		<cfif not structKeyExists(FORM,"applyLeaveSubmit")>
			<!--- Setting the error message in addProjectErrorMessage structure --->
			<cfset VARIABLES.applyLeaveErrorMessage = {fromDate="",toDate="",numberOfDays="",reason=""}/>
		<cfelse>
			<!--- Checking admin input data for server side validation --->
			<cfset VARIABLES.applyLeaveErrorMessage=APPLICATION.employeeService.checkApplyLeaveDetails(SESSION.setLoggedInUser.empId)/>
			<cfif VARIABLES.applyLeaveErrorMessage.fromDate EQ ""  and VARIABLES.applyLeaveErrorMessage.toDate EQ "" and
					VARIABLES.applyLeaveErrorMessage.numberOfDays EQ "" and VARIABLES.applyLeaveErrorMessage.reason EQ "">
					<!--- If no error then add data to the employee table --->
					<cfset VARIABLES.isLeaveApplied = APPLICATION.employeeService.addLeave(SESSION.setLoggedInUser.empId,FORM.fromDate,FORM.toDate,FORM.totalDays,FORM.reason,FORM.year)/>
			</cfif>
		</cfif>

		<!--- If Leave added successfully then redirect to home page --->
		<cfif VARIABLES.isLeaveApplied>
			<h5 class = "text-sucsess">Leave Applied Successfully</h5>
		</cfif>
		<cf_headerFooter title="Apply Leaves">
				<!--- Import external stylesheet --->
				<link rel="stylesheet" type="text/css" href="../../assets/css/admin.css">
				<link rel="stylesheet" type="text/css" href="../../assets/css/adminPageStyle.css">

				</head>
				<body>
					<!--- custom tag for top nav bar --->
					<cf_navbar name="#VARIABLES.name#" source="../assets/images/" homeSource="../" profileSource="profile.cfm"></cf_navbar>
					<!--- Side navbar --->
					<div class="sidenav">
						<cfif #UCase(SESSION.setLoggedInUser.empRole)# EQ "ADMIN">
					  		<a href="../admin/views/addEmployee.cfm">Add Employee</a>
					  		<a href="../admin/views/addProject.cfm">Add Project</a>
					  		<a href="../admin/views/projectDetails.cfm">Project Details</a>
					  		<a href="../admin/views/assignProject.cfm">Assign Project</a>
					 	</cfif>
					  	<a href="">Apply Leaves</a>
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
												<div class="col-sm-8"><span class="text-danger" id="fromDateError">#VARIABLES.applyLeaveErrorMessage.fromDate#</span></div>
											</div>
											<div class="form-group">
												<label for="toDate" class="col-sm-4 control-label">To Date*</label>
												<div class="col-sm-8">
													<input type="date" id="toDate" name="toDate" class="form-control">
												</div>
												 <div class="col-sm-4"></div>
												<div class="col-sm-8"><span class="text-danger" id="toDateError">#VARIABLES.applyLeaveErrorMessage.toDate#</span></div>
											</div>
											<div class="form-group">
												<label for="totalDays" class="col-sm-4 control-label">Total Days*</label>
												<div class="col-sm-8">
													<input type="number" id="totalDays" name="totalDays" placeholder="Number of Days" class="form-control" >
												</div>
												<div class="col-sm-4"></div>
												<div class="col-sm-8"><span class="text-danger" id="totalDaysError">#VARIABLES.applyLeaveErrorMessage.numberOfDays#</span></div>
											</div>
											<div class="form-group">
												<label for="reason" class="col-sm-4 control-label">Reason*</label>
												<div class="col-sm-8">
													<textarea id="reason" name="reason"  class="form-control" placeholder="Reason for leave"></textarea>
												</div>
												 <div class="col-sm-4"></div>
												<div class="col-sm-8"><span class="text-danger" id="reasonError">#VARIABLES.applyLeaveErrorMessage.reason#</span></div>
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

<cfelse><!--- if employee is not logged in then it will redirect to login page --->
	<cflocation url="../index.cfm">
</cfif>