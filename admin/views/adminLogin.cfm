<!--- Instantiate loginErrorMessage --->
<cfparam name="VARIABLES.loginErrorMessage" default=""/>
<!--- Checking for submit button click --->
<cfif not structKeyExists(FORM,"loginUser")>
	<cfset VARIABLES.loginErrorMessage=""/>
<cfelse>
	<!--- Checking user input data for server side validation --->
	<cfset VARIABLES.loginErrorMessage=APPLICATION.adminService.checkAdminLogin()/>
	<cfif VARIABLES.loginErrorMessage EQ "">
		 <!--- If no error then Login the employee --->
		 <cfset APPLICATION.adminService.doLogin(FORM.email,FORM.password)/>
	</cfif>
</cfif>
<!--- Checking for user Login--->
<cfif structKeyExists(SESSION,"setAdmin")>
		<cflocation url="../index.cfm"/>
<cfelse>
	<!--- custom tag for header footer--->
	<cf_headerFooter title="admin login page">
		<!--- import External stylesheet --->
		<link rel="stylesheet" type="text/css" href="../../assets/css/login.css">
	</head>
	<body>
	<cfoutput>
	   <div class="container">
	       <div class="card card-container">
	           <img id="profile-img" class="profile-img-card" src="../../assets/images/logo.jpg" />
	           <span class="text-danger">#VARIABLES.loginErrorMessage#</span>
	           <cfform id="loginform" class="form-signin">
	               <cfinput type="email" name="email" id="loginEmail" class="form-control" placeholder="Email address"/>
						<div id="emailError" class="text-danger"></div>
	               <cfinput type="password" name="password" id="loginPassword" class="form-control" placeholder="Password" />
						<span id="passwordError" class="text-danger"></span>
	               <cfinput type="hidden" name="empId">
	               <input type="submit" class="btn btn-lg btn-primary btn-block btn-signin" value="Login" name="loginUser">
	            </cfform>
	          <!---  <a href="" class="forgot-password">
	                Forgot the password?
	            </a>--->
	        </div><!--- End card--->
	    </div><!--- End container--->
	</cfoutput>
	<!--- import External javascript --->
	<script type = "text/javascript" src = "../../assets/javaScript/login.js"></script>
	</cf_headerFooter><!--- End header footer --->
</cfif>