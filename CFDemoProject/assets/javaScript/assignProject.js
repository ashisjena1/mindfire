
$(document).ready(function() {
	var nameError = $("#nameError");
	var projectNameError = $("#projectNameError");
	var assignDateError = $("#assignDateError");
	var completionDateError = $("#completionDateError");
	
	
	var name = $("#name");
	var project = $("#project");
	var assignDate = $("#assignDate");
	var completionDate = $("#completionDate");
	var assignProject = $("#assignProject");
	
	
	var errorName;
	var errorProjectName;
	var errorAssignDate;
	var errorCompletionDate;
	
	name.focusout(function(){
		checkName();
	});
	project.focusout(function(){
		checkProject();
	});
	assignDate.focusout(function(){
		checkAssignDate();
	});
	completionDate.focusout(function(){
		checkCompletionDate();
	});
	
	function checkName(){
		if (name.val() == "") {
			nameError.html('Please select the Name of the Employee');
		} else {
			nameError.html("");
			errorName=true;
		}	
	}
	function checkProject(){
		if (project.val() == "") {
			projectNameError.html('Please select the Name of the Project');
		} else {
			projectNameError.html("");
			errorProjectName=true;
		}	
	}
	
	
	function checkAssignDate(){
		if(assignDate.val().length===0){
			assignDateError.html("Assign Date should not be empty");
		}else if(assignDate.val()){
			var date=new Date(assignDate.val());
			var today=new Date();
			//today.setHours(0,0,0,0);
			if(date < today){
				assignDateError.html("Project assign date can not be previous date");
			} else {
				assignDateError.html("");
				errorAssignDate=true;
			}
		}
	}
	
	
	function checkCompletionDate(){
		
		if(completionDate.val().length===0){
			completionDateError.html("Completion Date should not be empty");
		}else if(completionDate.val()){
			var cDate=new Date(completionDate.val());
			var aDate=new Date(assignDate.val());
			//today.setHours(0,0,0,0);
			if(cDate < aDate){
				completionDateError.html("Project finish Date can not be before start date");
			} else {
				completionDateError.html("");
				errorCompletionDate=true;
			}
		}
	}
	
		
	assignProject.submit(function(){
		
		errorName = false;
		errorProjectName = false;
		errorAssignDate = false;
		errorCompletionDate = false;
		
		checkName();
		checkProject();
		checkAssignDate();
		checkCompletionDate();
		
		if (errorName && errorProjectName && errorCompletionDate && errorAssignDate){
			return true;
		}
		return false;
		
	});
	
	
});
	
		

