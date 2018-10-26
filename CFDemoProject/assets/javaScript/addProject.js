$(function(){
	
	var projectNameError=$("#projectNameError");
	var projectManagerError=$("#projectManagerError");
	var projectStartDateError=$("#projectStartDateError");
	var projectEndDateError=$("#projectEndDateError");
	
	var projectName=$("#projectName");
	var managerName=$("#managerName");
	var startDate=$("#startDate");
	var endDate=$("#endDate");
	var addProject=$("#addProject");
	
	var errorProjectName;
	var errorManagerName;
	var errorStartDate;
	var errorEndDate;
	
	projectName.focusout(function(){
		errorProjectName=false;
		checkProjectName();
	});
	managerName.focusout(function(){
		errorManagerName=false;
		checkManagerName();
	});
	startDate.focusout(function(){
		errorStartDate=false;
		checkStartDate();
	});
	endDate.focusout(function(){
		errorEndDate=false;
		checkEndDate();
	});
	
	function error(message,displayError){
		displayError.html(message);
	}
	function noError(displayError){
		displayError.html("");
	}
	
	function checkProjectName(){
		if (projectName.val().length === 0) {
			error('Project name should not be empty',projectNameError);
		} else if (!(/.{5,50}/).test(projectName.val())){
			error('Project name should be more than 5 characters and less than 50 character',projectNameError);
		} else {
			noError(projectNameError);
			errorProjectName=true;
		}
	}
	
	function checkManagerName(){
		if (managerName.val() == "") {
			error('please select the Manager Name',projectManagerError);
		} else {
			noError(projectManagerError);
			errorManagerName=true;
		}	
	}
	
	function checkStartDate(){
		if(startDate.val().length===0){
			error("Project Start Date should not be empty",projectStartDateError);
		}else if(startDate.val()){
			var date=new Date(startDate.val());
			var today=new Date();
			//today.setHours(0,0,0,0);
			if(date < today){
				error("Project start date can not be previous date",projectStartDateError);
			} else {
				noError(projectStartDateError);
				errorStartDate=true;
			}
		}
	}
	
	function checkEndDate(){
		if(endDate.val().length===0){
			error("Project End Date should not be empty",projectEndDateError);
		}else if(endDate.val()){
			var projectStartDate=new Date(startDate.val());
			//projectEndDate.setHours(0,0,0,0);
			var projectEndDate=new Date(endDate.val());
			
			if(projectEndDate < projectStartDate){
				error("Project End date can not be after project Start Date",projectEndDateError);
			} else {
				noError(projectEndDateError);
				errorEndDate=true;
			}
		}
	}
	
	addProject.submit(function(){
		errorProjectName = false;
		errorManagerName = false;
		errorStartDate = false;
		errorEndDate = false;
	
		checkProjectName();
		checkManagerName();
		checkStartDate();
		checkEndDate();
		
		if(errorProjectName && errorManagerName && errorStartDate && errorEndDate){
			
			return true;
		}
		return false;
	});
	
});