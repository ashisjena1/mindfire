<cfparam name="loginErrorMessage" default=""/>

<cfif not structKeyExists(FORM,'loginUser')>
	<cfset loginErrorMessage=''/>
<cfelse>
	<cfset loginErrorMessage=APPLICATION.userService.loginUser()/>
	<cfif loginErrorMessage eq ''>
		 <cfset APPLICATION.userService.doLogin(FORM.email,FORM.password)/>
	</cfif>
</cfif>


<cfif structKeyExists(SESSION,'setLoggedInUser')>
	<cfif #SESSION.setLoggedInUser.empRole# eq "HR">
		<cflocation url="admin/index.cfm"/>
	<cfelse>
		<cflocation url="views/index.cfm"/>
	</cfif>
<cfelse>
<cf_headerFooter title="login page">
	<link rel="stylesheet" type="text/css" href="assets/css/login.css">
	<script type = "text/javascript" src = "assets/javaScript/login.js"></script>
	</head>
	<body>
	<cfoutput>
	   <div class="container">
	       <div class="card card-container">
	           <img id="profile-img" class="profile-img-card" src="assets/images/logo.jpg" />
	           <span class="text-danger">#loginErrorMessage#</span>
	           <cfform id="loginform" class="form-signin">
	               <cfinput type="email" name="email" id="loginEmail" class="form-control" placeholder="Email address"/>
						<div id="emailError" class="text-danger"></div>
	               <cfinput type="password" name="password" id="loginPassword" class="form-control" placeholder="Password" />
						<span id="passwordError" class="text-danger"></span>
	               <cfinput type="hidden" name="empId">
	               <input type="submit" class="btn btn-lg btn-primary btn-block btn-signin" value="Login" name="loginUser">
	            </cfform>
	            <a href="" class="forgot-password">
	                Forgot the password?
	            </a>
	        </div>
	    </div>
	  </cfoutput>

</cf_headerFooter>
</cfif>