<cfif structKeyExists(url,'logout')>
	<cfset Application.userService.doLogout()/>
	<cflocation url="../index.cfm">
</cfif>
<cfif structKeyExists(SESSION,'setLoggedInUser')>
	<cfset name="#SESSION.setLoggedInUser.firstName# #SESSION.setLoggedInUser.lastName#">
	<cf_headerFooter title="Home page">
		<link rel="stylesheet" type="text/css" href="../assets/css/home.css">
		</head>
		<body class>
			<cf_navbar name="#name#">	</cf_navbar>
				<div class="sidenav">
				  <a href="#">About</a>
				  <a href="#">Services</a>
				  <a href="#">Clients</a>
				  <a href="#">Contact</a>
				</div>
	</cf_headerFooter>
<cfelse>
	<cflocation url="../index.cfm">
</cfif>