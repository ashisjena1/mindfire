$(document).ready(function(){
	function checkGoal(goal){
		if(goal.trim().length == 0)
		{
			return true;
		}
		return false;
	}

	
	$("#addGoal").click(function(){
		var id = $("#empId").val();
		var goal =	$("#goal").val();
		
		/*var goals = $("#goalOfTheDay").html();
		goals = goals.replace("</tbody>","");
		
		
		goals = goals + "<tr><td>" + goal + "</td></tr></tbody>";
		
		$("#goalOfTheDay").html(goals);*/

		if(checkGoal(goal)){
			alert();
		}else{
			$.ajax({
			type:"post",
			url:"../components/employeeService.cfc?method=addGoal",
			data:{
			employeeId : id,
			goal : goal
			},
			datatype :"json",
			success : function (res) {
			var resp = $.parseJSON(res);
			if(resp) {
				console.log(resp);
			}else{
				alert("This goal is already added");
			}
			}
		});
		}*/
	});

	
	/*$("#goalForm").click(function(){
		
		else{
			
		}
		
		
	});*/
		
        /*$.ajax({
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
				skills = skills + "<span class='btn'>" + selectedSkill + "</span>"
				$("#skillHistory").html(skills);
				message.removeClass('text-danger');
				message.addClass('text-success');
				message.html(" Skill added sucessfully")
			}else {
				message.addClass('text-danger');
				message.html(" Skill was already added")
			}
			}
		});*/
	/*goalForm.submit(function(){
		checkGoal()
	});*/
});