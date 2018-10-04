$(document).ready(function(){
	
	var personalError=$("#personalError");
	var contactError=$("#contactError");
	var passwordError=$("#passwordError");
	var cAddressError=$("#cAddressError");
	var pAddressError=$("#pAddressError");
	var submitError=$("#submitError");
	var pInterestsError=$("#pInterestsError");
	
	personalError.hide();
	contactError.hide();
	passwordError.hide();
	cAddressError.hide();
	pAddressError.hide();
	submitError.hide();
	pInterestsError.hide();
	
	var errorFirstName;
	var errorLastName;
	var errorMiddleName;
	var errorDOB;
	var errorGender;
	var errorEmail;
	var errorPhoneNumber;
	var errorPassword;
	var errorConfirmPassword;
	var errorCurrentAddress;
	var errorCurrentCountry;
	var errorCurrentState;
	var errorCurrentCity;
	var errorCurrentZipCode;
	var errorPresentAddress;
	var errorPresentCountry;
	var errorPresentState;
	var errorPresentCity;
	var errorPresentZipCode;
	var errorCaptcha;
	var errorPolicy;
	var errorPersonalInterests;
	
	var fName=$("#fName");
	var mName=$("#mName");
	var lName=$("#lName");
	var dob=$("#dob");
	var gender=$("input[name='gender']");
	var email=$("#email");
	var phoneNumber=$("#phoneNumber");
	var pass =$("#pass");
	var cPassword=$("#cPassword");
	var pAddress=$("#pAddress");
	var pCountry=$("#pCountry");
	var pState=$("#pState");
	var pCity=$("#pCity");
	var pZipCode=$("#pZipCode");
	var cAddress=$("#cAddress");
	var cCountry=$("#cCountry");
	var cState=$("#cState");
	var cCity=$("#cCity");
	var cZipCode=$("#cZipCode");
	var personalInterests=$("input[name='personalInterests']");
	var result=$("#result");
	var policy=$("#policy");
	var registrationForm=$("#registrationForm");
	var otherInterests=$("#otherInterests");
	var oInterests=$("#oInterests");
	
	oInterests.hide();
	
	
	fName.focusout(function(){
		errorFirstName=false;
		checkFirstName();
	});
	mName.focusout(function(){
		errorMiddleName=false;
		checkMiddleName();
	});
	lName.focusout(function(){
		errorLastName=false;
		checkLastName();
	});
	dob.focusout(function(){
		errorDOB=false;
		checkDOB();
	});
	gender.focusout(function(){
		errorGender=false;
		checkGender();
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
	cAddress.focusout(function(){
		errorCurrentAddress=false;
		checkCurrentAddress();
	});
	cCountry.focusout(function(){
		errorCurrentCountry=false;
		checkCurrentCountry();
	});
	
	cState.focusout(function(){
		errorCurrentState=false;
		checkCurrentState();
	});
	cCity.focusout(function(){
		errorCurrentCity=false;
		checkCurrentCity();
	});
	cZipCode.focusout(function(){
		errorCurrentZipCode=false;
		checkCurrentZipCode();
	});
	pAddress.focusout(function(){
		errorPresentAddress=false;
		checkPresentAddress();
	});
	pCountry.focusout(function(){
		errorPresentCountry=false;
		checkPresentCountry();
	});
	pState.focusout(function(){
		errorPresentState=false;
		checkPresentState();
	});
	pCity.focusout(function(){
		errorPresentCity=false;
		checkPresentCity();
	});
	pZipCode.focusout(function(){
		errorPresentZipCode=false;
		checkPresentZipCode();
	});
	result.focusout(function(){
		errorCaptcha=false;
		checkCaptcha();
	});
	policy.focusout(function(){
		errorPolicy=false;
		checkPolicy();
	});
	personalInterests.focus(function(){
		pInterestsError.hide();
	});
	otherInterests.focusout(function(){
		errorPersonalInterests=false;
		checkPersonalInterests();
	});
	otherInterests.click(function(){
		if(otherInterests.prop("checked")){
			oInterests.show();
		}else{
			oInterests.hide();
		}
	});

	function emptyError(message,displayError,elementField){
		displayError.html(message+" should not be empty");
		elementField.setCustomValidity(message+" should not be empty");
		displayError.show();
	}
	function error(message,displayError,elementField){
		displayError.html(message);
		elementField.setCustomValidity(message);
		displayError.show();
	}
	function noError(displayError,elementField){
		displayError.hide();
		elementField.setCustomValidity("");
	}
	function checkFirstName(){
		if(fName.val().length===0){
			emptyError("First Name",personalError,fName[0]);
		}else if(fName.val().match(/[A-Za-z]+/)!=fName.val()){
			error("First Name should contain only alphabets",personalError,fName[0]);
		} else {
			noError(personalError,fName[0]);
			errorFirstName=true;
		}
	}
	function checkMiddleName(){
		if(mName.val().match(/[A-Za-z]*/)!=mName.val()){
			error("Middle Name should contain only alphabets",personalError,mName[0]);
		} else {
			noError(personalError,mName[0]);
			errorMiddleName=true;
		}
	}
	function checkLastName(){
		if(lName.val().length===0){
			emptyError("Last Name",personalError,lName[0]);
		}else if(lName.val().match(/[A-Za-z]+/)!=lName.val()){
			error("Last Name should contain only alphabets",personalError,lName[0]);
		} else {
			noError(personalError,lName[0]);
			errorLastName=true;
		}
	}
	function checkDOB(){
		if(dob.val().length===0){
			emptyError("Date of Birth",personalError,dob[0]);
		}else if(dob.val()){
			var date=new Date(dob.val());
			var today=new Date();
			if(date >= today){
				error("Date of Birth should not be greater than today's date",personalError,dob[0]);
			} else {
				noError(personalError,dob[0]);
				errorDOB=true;
			}
		}
	}
	function checkGender(){
		if(!(gender[0].checked || gender[1].checked || gender[2].checked)){
			personalError.html("Please select your gender");
			personalError.show();
		}else{
			personalError.html("");
			personalError.hide();
			errorGender=true;
		}
	}
	function checkEmail(){
		if (email.val().length === 0) {
			emptyError('Email',contactError,email[0]);
		} else if (!(/^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$/).test(email.val())){
			error('please enter a valid email address',contactError,email[0]);
		} else {
			noError(contactError,email[0]);
			errorEmail=true;
		}
	}
	function checkPhoneNumber(){
		if (phoneNumber.val().length === 0) {
				emptyError('Phone number',contactError,phoneNumber[0]);
		}  else if (phoneNumber.val().match(/[1-9][0-9]{9}/)!=phoneNumber.val()){
			error('phone number must contain 10 digits',contactError,phoneNumber[0]);
		} else {
			noError(contactError,phoneNumber[0]);
			errorPhoneNumber=true;
		}
	}
	function checkPassword(){
		if (pass.val().length === 0) {
			emptyError('Password',passwordError,pass[0]);
		} else if (!(/(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}/).test(pass.val())){
			error('Password must contain at least 8 characters, including UPPER/lowercase and numbers',passwordError,pass[0]);
		} else {
			noError(passwordError,pass[0]);
			errorPassword=true;
		}
	}
	function checkConfirmPassword(){
		if (cPassword.val().length === 0) {
			emptyError('Confirm password',passwordError,cPassword[0]);
		} else if ((/(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}/).test(cPassword.val())){
			if (pass.val()!==cPassword.val()){
				error('Confirm password should be match with the above password',passwordError,cPassword[0]);
			}else{
				noError(passwordError,cPassword[0]);
				errorConfirmPassword=true;
			}
		}else{
			error('confirm password must contain at least 8 characters, including UPPER/lowercase and numbers',passwordError,cPassword[0]);
		}	
	} 
	
	function checkCurrentAddress(){
		if (cAddress.val().length === 0) {
			emptyError('Address field',cAddressError,cAddress[0]);
		} else if (!(/.{15,50}/).test(cAddress.val())){
			error('Address should be more than 15 characters and less than 50 character',cAddressError,cAddress[0]);
		} else {
			noError(cAddressError,cAddress[0]);
			errorCurrentAddress=true;
		}
	}
	function checkCurrentCity(){
		if (cCity.val().length === 0) {
			emptyError('City',cAddressError,cCity[0]);
		} else if (cCity.val().match(/[A-Za-z]+/)!=cCity.val()){
			error('please enter a valid city name',cAddressError,cCity[0]);
		} else {
			noError(cAddressError,cCity[0]);
			errorCurrentCity=true;
		}
	}
	function checkCurrentState(){
		if (cState.val().length === 0) {
			emptyError('State',cAddressError,cState[0]);
		} else if (cState.val().match(/[A-Za-z]+/)!=cState.val()){
			error('please enter a valid state name',cAddressError,cState[0]);
		} else {
			noError(cAddressError,cState[0]);
			errorCurrentState=true;
		}	
	}
	function checkCurrentCountry(){
		if (cCountry.val().length === 0) {
			emptyError('Country',cAddressError,cCountry[0]);
		} else if (cCountry.val().match(/[A-Za-z]+/)!=cCountry.val()){
			error('please enter a valid country name',cAddressError,cCountry[0]);
		} else {
			noError(cAddressError,cCountry[0]);
			errorCurrentCountry=true;
		}
	}
	function checkCurrentZipCode(){
		if (cZipCode.val().length === 0) {
			emptyError('Zip Code',cAddressError,cZipCode[0]);
		} else if (cZipCode.val().match(/[0-9]{6}/)!=cZipCode.val()){
			error('Zip code must be 6 digits',cAddressError,cZipCode[0]);
		} else {
			noError(cAddressError,cZipCode[0]);
			errorCurrentZipCode=true;
		}
	}
	
	function checkPresentAddress(){
		if (pAddress.val().length === 0) {
			emptyError('Address field',pAddressError,pAddress[0]);
		} else if (!(/.{15,50}/).test(pAddress.val())){
			error('Address should be more than 15 characters and less than 50 character',pAddressError,pAddress[0]);
		} else {
			noError(pAddressError,pAddress[0]);
			errorPresentAddress=true;
		}
	}
	function checkPresentCity(){
		if (pCity.val().length === 0) {
			emptyError('City',pAddressError,pCity[0]);
		} else if (pCity.val().match(/[A-Za-z]+/)!=pCity.val()){
			error('please enter a valid city name',pAddressError,pCity[0]);
		} else {
			noError(pAddressError,pCity[0]);
			errorPresentCity=true;
		}
	}
	function checkPresentState(){
		if (pState.val().length === 0) {
			emptyError('State',pAddressError,pState[0]);
		} else if (pState.val().match(/[A-Za-z]+/)!=pState.val()){
			error('please enter a valid state name',pAddressError,pState[0]);
		} else {
			noError(pAddressError,pState[0]);
			errorPresentState=true;
		}	
	}
	function checkPresentCountry(){
		if (pCountry.val().length === 0) {
			emptyError('Country',pAddressError,pCountry[0]);
		} else if (pCountry.val().match(/[A-Za-z]+/)!=pCountry.val()){
			error('please enter a valid country name',pAddressError,pCountry[0]);
		} else {
			noError(pAddressError,pCountry[0]);
			errorPresentCountry=true;
		}
	}
	function checkPresentZipCode(){
		if (pZipCode.val().length === 0) {
			emptyError('Zip Code',pAddressError,pZipCode[0]);
		} else if (pZipCode.val().match(/[0-9]{6}/)!=pZipCode.val()){
			error('Zip code must be 6 digits',pAddressError,pZipCode[0]);
		} else {
			noError(pAddressError,pZipCode[0]);
			errorPresentZipCode=true;
		}
	}
	
	function checkPersonalInterests(){
		if(personalInterests[0].checked || personalInterests[1].checked || personalInterests[2].checked || personalInterests[3].checked || personalInterests[4].checked ||
			personalInterests[5].checked || personalInterests[6].checked || personalInterests[7].checked){
				noError(pInterestsError,personalInterests[7]);
				errorPersonalInterests=true;
		}else{
			error('please select any of your personal interests or others ',pInterestsError,personalInterests[7]);
		}
	}	
	function checkCaptcha(){
		if(result.val().length===0){
			emptyError("Captcha value",submitError,result[0]);
		}else if(captchaResult!=$("#result").val()){
			error("Try once more...",submitError,result[0]);
		} else {
			noError(submitError,result[0]);
			errorCaptcha=true;
		}
	}
	function checkPolicy(){
		if(!policy.prop('checked')){
			error("Accept the terms and conditions",submitError,policy[0]);
		} else {
			noError(submitError,policy[0]);
			errorPolicy=true;
		}
	}
	
	registrationForm.submit(function(){
		errorFirstName=false;
		errorLastName=false;
		errorMiddleName=false;
		errorDOB=false;
		errorGender=false;
		errorEmail=false;
		errorPhoneNumber=false;
		errorPassword=false;
		errorConfirmPassword=false;
		errorCurrentAddress=false;
		errorCurrentCountry=false;
		errorCurrentState=false;
		errorCurrentCity=false;
		errorCurrentZipCode=false;
		errorPresentAddress=false;
		errorPresentCountry=false;
		errorPresentState=false;
		errorPresentCity=false;
		errorPresentZipCode=false;
		errorCaptcha=false;
		errorPolicy=false;
		errorPersonalInterests=false;
		
		checkFirstName();
		checkMiddleName();
		checkLastName();
		checkDOB();
		checkGender();
		checkEmail();
		checkPhoneNumber();
		checkPassword();
		checkConfirmPassword();
		checkCurrentAddress();
		checkCurrentCountry();
		checkCurrentState();
		checkCurrentCity();
		checkCurrentZipCode();
		checkPresentAddress();
		checkPresentCountry();
		checkPresentState();
		checkPresentCity();
		checkPresentZipCode();
		checkCaptcha();
		checkPolicy();
		checkPersonalInterests();
		if(errorPersonalInterests && errorCaptcha && errorPolicy){
				registrationForm.html("<p style='color:green'>Congratulations,You registered successfully...</p>");
		}
		/*else{
			var form=registrationForm.html();
			registrationForm.html("<p style='color:red;text-align:center'>Something went wrong...<br>Please try once again...</p>");
			setTimeout(registrationForm.html(form),300);
		}*/
		
		return false;
	});	
});

	

function captcha(){
	var first,second,operatorArray = ['+','-','*','/'];
	var operator = operatorArray[Math.floor(Math.random()*operatorArray.length)];
	captchaResult=0;
	if(operator=='+'){
		first    = Math.round(Math.random()*(20-1)+1);
		second   = Math.round(Math.random()*(20-1)+1);
		captchaResult=first+second;
		
	}else if(operator=='-'){
		first    = Math.round(Math.random()*(20-1)+1);
		second   = Math.round(Math.random()*(20-1)+1);
		if(first<second){
			first=first+second;
			second=first-second;
			first=first-second;
		}
		captchaResult=first-second;
	}
	else if(operator=='*'){
		var first    = Math.round(Math.random()*(10-1)+1);
		var second   = Math.round(Math.random()*(10-1)+1);
		captchaResult=first*second;
		
	}else{
		var second   		=  Math.round(Math.random()*(20-1)+1);
		var numberArray     =	[second*1,second*2,second*3,second*4,second*5,second*6,second*7,second*8,second*9,second*10,second*11,second*12];
		var first   		=  numberArray[Math.floor(Math.random()*numberArray.length)];
		
		captchaResult=first/second;
	}
		$("#firstNumber").html(first);
		$("#secondNumber").html(second);
		$("#operator").html(operator);
}