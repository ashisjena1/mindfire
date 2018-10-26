<cfparam name="attributes.name" default=""/>
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
		  <a class="navbar-brand" href=""><cfoutput><img id="logo" src="#attributes.source#logo.jpg" alt="Image not found"></cfoutput></a>
				<form class="navbar-form navbar-left searchBar" role="search">

		    		<div class="form-group">

			    		<select id="" class="form-control">
							<option>--select--</option>
				  			<option>Employee ID</option>
				  			<option>Name</option>
				  			<option>Department</option>
				  		</select>
		        		<input type="text" class="form-control" placeholder="Search">
		        		<button type="submit" class="btn btn-default">
	     				   <span class="glyphicon glyphicon-search"></span>
	  				  	</button>
		    		</div>

				</form>
 	    </div>
	    <div class="collapse navbar-collapse" id="myNavbar">
	      <ul class="nav navbar-nav navbar-right">
		      <li><a href=""><cfoutput>#attributes.name#</cfoutput></a></li>
        	  <li><a href="?logout"><span class="glyphicon glyphicon-log-out"></span></span> Log out</a></li>
	      </ul>
	    </div>
	  </div>
	</nav>
</cfif>
