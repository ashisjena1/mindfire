<cfparam name="loginErrorMessage" default="#structNew()#">
<cfif isDefined('loginErrorMessage') and (not structKeyExists(form,'loginUser'))>
	<cfset loginErrorMessage={email='',password=''}/>
<cfelse>
	<cfset loginErrorMessage=application.loginService.loginUser()/>
	<cfif loginErrorMessage.email eq '' and loginErrorMessage.password eq ''>
		 <cfset isUserLoggedIn = application.loginService.doLogin(form.email,form.password)/>
	</cfif>
</cfif>

<cf_headerFooter title="login page">
	<link rel="stylesheet" type="text/css" href="../assets/css/login.css">
	<script type = "text/javascript"
       	 src = "../assets/javaScript/login.js">
   	</script>
	</head>

	<body>
	<cfif structKeyExists(session,'stLoggedInUser')>
		<cflocation url="/views/home.cfm">
	<cfelse>

	<cfoutput>
	   <div class="container">
	       <div class="card card-container">
	           <!-- <img class="profile-img-card" src="//lh3.googleusercontent.com/-6V8xOA6M7BA/AAAAAAAAAAI/AAAAAAAAAAA/rzlHcD0KYwo/photo.jpg?sz=120" alt="" /> -->
	           <!-- <img id="profile-img" class="profile-img-card" src="//ssl.gstatic.com/accounts/ui/avatar_2x.png" /> -->
			   <!--<p id="profile-name" class="profile-name-card"></p> -->
	           <cfform id="loginform" class="form-signin">

	               <input type="email" name="email" id="loginEmail" class="form-control" placeholder="Email address">
						<span id="emailError" class="text-danger">#loginErrorMessage.email#</span>
	               <input type="password" name="password" id="loginPassword" class="form-control" placeholder="Password" >
						<span id="passwordError" class="text-danger">#loginErrorMessage.password#</span>
	               <div id="remember" class="checkbox">
	                   <label>
	                       <input type="checkbox" value="remember-me"> Remember me
	                    </label>
	               </div>
	               <input type="submit" class="btn btn-lg btn-primary btn-block btn-signin" value="Login" name="loginUser">
	            </cfform>
	            <a href="" class="forgot-password">
	                Forgot the password?
	            </a>
	        </div>
	    </div>
	  </cfoutput>
	  </cfif>
</cf_headerFooter>
