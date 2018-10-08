$(document).ready(function(){
	var personalError=$("#personalError");
	var contactError=$("#contactError");
	var passwordError=$("#passwordError");
	var cAddressError=$("#cAddressError");
	var pAddressError=$("#pAddressError");
	var submitError=$("#submitError");
	var pInterestsError=$("#pInterestsError");
	var next1=$("#next1");
	var form1=$("#form1");
	var next2=$("#next2");
	var form2=$("#form2");
	var next3=$("#next3");
	var form3=$("#form3");
	var next4=$("#next4");
	var form4=$("#form4");
	var form5=$("#form5");
	
	form2.hide();
	form3.hide();
	form4.hide();
	form5.hide();
	
	personalError.css("visibility","hidden");
	contactError.css("visibility","hidden");
	passwordError.css("visibility","hidden");
	cAddressError.css("visibility","hidden");
	pAddressError.css("visibility","hidden");
	submitError.css("visibility","hidden");
	pInterestsError.css("visibility","hidden");
	
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
	var refresh=$("#refresh");
	
	oInterests.hide();
	
	var countryOptions;
	var stateOptions;
	var cityOptions;
	var country;
	var state;
	var city;
	
	
	$.getJSON('js/CountryStateCity.json',function(result){
		country=result.Countries;
		countryOptions+="<option value='select'>--select--</option>";
		$.each(country,function(key,value){
			countryOptions+="<option value='"+value.CountryName+"'>"+value.CountryName+"</option>";
		});
		$("#cCountry").html(countryOptions);
		$("#pCountry").html(countryOptions);
	});

	$("#cCountry").change(function(){
		stateOptions='';
		$.each(country,function(key,value){
			if(value.CountryName==$("#cCountry").val()){
				state=value.States;
				stateOptions+="<option value='select'>--select--</option>";
				$.each(state,function(key,value){
					stateOptions+="<option value='"+value.StateName+"'>"+value.StateName+"</option>";
				});
			}
		});
		$("#cState").html(stateOptions);
	});
	
	$("#cState").change(function(){
		cityOptions='';
		$.each(state,function(key,value){
			if(value.StateName==$("#cState").val()){
				city=value.Cities;
				if(city.length!=0){
					cityOptions+="<option value='select'>--select--</option>";
				}
				$.each(city,function(key,value){
					cityOptions+="<option value='"+value+"'>"+value+"</option>";
				});
				
			}
			
		});
		$("#cCity").html(cityOptions);
	});
	$("#pCountry").change(function(){
		stateOptions='';
		$.each(country,function(key,value){
			if(value.CountryName==$("#pCountry").val()){
				state=value.States;
				stateOptions+="<option value='select'>--select--</option>";
				$.each(state,function(key,value){
					stateOptions+="<option value='"+value.StateName+"'>"+value.StateName+"</option>";
				});
			}
		});
		$("#pState").html(stateOptions);
	});
	
	$("#pState").change(function(){
		cityOptions='';
		$.each(state,function(key,value){
			if(value.StateName==$("#cState").val()){
				city=value.Cities;
				if(city.length!=0){
					cityOptions+="<option value='select'>--select--</option>";
				}
				$.each(city,function(key,value){
					cityOptions+="<option value='"+value+"'>"+value+"</option>";
				});
				
			}
			
		});
		$("#pCity").html(cityOptions);
	});
	
	captcha();
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
	next1.click(function(){
		errorFirstName=false;
		errorLastName=false;
		errorMiddleName=false;
		errorDOB=false;
		errorGender=false;
		if(checkFirstName())
		if(checkMiddleName())
		if(checkLastName())
		if(checkDOB())
		if(checkGender()){
			if(errorFirstName && errorLastName && errorMiddleName && errorDOB && errorGender){
				form1.hide();
				form2.show();
			}else{
				personalError.html("Fill all the details correctly...")
			}
		}
	});
	email.focusout(function(){
		errorEmail=false;
		checkEmail();
	});
	phoneNumber.focusout(function(){
		errorPhoneNumber=false;
		checkPhoneNumber();
	});
	next2.click(function(){
		errorEmail=false;
		errorPhoneNumber=false;
		
		if(checkEmail())
		if(checkPhoneNumber()){
			if(errorEmail && errorPhoneNumber){
				form2.hide();
				form3.show();
			}else{
				contactError.html("Fill all the details correctly...")
			}
		}
	});
	pass.focusout(function(){
		errorPassword=false;
		checkPassword();
	});
	cPassword.focusout(function(){
		errorConfirmPassword=false;
		checkConfirmPassword();
	});
	next3.click(function(){
		errorPassword=false;
		errorConfirmPassword=false;
		
		if(checkPassword())
		if(checkConfirmPassword()){
			if(errorPassword && errorConfirmPassword){
				form3.hide();
				form4.show();
			}else{
				passwordError.html("Fill all the details correctly...")
			}
		}
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
	
	next4.click(function(){
		errorCurrentAddress=false;
		errorCurrentCountry=false;
		errorCurrentState=false;
		errorCurrentCity=false;
		errorCurrentZipCode=false;0
		errorPresentAddress=false;
		errorPresentCountry=false;
		errorPresentState=false;
		errorPresentCity=false;
		errorPresentZipCode=false;
		
		if(checkCurrentAddress())
		if(checkCurrentCountry())
		if(checkCurrentState())
		if(checkCurrentCity())
		if(checkCurrentZipCode())
		if(checkPresentAddress())
		if(checkPresentCountry())
		if(checkPresentState())
		if(checkPresentCity())
		if(checkPresentZipCode()){
			if(errorCurrentAddress && errorCurrentCountry && errorCurrentState && errorCurrentCity && errorCurrentZipCode && errorPresentAddress && errorPresentCountry &&
				errorPresentState && errorPresentCity && errorPresentZipCode){
				form4.hide();
				form5.show();
			}else{
				pAddressError.html("Fill all the details correctly...")
			}
		}
	});
	refresh.click(function(){
		captcha();
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
		displayError.css("visibility","visible");
	}
	function error(message,displayError,elementField){
		displayError.html(message);
		elementField.setCustomValidity(message);
		displayError.css("visibility","visible");
	}
	function noError(displayError,elementField){
		displayError.css("visibility","hidden");
		elementField.setCustomValidity("");
	}
	function checkFirstName(){
		if(fName.val().length===0){
			emptyError("First Name",personalError,fName[0]);
		}else if(fName.val().match(/[A-Za-z]+/)!=fName.val().trim()){
			error("First Name should contain only alphabets",personalError,fName[0]);
		} else {
			noError(personalError,fName[0]);
			errorFirstName=true;
			return true;
		}
		return false;
	}
	function checkMiddleName(){
		if(mName.val().match(/[A-Za-z]*/)!=mName.val().trim()){
			error("Middle Name should contain only alphabets",personalError,mName[0]);
		} else {
			noError(personalError,mName[0]);
			errorMiddleName=true;
			return true;
		}
		return false;
	}
	function checkLastName(){
		if(lName.val().length===0){
			emptyError("Last Name",personalError,lName[0]);
		}else if(lName.val().match(/[A-Za-z]+/)!=lName.val().trim()){
			error("Last Name should contain only alphabets",personalError,lName[0]);
		} else {
			noError(personalError,lName[0]);
			errorLastName=true;
			return true;
		}
		return false;
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
				return true;
			}
		}
		return false;
	}
	function checkGender(){
		if(!(gender[0].checked || gender[1].checked || gender[2].checked)){
			personalError.html("Please select your gender");
			personalError.css("visibility","visible");
		}else{
			personalError.html("");
			personalError.css("visibility","hidden");
			errorGender=true;
			return true;
		}
		return false;
	}
	function checkEmail(){
		if (email.val().length === 0) {
			emptyError('Email',contactError,email[0]);
		} else if (!(/^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$/).test(email.val().trim())){
			error('please enter a valid email address',contactError,email[0]);
		} else {
			noError(contactError,email[0]);
			errorEmail=true;
			return true;
		}
		return false;
	}
	function checkPhoneNumber(){
		if (phoneNumber.val().length === 0) {
				emptyError('Phone number',contactError,phoneNumber[0]);
		}  else if (phoneNumber.val().match(/[1-9][0-9]{9}/)!=phoneNumber.val().trim()){
			error('phone number must contain 10 digits',contactError,phoneNumber[0]);
		} else {
			noError(contactError,phoneNumber[0]);
			errorPhoneNumber=true;
			return true;
		}
		return false;
	}
	function checkPassword(){
		if (pass.val().length === 0) {
			emptyError('Password',passwordError,pass[0]);
		} else if (!(/(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}/).test(pass.val())){
			error('Password must contain at least 8 characters, including UPPER/lowercase and numbers',passwordError,pass[0]);
		} else {
			noError(passwordError,pass[0]);
			errorPassword=true;
			return true;
		}
		return false;
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
				return true;
			}
		}else{
			error('confirm password must contain at least 8 characters, including UPPER/lowercase and numbers',passwordError,cPassword[0]);
		}
		return false;		
	} 
	
	function checkCurrentAddress(){
		if (cAddress.val().length === 0) {
			emptyError('Address field',cAddressError,cAddress[0]);
		} else if (!(/.{15,50}/).test(cAddress.val())){
			error('Address should be more than 15 characters and less than 50 character',cAddressError,cAddress[0]);
		} else {
			noError(cAddressError,cAddress[0]);
			errorCurrentAddress=true;
			return true;
		}
		return false;
	}
	function checkCurrentCity(){
		if (cCity.val() == "select") {
			emptyError('City',cAddressError,cCity[0]);
		}else {
			noError(cAddressError,cCity[0]);
			errorCurrentCity=true;
			return true;
		}
		return false;
	}
	function checkCurrentState(){
		if (cState.val() == "select") {
			emptyError('State',cAddressError,cState[0]);
		} else {
			noError(cAddressError,cState[0]);
			errorCurrentState=true;
			return true;
		}	
		return false;
	}
	function checkCurrentCountry(){
		if (cCountry.val() == "select") {
			emptyError('Country',cAddressError,cCountry[0]);
		} else {
			noError(cAddressError,cCountry[0]);
			errorCurrentCountry=true;
			return true;
		}
		return false;
	}
	function checkCurrentZipCode(){
		if (cZipCode.val().length === 0) {
			emptyError('Zip Code',cAddressError,cZipCode[0]);
		} else if (cZipCode.val().match(/[0-9]{6}/)!=cZipCode.val()){
			error('Zip code must be 6 digits',cAddressError,cZipCode[0]);
		} else {
			noError(cAddressError,cZipCode[0]);
			errorCurrentZipCode=true;
			return true;
		}
		return false;
	}
	
	function checkPresentAddress(){
		if (pAddress.val().length === 0) {
			emptyError('Address field',pAddressError,pAddress[0]);
		} else if (!(/.{15,50}/).test(pAddress.val())){
			error('Address should be more than 15 characters and less than 50 character',pAddressError,pAddress[0]);
		} else {
			noError(pAddressError,pAddress[0]);
			errorPresentAddress=true;
			return true;
		}
		return false;
	}
	function checkPresentCity(){
		if (pCity.val() == "select") {
			emptyError('City',pAddressError,pCity[0]);
		} else {
			noError(pAddressError,pCity[0]);
			errorPresentCity=true;
			return true;
		}
		return false;
	}
	function checkPresentState(){
		if (pState.val() == "select") {
			emptyError('State',pAddressError,pState[0]);
		} else {
			noError(pAddressError,pState[0]);
			errorPresentState=true;
			return true;
		}
		return false;
	}
	function checkPresentCountry(){
		if (pCountry.val() == "select") {
			emptyError('Country',pAddressError,pCountry[0]);
		} else {
			noError(pAddressError,pCountry[0]);
			errorPresentCountry=true;
			return true;
		}
		return false;
	}
	function checkPresentZipCode(){
		if (pZipCode.val().length === 0) {
			emptyError('Zip Code',pAddressError,pZipCode[0]);
		} else if (pZipCode.val().match(/[0-9]{6}/)!=pZipCode.val()){
			error('Zip code must be 6 digits',pAddressError,pZipCode[0]);
		} else {
			noError(pAddressError,pZipCode[0]);
			errorPresentZipCode=true;
			return true;	
		}
		return false;
	}
	
	function checkPersonalInterests(){
		if(personalInterests[0].checked || personalInterests[1].checked || personalInterests[2].checked || personalInterests[3].checked || personalInterests[4].checked ||
			personalInterests[5].checked || personalInterests[6].checked || personalInterests[7].checked){
				noError(pInterestsError,personalInterests[7]);
				errorPersonalInterests=true;
				return true;
		}else{
			error('please select any of your personal interests or others ',pInterestsError,personalInterests[7]);
		}
		return false;
	}	
	function checkCaptcha(){
		if(result.val().length===0){
			emptyError("Captcha value",submitError,result[0]);
		}else if(captchaResult!=$("#result").val()){
			error("Try once more...",submitError,result[0]);
		} else {
			noError(submitError,result[0]);
			errorCaptcha=true;
			return true;
		}
		return false;
	}
	function checkPolicy(){
		if(!policy.prop('checked')){
			error("Accept the terms and conditions",submitError,policy[0]);
		} else {
			noError(submitError,policy[0]);
			errorPolicy=true;
			return true;
		}
		return false;
	}
	
	registrationForm.submit(function(){
		
		errorCaptcha=false;
		errorPolicy=false;
		errorPersonalInterests=false;
		if(checkPersonalInterests())
		if(checkCaptcha())
		if(checkPolicy()){
			if(errorPersonalInterests && errorCaptcha && errorPolicy){
				registrationForm.html("<p style='color:green'>Congratulations,You registered successfully...</p>");
			}
		}
		
		
		return false;
	});
});