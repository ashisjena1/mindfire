$(document).ready(function() {
	var passwordError=$("#passwordError");
	var emailError=$("#emailError");
			
	var errorEmail=false;
	var errorPassword=false;
	
	var loginEmail=$("#loginEmail");
	var loginPassword=$("#loginPassword");
	var loginform=$("#loginform");
	
	function checkEmail(){
		if (loginEmail.val().length === 0) {
			emailError.html("Email should not be empty");
			
		} else if (!(/^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$/).test(loginEmail.val().trim())){
			emailError.html("please enter a valid email id");
		} else {
			emailError.html('');
			errorEmail=true;
		}
	}
	
	function checkPassword(){
		if (loginPassword.val().length === 0) {
			passwordError.html("password should not be empty");
			
		} else if (!(/(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}/).test(loginPassword.val())){
			passwordError.html("Enter the correct password");
		
		} else {
			passwordError.html('');
			errorPassword=true;
		}
		return false;
	}
	
	loginform.submit(function(){
		errorEmail=false;
		errorPassword=false;
		
		checkEmail();
		checkPassword();
	
		if( errorEmail && errorPassword ){
			return true;
		}
		return false;
		
	});
});
