<cfparam name="attributes.logged" default="login"/>
<cfparam name="attributes.source" default="assets/images/"/>
<cfif thisTag.executionMode eq 'start'>
	<nav class="navbar navbar-inverse">
	<div class="container-fluid">
	    <div class="navbar-header">
	      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	      </button>
	  <cfoutput>    <a class="navbar-brand" href=""><img id="logo" src="#attributes.source#logo.jpg" alt="Image not found"></a></cfoutput>
	    </div>
	    <div class="collapse navbar-collapse" id="myNavbar">

	      <ul class="nav navbar-nav navbar-right">
		     <cfif attributes.logged eq 'login'>
	        	<li><a href="views/login.cfm"><span class="glyphicon glyphicon-log-in"></span></span>  Login</a></li>
	         <cfelse>
	        		<li><a href="?logout"><span class="glyphicon glyphicon-log-out"></span></span> Log out</a></li>
			 </cfif>
	      </ul>
	    </div>
	  </div>
	</nav>
</cfif>
