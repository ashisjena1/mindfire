var fName=document.getElementById("fName");
var mName=document.getElementById("mName");
var lName=document.getElementById("lName");
var dob=document.getElementById("dob");
var male=document.getElementById("male");
var female=document.getElementById("female");
var others=document.getElementById("others");
var email=document.getElementById("email");
var phoneNumber=document.getElementById("phoneNumber");
var pass=document.getElementById("password");
var cPassword=document.getElementById("cPassword");
var cAddress=document.getElementById("cAddress");
var cCity=document.getElementById("cCity");
var cState=document.getElementById("cState");
var cCountry=document.getElementById("cCountry");
var cZipCode=document.getElementById("cZipCode");
var pAddress=document.getElementById("pAddress");
var pCity=document.getElementById("pCity");
var pState=document.getElementById("pState");
var pCountry=document.getElementById("pCountry");
var pZipCode=document.getElementById("pZipCode");
var pInterests=document.getElementsByName("personalInterests");
var oInterests=document.getElementById("oInterests");
var others=document.getElementById("others");
var result=document.getElementById("result");
var policy=document.getElementById("policy");


function validateForm(){
	
	var form=document.getElementById("registrationForm");
		
	if( checkFirstName() && checkMiddleName() && checkLastName() && checkDOB() && checkGender() && checkEmail() && checkPhoneNumber() && checkPassword() && checkConfirmPassword() &&
		checkCurrentAddress() && checkCurrentCountry() && checkCurrentState() && checkCurrentCity() && checkCurrentZipCode() && checkPermanentAddress() && checkPermanentCountry() &&
		checkPermanentState() && checkPermanentCity && checkPermanentZipCode() && checkPersonalInterests() && checkCaptcha() && checkPolicy()){
		
		msg='<h3 style="color:green;text">Congratulations you registered successfully...</h3>'
		form.innerHTML=msg;
	}
	/*else{
		
		msg='<h2 style="color:red;text">Sorry you entered wrong details or missing something...</h2><br><h4>please fill the details again...</h4>'
		form.innerHTML=msg;
	}*/

	return false;
}
function checkFirstName(){	
	if (fName.value === '') {
		fName.setCustomValidity('Required first name');
	} else if (fName.value.match(/[A-Za-z]+/)!=fName.value.trim()){
		fName.setCustomValidity('First Name should contain only alphabets');
	} else {
	    fName.setCustomValidity('');
		return true;
	}
	return false;
}

function checkMiddleName(){
	if (mName.value.match(/[A-Za-z]*/)!=mName.value.trim()){
		mName.setCustomValidity('Middle Name should contain only alphabets');
	} else {
	   mName.setCustomValidity('');
	   return true;
	}
	return false;
}
function checkLastName(){
	if (lName.value === '') {
		lName.setCustomValidity('Required last name');
	} else if (lName.value.match(/[A-Za-z]+/)!=lName.value.trim()){
		lName.setCustomValidity('Last Name should contain only alphabets');
	} else {
	    lName.setCustomValidity('');
		return true;
	}
	return false;
}
function checkDOB(){
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
	if(!(male.checked || female.checked || others.checked)){
		male.setCustomValidity("Please select your gender");
		return false;
	}
	male.setCustomValidity("");
	return true;
}

function checkEmail(){
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
	if (phoneNumber.value === '') {
		phoneNumber.setCustomValidity('Required phone number');
	} else if (phoneNumber.value.match(/[1-9][0-9]{9}/)!=phoneNumber.value){
		phoneNumber.setCustomValidity('phone number must be 10 digits');
	} else {
	    phoneNumber.setCustomValidity('');
	}
	return true;
}
function checkPassword(){
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
	if (cCity.value === '') {
		cCity.setCustomValidity('Required city');
	} else if (cCity.value.match(/[A-Za-z]+/)!=cCity.value.trim()){
		cCity.setCustomValidity('please enter a valid city name');
	} else {
	    cCity.setCustomValidity('');
		return true;
	}
	return false;
}
function checkCurrentState(){
	if (cState.value === '') {
		cState.setCustomValidity('Required State');
	} else{
	    cState.setCustomValidity('');
		return true;
	}
	return false;
}
function checkCurrentCountry(){
	if (cCountry.value === '') {
		cCountry.setCustomValidity('Required country');
	} else{
	    cCountry.setCustomValidity('');
		return true;
	}
	return false;
}

function checkCurrentZipCode(){
	if (cZipCode.value === '') {
		cZipCode.setCustomValidity('Required zip code');
	} else if (cZipCode.value.match(/[0-9]{6}/)!=cZipCode.value){
		cZipCode.setCustomValidity('zip code must be 6 digits');
	} else {
	    cZipCode.setCustomValidity('');
		return true;
	}
	return false;
}

function checkPermanentAddress(){
	
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
	
	if (pCity.value === '') {
		pCity.setCustomValidity('Required city');
	} else if (pCity.value.match(/[A-Za-z]+/)!=pCity.value.trim()){
		pCity.setCustomValidity('please enter a valid city name');
	} else {
	    pCity.setCustomValidity('');
		return true;
	}
	return false;
}
function checkPermanentState(){
	
	if (pState.value === '') {
		pState.setCustomValidity('Required State');
	} else{
	    pState.setCustomValidity('');
		return true;
	}
	return false;
}
function checkPermanentCountry(){

	if (pCountry.value === '') {
		pCountry.setCustomValidity('Required country');
	} else{
	    pCountry.setCustomValidity('');
		return true;
	}
	return false;
}

function checkPermanentZipCode(){
	
	if (pZipCode.value === '') {
		pZipCode.setCustomValidity('Required zip code');
	} else if (pZipCode.value.match(/[0-9]{6}/)!=pZipCode.value){
		pZipCode.setCustomValidity('zip code must be 6 digits');
	} else {
	    pZipCode.setCustomValidity('');
		return true;
	}
	return false;
}
function checkPersonalInterests(){
	if(pInterests[0].checked || pInterests[1].checked || pInterests[2].checked || pInterests[3].checked || pInterests[4].checked || pInterests[5].checked || pInterests[6].checked ||
		pInterests[7].checked){
		pInterests[7].setCustomValidity('');
		return true;
	}
	else{
		pInterests[7].setCustomValidity("please select any of your personal interests or others");
	}
	return false;
}
function otherInterests(){
	
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
	
	result.setCustomValidity('');
	if (captchaResult!=result.value){
		result.oninvalid="invalid";
		result.setCustomValidity('try once more...');
		return false;
	} 
	result.setCustomValidity('');
	return true;
}
function checkPolicy(){
	if(!policy.checked){
		policy.setCustomValidity("Accept the terms and conditions");
		return false;
	}else{
		policy.setCustomValidity("");
		return true;
	}
}