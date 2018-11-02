<!--- Checking for user Login --->
<cfif structKeyExists(SESSION,"setAdmin")>
	<!--- Checking for Logout --->
	<cfif structKeyExists(URL,"logout")>
		<cfset APPLICATION.adminService.doLogout()/>
		<cflocation url="adminLogin.cfm">
	</cfif>


		<cfset VARIABLES.name="#SESSION.setAdmin.firstName# #SESSION.setAdmin.lastName#">
		<!--- Fetch the project list from the project table --->
		<cfset VARIABLES.project=APPLICATION.adminService.getProjectDetails()/>
		<!--- Custom tags for header footer--->
		<cf_headerFooter title="Show Project">
				<!--- Import external style sheet --->
				<link rel="stylesheet" type="text/css" href="../../assets/css/admin.css">
				<link rel="stylesheet" type="text/css" href="../../assets/css/showProject.css">
			</head>
			<body>
				<!--- Custom tag for top nav bar --->
				<cf_navbar name="#VARIABLES.name#" source="../../assets/images/" homeSource="../"></cf_navbar>
				<!--- Side navbar --->
				<div class="sidenav">
					  <a href="addEmployee.cfm">Add Employee</a>
					  <a href="../">Employee Details</a>
					  <a href="addProject.cfm">Add Project</a>
					  <a href="">Project Details</a>
					  <a href="assignProject.cfm">Assign Project</a>
				</div><!--- end side navbar --->
				<!--- main content --->
				<div class="main">
					<h3 class="text-center">Project Details</h3>
					<!--- Data Tables for the project Data --->
					<div  class="card-container card">
				        <cfoutput>
					        <div class = "row">
								<h4>
						      	<div class = "col-md-2">Project Name</div>
						      	<div class = "col-md-3">Manager</div>
						      	<div class = "col-md-3">Duration</div>
							    <div class = "col-md-4"></div>
								</h4>
						     </div>
						     <hr>
						     <!--- Loop over the project Details --->
					        <cfloop query="VARIABLES.project" group = "projectName">
					       		 <div class = "row">
									<h4>
						      			<div class = "col-md-2">#VARIABLES.project.projectName#</div>
						      			<div class = "col-md-3">#VARIABLES.project.manager#</div>
						      			<div class = "col-md-3">#DateFormat(VARIABLES.project.startDate,"dd/mm/yyyy")# -#DateFormat(VARIABLES.project.endDate,"dd//mm/yyyy")#</div>
							    		<div class = "col-md-4"></div>
									</h4>
						    	 </div>
									<!--- Inner Loop --->
						        	<cfloop>
							        	<div class = "row">
							        	<div class = "col-md-3">#VARIABLES.project.name#<br></div>
							        	<div class = "col-md-3">#DateFormat(VARIABLES.project.projectJoinDate,"mmm dd,yyyy")# -
							        	#DateFormat(VARIABLES.project.projectFinishDate,"mmm dd,yyyy")#<br></div>
							        	<div class = "col-md-3">#VARIABLES.project.status#<br></div>
							        	<div class = "col-md-3"></div>
							        	</div>
							        </cfloop>
						     	</cfloop>
							</cfoutput>
					</div><!--- end table --->
				</div><!--- end main --->
			<!--- import the admin script --->
			<script type = "text/javascript" src = "../../assets/javaScript/admin.js"></script>
		</cf_headerFooter>
<!--- If employee notlogged in it will redirect to login page --->
<cfelse>
	<cflocation url="adminLogin.cfm">
</cfif>