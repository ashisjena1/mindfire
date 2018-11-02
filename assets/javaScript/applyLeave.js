
$(document).ready(function() {
	var fromDateError = $("#fromDateError");
	var toDateError = $("#toDateError");
	var totalDaysError = $("#totalDaysError");
	var reasonError = $("#reasonError");
	
	
	var fromDate = $("#fromDate");
	var toDate = $("#toDate");
	var totalDays = $("#totalDays");
	var reason = $("#reason");
	var applyLeave = $("#applyLeave");
	
	
	var errorFromDate;
	var errorToDate;
	var errorTotalDays;
	var errorReason;
	
	fromDate.focusout(function(){
		checkFromDate();
	});
	toDate.focusout(function(){
		checkToDate();
	});
	totalDays.focusout(function(){
		checkNumberOfDays();
	});
	reason.focusout(function(){
		checkReason();
	});
	
	
	function checkFromDate(){
		if(fromDate.val().length===0){
			fromDateError.html("Leave From Date should not be empty");
		}else if(fromDate.val()){
			var date=new Date(fromDate.val());
			var today=new Date();
			today.setHours(0,0,0,0);
			if(date < today){
				fromDateError.html("Leave from date can not be previous date");
			} else {
				fromDateError.html("");
				errorFromDate=true;
			}
		}
	}
	
	function checkToDate(){	
		if(toDate.val().length===0){
			toDateError.html("Leave To Date should not be empty");
		}else if(toDate.val()){
			var fDate=new Date(fromDate.val());
			var tDate=new Date(toDate.val());
			
			//today.setHours(0,0,0,0);
			if(tDate < fDate){
				toDateError.html("Leave to date may be same or after date of Leave from date");
			} else {
				toDateError.html("");
				errorToDate=true;
			}
		}
	}
	
	function checkNumberOfDays(){
		var startDay = new Date(fromDate.val());
        var endDay = new Date(toDate.val());
        var millisecondsPerDay = 1000 * 60 * 60 * 24;
		var millisBetween = endDay.getTime() - startDay.getTime();
		var days = Math.floor(millisBetween / millisecondsPerDay) + 1;
  
        if(days){
			if (totalDays.val().length === 0) {
				totalDaysError.html('Total number of days should not be empty or does not contain character e');
			} else if (totalDays.val() != days){
				totalDaysError.html('please enter number of days correctly');
			} else {
				totalDaysError.html("");
				errorTotalDays=true;
			}
		}else{
			totalDaysError.html('Please select both the date first');
		}
	}
	
	function checkReason(){
		if (reason.val().length === 0) {
			reasonError.html('Reason should not be empty');
		} else {
			reasonError.html("");
			errorReason=true;
		}
	}
	
		
	applyLeave.submit(function(){
		
		errorFromDate = false;
		errorToDate = false;
		errorTotalDays = false;
		errorReason = false;
		
		checkFromDate();
		checkToDate();
		checkNumberOfDays();
		checkReason();
		
		if (errorFromDate && errorToDate && errorTotalDays && errorReason){
			return true;
		}
		return false;
		
	});
	
	
});
	
		

