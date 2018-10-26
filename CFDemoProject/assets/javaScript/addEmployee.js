$(document).ready(function(){
	var firstNameError=$("#firstNameError");
	var middleNameError=$("#middleNameError");
	var lastNameError=$("#lastNameError");
	var emailError=$("#emailError");
	var dobError=$("#dobError");
	var phoneNumberError=$("#phoneNumberError");
	var genderError=$("#genderError");
	var joiningDateError=$("#joiningDateError");
	var departmentNameError=$("#departmentNameError");
	var basicSalaryError=$("#basicSalaryError");
	var roleNameError=$("#roleNameError");
	var addNewEmployee=$("#addNewEmployee");
			
	var errorFirstName;
	var errorLastName;
	var errorMiddleName;
	var errorDOB;
	var errorGender;
	var errorEmail;
	var errorPhoneNumber;
	var errorJoiningDate;
	var errorDepartmentName;
	var errorBasicSalary;
	var errorRoleName;
	
	
	var fName=$("#firstName");
	var mName=$("#middleName");
	var lName=$("#lastName");
	var dob=$("#dob");
	var gender=$("input[name='gender']");
	var email=$("#email");
	var phoneNumber=$("#phoneNumber");
	var joiningDate =$("#joiningDate");
	var departmentName=$("#departmentName");
	var basicSalary=$("#basicSalary");
	var roleName=$("#roleName");
	
	
	
	
		
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
	joiningDate.focusout(function(){
		errorjoiningDate=false;
		checkJoiningDate();
	});
	departmentName.focusout(function(){
		errorDepartmentName=false;
		checkDepartmentName();
	});
	
	basicSalary.focusout(function(){
		errorBasicSalary=false;
		checkBasicSalary();
	});
	roleName.focusout(function(){
		errorRoleName=false;
		checkRoleName();
	});
	
	
	
	
	

	function checkNameError(name,nameError,value){
		
		if(name == ''){
			nameError.html(value+' should not be empty');
		}else if(name.match(/[A-Za-z]+/)!=name){
			nameError.html(value+' should contain only alphabets');
		} else {
			nameError.html("");
			return true;
		}
		return false;
	}
	
	function checkFirstName(){
		firstName=$.trim(fName.val());
		if(checkNameError(firstName,firstNameError,"First name")){
			errorFirstName=true;
		}
	}
	function checkLastName(){
		lastName=$.trim(lName.val());
		if(checkNameError(lastName,lastNameError,"Last name")){
			errorLastName=true;	
		}
	}
		
	function checkMiddleName(){
		if(mName.val().match(/[A-Za-z]*/)!=mName.val().trim()){
			middleNameError.html("Middle Name should contain only alphabets");
		} else {
			middleNameError.html("");
			errorMiddleName=true;
		}
	}
	
	function checkDOB(){
		if(dob.val().length===0){
			dobError.html("Date of Birth should not be empty");
		}else if(dob.val()){
			var date=new Date(dob.val());
			var today=new Date();
			if(date >= today){
				dobError.html("Date of Birth should not be greater than today's date");
			} else {
				dobError.html("");
				errorDOB=true;
			}
		}
	}
	function checkGender(){
		if(!(gender[0].checked || gender[1].checked || gender[2].checked)){
			genderError.html("Please select your gender");
		}else{
			genderError.html("");
			errorGender=true;
		}
	}
	function checkEmail(){
		if (email.val().length === 0) {
			emailError.html('Email should not be empty');
		} else if (!(/^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$/).test(email.val().trim())){
			emailError.html('please enter a valid email address');
		} else {
			emailError.html("");
			errorEmail=true;
		}
	}
	function checkPhoneNumber(){
		if (phoneNumber.val().length === 0) {
				phoneNumberError.html('Phone numbershould not be empty');
		}  else if (phoneNumber.val().match(/[1-9][0-9]{9}/)!=phoneNumber.val().trim()){
			phoneNumberError.html('phone number must contain 10 digits');
		} else {
			phoneNumberError.html("");
			errorPhoneNumber=true;
		}
		return false;
	}
	
	function checkJoiningDate(){
		if(joiningDate.val().length===0){
			joiningDateError.html("Joining Date should not be empty");
		}else if(joiningDate.val()){
			var date=new Date(joiningDate.val());
			var today=new Date();
			if(date < today){
				joiningDateError.html("Joining Date can not be previous date");
			} else {
				joiningDateError.html("");
				errorJoiningDate =true;
			}
		}
	}
	
	function checkDepartmentName(){
		if (departmentName.val() == "") {
			departmentNameError.html("Department Name should be select");
		}else {
			departmentNameError.html("")
			errorDepartmentName=true;
		}
	}
	
	function checkBasicSalary(){
		if (basicSalary.val() == "") {
			basicSalaryError.html("Basic Salary should not be empty");
		} else {
			basicSalaryError.html("");
			errorBasicSalary=true;
		}	
	}
	function checkRoleName(){
		if (roleName.val() == "") {
			roleNameError.html("Role of the employee should be select");
		} else {
			roleNameError.html("")
			errorRoleName=true;
		}
	}
	
	
	addNewEmployee.submit(function(){
		errorFirstName=false;
		errorLastName=false;
		errorMiddleName=false;
		errorDOB=false;
		errorGender=false;
		errorEmail=false;
		errorPhoneNumber=false;
		errorJoiningDate=false;
		errorDepartmentName=false;
		errorBasicSalary=false;
		errorRoleName=false;
		
		checkFirstName();
		checkMiddleName();
		checkLastName();
		checkDOB();
		checkGender();
		checkEmail();
		checkPhoneNumber();
		checkJoiningDate();
		checkDepartmentName();
		checkBasicSalary();
		checkRoleName();
		
		
		if(errorFirstName && errorLastName && errorMiddleName && errorDOB && errorGender && errorEmail && errorPhoneNumber && errorJoiningDate && errorDepartmentName 
						&& errorBasicSalary && errorRoleName){
				addEmployee.html("<p style='color:green'>Congratulations,You registered successfully...</p>");
		}
		return false;
	});
});