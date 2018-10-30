$(document).ready(function(){
	
	
	var back = $("#back");
	var edit = $("#edit");
	var updateDetails = $("#updateDetails");
	var dob = $("#dob");
	var dateOfBirth = $("#dateOfBirthInput");
	var editDob = $("#editDob");
	var gender = $("#gender");
	var editGender = $("#editGender");
	var phoneNumber = $("#phoneNumber");
	var phoneNumberInput = $("#phoneNumberInput");
	var editPhoneNumber = $("#editPhoneNumber");
	var genderHidden = $("#genderHidden").val();
	var male = $("#male");
	var female = $("#female");
	var other = $("#other");
	var updateProfile = $("#updateProfile");
	
	var dobError = $("#dobError");
	var phoneNumberError = $("#phoneNumberError");
	
	var errorDOB;
	var errorGender;
	var errorPhoneNumber;
	
	if(genderHidden == 'f'){
		female.prop('checked',true);
	}else if(genderHidden == 'm'){
		male.prop('checked',true);
	}else if(genderHidden == 'o'){
		other.prop('checked',true);
	}
	
	updateDetails.hide();
	back.hide();
	editDob.hide();
	editGender.hide();
	editPhoneNumber.hide();
	
	
	edit.click(function(){
		edit.hide();
		dob.hide();
		gender.hide();
		phoneNumber.hide();
		
		updateDetails.show();
		back.show();
		editDob.show();
		editGender.show();
		editPhoneNumber.show();
		
		dobError.hide();
		phoneNumberError.hide();
		
	});
	
	back.click(function(){
		edit.show();
		dob.show();
		gender.show();
		phoneNumber.show();
		
		updateDetails.hide();
		back.hide();
		editDob.hide();
		editGender.hide();
		editPhoneNumber.hide();
		
		dobError.hide();
		phoneNumberError.hide();
	});
	
	function checkDOB(){
		
		if(dateOfBirth.val()){
			var date=new Date(dateOfBirth.val());
			var today=new Date();
			if(date >= today){
				dobError.html("Date of Birth should not be greater than today's date");
			} else {
				dobError.html("");
				errorDOB=true;
			}
		}
	}
	
	function checkPhoneNumber(){
		if (phoneNumberInput.val().match(/[1-9][0-9]{9}/)!=phoneNumberInput.val().trim()){
			phoneNumberError.html('phone number must contain 10 digits');
		} else {
			phoneNumberError.html("");
			errorPhoneNumber=true;
		}
		return false;
	}
		
	updateProfile.submit(function(){
		
		dobError.show();
		phoneNumberError.show();
		
		errorDOB=false;
		errorPhoneNumber=false;
		
		checkDOB();
		checkPhoneNumber();
		
		console.log(errorDOB,errorPhoneNumber)
		
		if(errorDOB && errorPhoneNumber){
				return true;
		}
		return false;
		});
});	