<cfparam name="errorMessage" default="#structNew()#">
<cfif isDefined('errorMessage') and (not structKeyExists(form,'registerUser'))>
	<cfset errorMessage={firstName='',lastName='',email='',phoneNumber='',password='',cPassword=''}/>
<cfelse>
		<cfset errorMessage=application.loginService.registerUser()/>
</cfif>
<cf_headerFooter title="Registration Page">
	<link rel="stylesheet" type="text/css" href="assets/css/registration.css">
	<script type = "text/javascript"
       	 src = "assets/javaScript/registration.js">
   	</script>
	</head>
	<body>
	<cf_navbar>	</cf_navbar>
		<div class="container register">
			<div class="row">
				<div class="col-md-3 register-left">
					<img src="https://image.ibb.co/n7oTvU/logo_white.png" alt=""/>
					<h3>Welcome</h3>
				</div>
				<cfoutput>
				<cfif isDefined('errorMessage')>
				<div class="col-md-9 register-right">
					<h3 class="register-heading">Create your Account</h3>
					<form id="registrationform" class="row register-form" action="" method="post">
						<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<input type="text" class="form-control" id="firstName" name="firstName" placeholder="First Name *" value="" />
								<span id="fNameError" class="text-danger">#errorMessage.firstName#</span>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<input type="text" class="form-control" id="lastName" name="LastName" placeholder="Last Name *" value="" />
								<span id="lNameError" class="text-danger">#errorMessage.lastName#</span>
							</div>
						</div>
						</div>
							<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<input type="email" class="form-control" id="email" name="email" placeholder="Your Email *" value="" />
								<span id="emailError" class="text-danger">#errorMessage.email#</span>
							</div>
						</div>
						<div class="col-md-6">
						<div class="form-group">
								<input type="text" id="phoneNumber" name="phoneNumber" class="form-control" placeholder="Your Phone *" value="" />
								<span id="phoneNumberError" class="text-danger">#errorMessage.phoneNumber#</span>
							</div>
						</div>
						</div>
						<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<input type="password" class="form-control" id="password" name="password" placeholder="Password *" value="" />
								<span id="passwordError" class="text-danger">#errorMessage.password#</span>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<input type="password" class="form-control"  id="cPassword" name="cPassword" placeholder="Confirm Password *" value="" />
								<span id="cPasswordError" class="text-danger">#errorMessage.cPassword#</span>
							</div>
						</div>
						</div>
						<div class="row">
						<div class="form-group">
							<label id="gender">Gender
									<label class="radio-inline">
										<input type="radio" name="gender" value='m' checked>
										<span> Male </span>
									</label>
									<label class="radio-inline">
										<input type="radio" name="gender" value='f'>
										<span>Female </span>
									</label>
									<label class="radio-inline">
										<input type="radio" name="gender" value='o'>
										<span>Other </span>
									</label>
							</label>
						</div>
						</div>
						<input type="submit" class="btnRegister"  id="submitButton" name="registerUser" value="Register"/>
					</form>
				</div>
				</cfif>
				</cfoutput>
			</div>
		</div>
</cf_headerFooter>