function validateForm(){
	
	var form=document.getElementById("registrationForm");

		
	if( checkFirstName() && checkMiddleName() && checkLastName() && checkDOB() && checkGender() && checkEmail() && checkPhoneNumber() && checkPassword() && checkConfirmPassword() &&
		checkCurrentAddress() && checkCurrentCountry() && checkCurrentState() && checkCurrentCity() && checkCurrentZipCode() && checkPermanentAddress() && checkPermanentCountry() &&
		checkPermanentState() && checkPermanentCity && checkPermanentZipCode() && checkPersonalInterests() && checkCaptcha() && checkPolicy()){
		
		msg='<h3 style="color:green;text">Congratulations you registered successfully...</h3>'
		form.innerHTML=msg;
	}
	else{
		
		msg='<h2 style="color:red;text">Sorry you entered wrong details or missing something...</h2><br><h4>please fill the details again...</h4>'
		form.innerHTML=msg;
	}

	return false;
}
function checkFirstName(){
	fName=document.getElementById("fName");
	if (fName.value === '') {
		fName.setCustomValidity('Required first name');
	} else if (fName.value.match(/[A-Za-z]+/)!=fName.value){
		fName.setCustomValidity('please enter a valid first name');
	} else {
	    fName.setCustomValidity('');
		return true;
	}
	return false;
}

function checkMiddleName(){
	mName=document.getElementById("mName");
	if (mName.value.match(/[A-Za-z]*/)!=mName.value){
		mName.setCustomValidity('please enter a valid middle name');
	} else {
	   mName.setCustomValidity('');
	   return true;
	}
	return false;
}
function checkLastName(){
	lName=document.getElementById("lName");
	if (lName.value === '') {
		lName.setCustomValidity('Required last name');
	} else if (lName.value.match(/[A-Za-z]+/)!=lName.value){
		lName.setCustomValidity('please enter a valid last name');
	} else {
	    lName.setCustomValidity('');
		return true;
	}
	return false;
}
function checkDOB(){
	dob=document.getElementById("dob");
	if (dob.value === '') {
		dob.setCustomValidity('Required Date of Birth');
	} else if (dob){
		var date=new Date(dob.value);
		var today=new Date();
		if(date >= today){
			this.oninvalid='invalid';
			dob.setCustomValidity("Date of Birth should not be greater than today's date");
		}else {
		dob.setCustomValidity('');
		return true;
		}
	} 
	return false;
}
function checkGender(){
	
	var gender=document.getElementsByName("gender");
	var genderError=document.getElementById("genderError");
	if(!(gender[0].checked || gender[1].checked || gender[2].checked)){
		genderError.innerHTML="Please select your gender";
		return false;
	}
	genderError.innerHTML="";
	return true;
}

function checkEmail(){
	var email=document.getElementById("email");
	if (email.value === '') {
		email.setCustomValidity('Required email address');
	} else if (!email.value.match(/^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$/)){
		
		email.setCustomValidity('please enter a valid email address');
	} else {
		
	    email.setCustomValidity('');
		return true;
	}
	return false;
}
function checkPhoneNumber(){
	var phoneNumber=document.getElementById("phoneNumber");
	if (phoneNumber.value === '') {
		phoneNumber.setCustomValidity('Required phone number');
	} else if (phoneNumber.value.match(/[1-9][0-9]{9}/)!=phoneNumber.value){
		phoneNumber.setCustomValidity('please enter a valid phone number');
	} else {
	    phoneNumber.setCustomValidity('');
	}
	return true;
}
function checkPassword(){
	var pass=document.getElementById("password");
	if (pass.value === '') {
		pass.setCustomValidity('Required password');
	} else if (pass.value.match(/(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}/)!=pass.value){
		pass.setCustomValidity('Password must contain at least 8 characters, including UPPER/lowercase and numbers');
	} else {
	    pass.setCustomValidity('');
	}
	return true;
}
function checkConfirmPassword(){
	var cPassword=document.getElementById("cPassword");
	if (cPassword.value === '') {
		cPassword.setCustomValidity('Required confirm password');
	} else if (cPassword.value.match(/(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}/)==cPassword.value){
		var pass=document.getElementById('password').value;
		if(cPassword.value!==pass){
			cPassword.setCustomValidity('Confirm password should be match with the above password');
		}
		else{
			cPassword.setCustomValidity('');
			return true;
		}
		
	} else {
	    cPassword.setCustomValidity('Password must contain at least 8 characters, including UPPER/lowercase and numbers');
	}
	return false;
}
function checkCurrentAddress(){
	var cAddress=document.getElementById("cAddress");
	if (cAddress.value === '') {
		cAddress.setCustomValidity('This field should be filled');
	} else if (cAddress.value.match(/.{15,50}/)!=cAddress.value){
		cAddress.setCustomValidity('Address should be more tahn 15 characters and less than 50 character');
	} else {
	    cAddress.setCustomValidity
		return true;
	}
	return false;
}
function checkCurrentCity(){
	var cCity=document.getElementById("cCity");
	if (cCity.value === '') {
		cCity.setCustomValidity('Required city');
	} else if (cCity.value.match(/[A-Za-z]+/)!=cCity.value){
		cCity.setCustomValidity('please enter a valid city name');
	} else {
	    cCity.setCustomValidity('');
		return true;
	}
	return false;
}
function checkCurrentState(){
	var cState=document.getElementById("cState");
	if (cState.value === '') {
		cState.setCustomValidity('Required State');
	} else{
	    cState.setCustomValidity('');
		return true;
	}
	return false;
}
function checkCurrentCountry(){
	var cCountry=document.getElementById("cCountry");
	if (cCountry.value === '') {
		cCountry.setCustomValidity('Required country');
	} else{
	    cCountry.setCustomValidity('');
		return true;
	}
	return false;
}

