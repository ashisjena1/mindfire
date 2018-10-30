$(document).ready(function() {
	var passwordError=$("#passwordError");
	var emailError=$("#emailError");
		
	passwordError.hide();
	emailError.hide();
	
	var errorEmail=false;
	var errorPassword=false;
	
	var loginEmail=$("#loginEmail");
	var loginPassword=$("#loginPassword");
	var loginform=$("#loginform");
	
	function checkEmail(){
		if (loginEmail.val().length === 0) {
			emailError.html("Email should not be empty");
			emailError.show();
		} else if (!(/^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$/).test(loginEmail.val().trim())){
			emailError.html("please enter a valid email id");
			emailError.show();
		} else {
			emailError.hide();
			errorEmail=true;
		}
	}
	
	function checkPassword(){
		if (loginPassword.val().length === 0) {
			passwordError.html("password should not be empty");
			passwordError.show();
		} else if (!(/(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}/).test(loginPassword.val())){
			passwordError.html("Enter the correct password");
			passwordError.show();
		} else {
			passwordError.hide();
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
