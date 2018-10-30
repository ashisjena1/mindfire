<cfif structKeyExists(url,'logout')>
	<cfset application.loginService.doLogout()/>
	<cflocation url="../index.cfm">
</cfif>
<cfif structKeyExists(session,'stLoggedInUser')>
	<cf_headerFooter title="Home page">
		<link rel="stylesheet" type="text/css" href="../assets/css/home.css">
		</head>
		<body>
			<cf_navbar logged="logout" source="../assets/images/">	</cf_navbar>
	</cf_headerFooter>
<cfelse>
	<cflocation url="login.cfm">
</cfif>