function checkCurrentZipCode(){
	var cZipCode=document.getElementById("cZipCode");
	if (cZipCode.value === '') {
		cZipCode.setCustomValidity('Required zip code');
	} else if (cZipCode.value.match(/[0-9]{6}/)!=cZipCode.value){
		cZipCode.setCustomValidity('please enter a valid zip code');
	} else {
	    cZipCode.setCustomValidity('');
		return true;
	}
	return false;
}

function checkPermanentAddress(){
	var pAddress=document.getElementById("pAddress");
	if (pAddress.value === '') {
		pAddress.setCustomValidity('This field should be filled');
	} else if (pAddress.value.match(/.{15,50}/)!=pAddress.value){
		pAddress.setCustomValidity('Address should be more tahn 15 characters and less than 50 character');
	} else {
	    pAddress.setCustomValidity
		return true;
	}
	return false;
}
function checkPermanentCity(){
	var pCity=document.getElementById("pCity");
	if (pCity.value === '') {
		pCity.setCustomValidity('Required city');
	} else if (pCity.value.match(/[A-Za-z]+/)!=pCity.value){
		pCity.setCustomValidity('please enter a valid city name');
	} else {
	    pCity.setCustomValidity('');
		return true;
	}
	return false;
}
function checkPermanentState(){
	var pState=document.getElementById("pState");
	if (pState.value === '') {
		pState.setCustomValidity('Required State');
	} else{
	    pState.setCustomValidity('');
		return true;
	}
	return false;
}
function checkPermanentCountry(){
	var pCountry=document.getElementById("pCountry");
	if (pCountry.value === '') {
		pCountry.setCustomValidity('Required country');
	} else{
	    pCountry.setCustomValidity('');
		return true;
	}
	return false;
}

function checkPermanentZipCode(){
	var pZipCode=document.getElementById("pZipCode");
	if (pZipCode.value === '') {
		pZipCode.setCustomValidity('Required zip code');
	} else if (pZipCode.value.match(/[0-9]{6}/)!=pZipCode.value){
		pZipCode.setCustomValidity('please enter a valid zip code');
	} else {
	    pZipCode.setCustomValidity('');
		return true;
	}
	return false;
}
function checkPersonalInterests(){
	var pInterests=document.getElementsByName("personalInterests");
	if(pInterests[0].checked || pInterests[1].checked || pInterests[2].checked || pInterests[3].checked || pInterests[4].checked || pInterests[5].checked || pInterests[6].checked){
		pInterests[7].setCustomValidity('');
		return true;
	}
	pInterests[7].setCustomValidity("please select any of your personal interests or others");
	return false;
}
function otherInterests(){
	var oInterests=document.getElementById("oInterests");
	var others=document.getElementById("others");
	if(others.checked){
		oInterests.style.display="block";
	}else{
		oInterests.style.display="none";
	}
}
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
	document.getElementById("first").innerHTML=first;
	document.getElementById('second').innerHTML=second;
	document.getElementById('operator').innerHTML=operator;
}

function checkCaptcha(){
	result=document.getElementById("result");
	result.setCustomValidity('');
	if (captchaResult!=result.value){
		result.oninvalid="invalid";
		result.setCustomValidity('try once more...');
		return false;
	} 
	return true;
}
function checkPolicy(){
	var policy=document.getElementById('policy');
	if(!policy.checked){
		policy.setCustomValidity("Accept the terms and conditions");
		return false;
	}
	return true;
}