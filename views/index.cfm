<!--- Checking for user Login--->
<cfif structKeyExists(SESSION,"setLoggedInUser")>
	<!--- Checking for Logout--->
	<cfif structKeyExists(URL,"logout")>
		<cfset APPLICATION.loginService.doLogout()/>
		<cflocation url="../index.cfm">
	</cfif>
	<!--- Fetch personal details of the employee --->
	<cfset VARIABLES.personalDetails = APPLICATION.employeeService.getEmployeeDetail(SESSION.setLoggedInUser.empId)/>
	<!--- Checking for add goals button  --->
	<cfif structKeyExists(FORM,'addGoal')>
		<cfset  APPLICATION.employeeService.addGoal(SESSION.setLoggedInUser.empId,#now()#,FORM.goal)/>
	</cfif>
	<!--- Fetch Goal details of the employee --->
	<cfset VARIABLES.goals = APPLICATION.employeeService.getGoals(SESSION.setLoggedInUser.empId,#now()#)/>



	<cfset VARIABLES.name="#SESSION.setLoggedInUser.firstName# #SESSION.setLoggedInUser.lastName#">
	<!--- Custom Tag for header and footer--->
	<cf_headerFooter title="Home page">
				<!--- import the home stylesheet --->
				<link rel="stylesheet" type="text/css" href="../assets/css/home.css">
			</head>
			<body>
				<cf_navbar name="#VARIABLES.name#" source="../assets/images/" profileSource="profile.cfm"></cf_navbar>
				<!--- Side navbar --->
				<div class="sidenav">
					  <a href="applyLeaves.cfm">Apply Leaves</a>
					  <a href="salary.cfm">Salary</a>
				</div><!--- end side navbar --->

				<cfoutput>
					<!--- main content --->
					<div class="main">
						<div class = "row">
							<div class="col-md-2">#VARIABLES.personalDetails.departmentName#</div>
							<div class="col-md-2">ROLE  : #VARIABLES.personalDetails.roleName#</div>
							<div class="col-md-6"></div>
							<div class="col-md-2 text-primary"><h5>#dateFormat(now(),"mmm dd,yyy")#</h5></div>
						</div>
						<hr>
						<div class = "row">
							<div class="col-md-4">
								WORKING WITH : #VARIABLES.personalDetails.manager#<br>
								PROJECT : #VARIABLES.personalDetails.projectName#<br>
							</div>
							<div class="col-md-2"></div>
							<div class="col-md-6">
								<div class="panel">
									<div class="row">
										<div class="col-md-1"></div>
										<div class="col-md-10"><h4>Skills of the employee</h4></div>
										<div class="col-md-1"></div>
									</div><!--- End row --->
									<div class="panel-body">
										<!--- loop over employee skills --->
										<cfloop query="VARIABLES.personalDetails" >
											<span class="btn">#VARIABLES.personalDetails.skillName#</span>
										</cfloop>
									</div><!--- End panel body --->
								</div><!--- End panel --->
							</div><!--- End column --->
						</div><!--- End row --->
						<hr>
						<div id = "goalHeading">Goals</div>
						<!--- Goals of today --->
						<table id ="goalOfTheDay">
							<cfloop query = "VARIABLES.goals">
								<tr>
								 	 <td>#VARIABLES.goals.goal#</td>
								 </tr>
							</cfloop>
						</table>
						<hr>
						<cfform>
							<div class = "form-group">
								<label >Add Your goals</label>
								<input type = "hidden" value = "#SESSION.setLoggedInUser.empId#" id="empId"/>
								<textarea rows="3" class = "form-control" name = "goal" id = "goal"></textarea>
								<input type = "button" id ="addGoal" value="Add Goal" class = "btn btn-sm btn-primary pull-right" name = "addGoal">
							</div>
						</cfform>

					</div><!--- end main --->
				</cfoutput>
				<!--- import the admin script --->
				<script type = "text/javascript" src = "../assets/javaScript/home.js"></script>
	</cf_headerFooter>
<!--- If employee notlogged in it will redirect to login page --->
<cfelse>
	<cflocation url="../index.cfm">
</cfif>
