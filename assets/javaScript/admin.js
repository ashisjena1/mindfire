$(document).ready(function() {
	if ( window.history.replaceState ) {
        window.history.replaceState( null, null, window.location.href );
    }
	$('#showEmployees').DataTable();
});
