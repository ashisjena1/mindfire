<cfparam name="attributes.name" default=""/>
<cfparam name="attributes.source" default="assets/images/"/>
<cfparam name="attributes.profileSource" default=""/>
<cfparam name="attributes.homeSource" default=""/>
<cfif thisTag.executionMode eq 'start'>
	<nav class="navbar navbar-inverse navbar-fixed-top">
	<div class="container-fluid">
	    <div class="navbar-header">
	      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	      </button>
		  <cfoutput>
			  <a class="navbar-brand" href="#attributes.homeSource#"><img id="logo" src="#attributes.source#logo.jpg" alt="Image not found"></a>
		  </cfoutput>
 	    </div>
	    <div class="collapse navbar-collapse" id="myNavbar">
	      <ul class="nav navbar-nav navbar-right">
		      <cfoutput><li><a href="#attributes.homeSource#">Home</a></li></cfoutput>
		      <cfoutput><li><a href="#attributes.profileSource#">#attributes.name#</a></li></cfoutput>
        	  <li><a href="?logout"><span class="glyphicon glyphicon-log-out"></span></span> Log out</a></li>
	      </ul>
	    </div>
	  </div>
	</nav>
</cfif>
