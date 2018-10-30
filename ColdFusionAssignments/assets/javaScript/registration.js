$(document).ready(function(){
	var fNameError=$("#fNameError");
	var lNameError=$("#lNameError");
	var passwordError=$("#passwordError");
	var cPasswordError=$("#cPasswordError");
	var emailError=$("#emailError");
	var phoneNumberError=$("#phoneNumberError");
	var registrationform=$("#registrationform");
	
	fNameError.hide();
	lNameError.hide();
	passwordError.hide();
	cPasswordError.hide();
	emailError.hide();
	phoneNumberError.hide();

	var errorFirstName;
	var errorLastName;
	var errorEmail;
	var errorPhoneNumber;
	var errorPassword;
	var errorConfirmPassword;
	
	var fName=$("#firstName");
	var lName=$("#lastName");
	var pass =$("#password");
	var cPassword=$("#cPassword");
	var email=$("#email");
	var phoneNumber=$("#phoneNumber");

	fName.focusout(function(){
		errorFirstName=false;
		checkFirstName();
	});
	lName.focusout(function(){
		errorLastName=false;
		checkLastName();
	});
	email.focusout(function(){
		errorEmail=false;
		checkEmail();
	});
	phoneNumber.focusout(function(){
		errorPhoneNumber=false;
		checkPhoneNumber();
	});
	pass.focusout(function(){
		errorPassword=false;
		checkPassword();
	});
	cPassword.focusout(function(){
		errorConfirmPassword=false;
		checkConfirmPassword();
	});
	
	function error(errorId,errorMessage){
		errorId.html(errorMessage);
		errorId.show();
	}
	function checkNameError(name,nameError,value){
		
		if(name == ''){
			error(nameError,value+' should not be empty');
		}else if(name.match(/[A-Za-z]+/)!=name){
			error(nameError,value+' should contain only alphabets');
		} else {
			nameError.hide();
			return true;
		}
		return false;
	}
	
	function checkFirstName(){
		firstName=$.trim(fName.val());
		if(checkNameError(firstName,fNameError,"First name")){
			errorFirstName=true;
		}
	}
	function checkLastName(){
		lastName=$.trim(lName.val());
		if(checkNameError(lastName,lNameError,"Last name")){
			errorLastName=true;	
		}
	}
	
	function checkEmail(){
		if (email.val().length === 0) {
			error(emailError,"Email address should not be empty");
		} else if (!(/^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$/).test(email.val().trim())){
			error(emailError,"Please enter a valid email address (Ex:abc@cd.com)");
		} else {
			emailError.hide();
			errorEmail=true;
		}
	}
	function checkPhoneNumber(){
		var pNumber=$.trim(phoneNumber.val());
		if (pNumber == '') {
				error(phoneNumberError,"Phone Number should not be empty");
				//phoneNumberError.show();
		}  else if (pNumber.match(/[1-9][0-9]{9}/)!=pNumber){
			error(phoneNumberError,"Phone number must be 10 numbers (Ex:98XXXXXX66)");
			//phoneNumberError.show();
		} else {
			phoneNumberError.hide();
			errorPhoneNumber=true;
		}
	}
	function checkPassword(){
		if (pass.val().length === 0) {
			error(passwordError,"Password should not be empty");
		} else if (!(/(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}/).test(pass.val())){
			error(passwordError,"Password must contain at least 8 characters, including UPPER/lowercase and numbers");
		} else {
			passwordError.hide();
			errorPassword=true;
		}
	}
	function checkConfirmPassword(){
		if (cPassword.val().length === 0) {
			error(cPasswordError,"Confirm Password should not be empty");
		} else if ((/(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}/).test(cPassword.val())){
			if (pass.val()!==cPassword.val()){
				error(cPasswordError,"Confirm Password should match with the password");
			}else{
				cPasswordError.hide();
				errorConfirmPassword=true;
			}
		}else{
			error(cPasswordError,"Confirm Password must contain at least 8 characters, including UPPER/lowercase and numbers");
		}		
	} 
	
	registrationform.submit(function(){
		errorFirstName=false;
		errorLastName=false;
		errorPassword=false;
		errorConfirmPassword=false;
		errorEmail=false;
		errorPhoneNumber=false;
		
		
		checkFirstName();
		checkLastName();
		checkPassword();
		checkConfirmPassword();
		checkEmail();
		checkPhoneNumber();
		
		if(errorFirstName && errorLastName && errorPassword && errorConfirmPassword && errorEmail && errorPhoneNumber){
			// window.location.replace($(location).attr('href')+'views/login.cfm');
			return true;
		}
		return false;
		
	});
});