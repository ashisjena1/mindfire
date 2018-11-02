$(document).ready(function(){
	
	
	var personalDetails = $("#personalDetails");
	var projectDetails = $("#projectDetails");
	var skillsDetails = $("#skillsDetails");
	var annualLeaveDetails = $("#annualLeaveDetails");
	var leaveHistory = $("#leaveHistory");
	
	var personalDetailsTemplate = $("#personalDetailsTemplate");
	var projectDetailsTemplate = $("#projectDetailsTemplate");
	var skillDetailsTemplate = $("#skillDetailsTemplate");
	var annualLeaveDetailsTemplate = $("#annualLeaveDetailsTemplate");
	var leaveHistoryTemplate = $("#leaveHistoryTemplate");
	
	var message = $("#message");
			
	personalDetails.click(function(){
		showBlock(personalDetailsTemplate);
	});
	
	projectDetails.click(function(){
		showBlock(projectDetailsTemplate);
	});
	
	skillsDetails.click(function(){
		showBlock(skillDetailsTemplate);
	});
	
	annualLeaveDetails.click(function(){
		showBlock(annualLeaveDetailsTemplate);
	});
	
	leaveHistory.click(function(){
		showBlock(leaveHistoryTemplate);
	});
	
	showBlock(personalDetailsTemplate);
	
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
	var successMessage =$("#successMessage");
	
	var dobError = $("#dobError");
	var phoneNumberError = $("#phoneNumberError");
	
	var errorDOB;
	var errorPhoneNumber;
	
	if(genderHidden == 'Female'){
		female.prop('checked',true);
	}else if(genderHidden == 'Male'){
		male.prop('checked',true);
	}else if(genderHidden == 'Other'){
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
		
		successMessage.hide();
		
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
		
		successMessage.hide();
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
		
		successMessage.show();
		
		dobError.show();
		phoneNumberError.show();
		
		errorDOB=false;
		errorPhoneNumber=false;
		
		checkDOB();
		checkPhoneNumber();
		
		
		if(errorDOB && errorPhoneNumber){
				return true;
		}
		return false;
	});
		
	$("#addSkill").click(function(){
		var id = $("#id").val();
		var skill = $("#skills").val();
		var skills = $("#skillHistory").html();
		var selectedSkill = $("#skills option:selected").html();
        $.ajax({
			type:"post",
			url:"../components/employeeService.cfc?method=addSkill",
			data:{
			employeeId : id,
			skillId : skill
			},
			datatype :"json",
			success : function (res) {
			var resp = $.parseJSON(res);
			if(resp) {
				skills = skills + "<span class='btn'>" + selectedSkill + "</span>";
				$("#skillHistory").html(skills);
				message.removeClass('text-danger');
				message.addClass('text-success');
				message.html(selectedSkill + " added sucessfully")
			}else {
				message.addClass('text-danger');
				message.html(selectedSkill+ " was already added")
			}
			}
		});
	});
});	

function showBlock(details){
	$(".tabcontent").css("display" , "none");
	details.css("display" , "block");
}	