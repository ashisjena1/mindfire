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
	
	showBlock(personalDetailsTemplate);
			
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
	
	
	
	
	var back = $("#back");
	var edit = $("#edit");
	var updateDetails = $("#updateDetails");
	
	var employeeRole = $("#employeeRole");
	var roleNameHidden = $("#roleNameHidden");
	var editEmployeeRole = $("#editEmployeeRole");
	var basicSalary = $("#basicSalary");
	var editBasicSalary = $("#editBasicSalary");
	var basicSalrayInput = $("#basicSalrayInput")
	
	var updateProfile = $("#updateProfile");
	
	var salaryError = $("#salaryError");
	
	var errorSalary;
	
	
	updateDetails.hide();
	back.hide();
	editEmployeeRole.hide();
	editBasicSalary.hide();
	
	
	
	edit.click(function(){
		edit.hide();
		employeeRole.hide();
		basicSalary.hide();
		
		updateDetails.show();
		back.show();
		
		editEmployeeRole.show();
		editBasicSalary.show();
		
		salaryError.hide();
		
	});
	
	back.click(function(){
		edit.show();
		employeeRole.show();
		basicSalary.show();
		
		updateDetails.hide();
		back.hide();
		editEmployeeRole.hide();
		editBasicSalary.hide();
		
		salaryError.hide();
	});

	
	function checkSalary(){
		if (!(/\d+(\.\d+)?/).test(basicSalrayInput.val())){
			salaryError.html('Basic Salary contais digit only or a float number');
		} else {
			salaryError.html("");
			errorSalary=true;
		}
	}
		
	updateProfile.submit(function(){
		
		salaryError.show();

		errorSalary = false;
		
		checkSalary();
		
		if(errorSalary){
				return true;
		}
		return false;
	});
});	

function showBlock(details){
	$(".tabcontent").css("display" , "none");
	details.css("display" , "block");
}	