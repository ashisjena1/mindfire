<cfparam name="attributes.title" default="Assigment page"/>
<cfif thisTag.executionMode eq 'start'>
	<!DOCTYPE html>
	<html lang="en">
		<head>
			<title><cfoutput>#attributes.title#</cfoutput></title>
			<meta charset="UTF-8">
			<meta name="viewport" content="width=device-width, initial-scale=1">

			<!--- Latest compiled and minified CSS --->
			<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

			<!--- jQuery library --->
			<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

			<!--- Latest compiled JavaScript --->
			<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

			<!--- Jquery CDN --->
			<script src = "https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>

			<!--- css file for data tables--->
			<link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css">

			<!---  Jquery for data tables --->
			<script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>


<cfelse>
		</body>
	</html>
</cfif>
