<cfparam name="VARIABLES.isEmployeePersonalDetailsUpdated" default="false">
<cfoutput>
	<cfif VARIABLES.isEmployeePersonalDetailsUpdated>
		<p class="text-success">Updated sucessfully</p>
	</cfif>
	<div class="panel panel-info">
		<div class="panel-heading">
			<h3 class="panel-title">#employeePersonalDetails.firstName# #employeePersonalDetails.middleName# #employeePersonalDetails.lastName#</h3>
		</div><!--- End panel heading --->
		<div class="panel-body">
			<cfform id="updateProfile">
				<table class="table table-user-information">
					<tbody>
					  <tr>
						<td>Department:</td>
						<td>#employeePersonalDetails.departmentName#</td>
					  </tr>
					  <tr>
						 <!--- Fetch roleName from employee role table --->
						<cfset rollName = APPLICATION.personalService.getRollName(#employeePersonalDetails.departmentName#)/>
						<td>Role Of The Employee:</td>
						<td>
							<span id="employeeRole">#employeePersonalDetails.roleName#</span>
							<input type="hidden" id="roleNameHidden">
							<span id="editEmployeeRole">
								<select class="form-control" name="roleId">
									<cfloop query="rollName">
										<cfif #rollName.roleName# EQ #employeePersonalDetails.roleName#>
											<option selected value="#rollName.roleId#">#rollName.roleName#</option>
										<cfelse>
											<option value="#rollName.roleId#">#rollName.roleName#</option>
										</cfif>
									</cfloop>
								</select>
							</span>
						</td>
					  </tr>
					  <tr>
						<td>Joining Date:</td>
						<td>#DATEFORMAT(employeePersonalDetails.joiningDate,"mmm-dd-yyyy")#</td>
					  </tr>
					  <tr>
						<td>Date of Birth</td>
						<td>#DATEFORMAT(employeePersonalDetails.dateOfBirth,"mmm-dd-yyyy")#</td>
					  </tr>
					  <tr>
						<td>Gender</td>
						<td>#employeePersonalDetails.gender#</td>
					  </tr>
					  <tr>
						<td>Email</td>
						<td>#employeePersonalDetails.email#</td>
					  </tr>
					  <tr>
						<td>Phone Number</td>
						<td>#employeePersonalDetails.phoneNumber#</td>
					  </tr>
					  <tr>
						<td>Basic Salary</td>
						<td>
							<span id="basicSalary">#employeePersonalDetails.basicSalary#</span>
							<span id="editBasicSalary">
								<input type="number" id="basicSalrayInput" name="basicSalary" class="form-control" value="#employeePersonalDetails.basicSalary#">
							</span>
							<span id="salaryError" class="text-danger">#VARIABLES.updateEmployeeDetailsErrorMessage.salary#</span>
						</td>
					  </tr>
					</tbody>
				</table>
				<!--- Back Buuton --->
				<input type="button" value="Back" class="btn btn-primary" id="back">
				<!--- Update Buuton --->
				<input type="submit" value="Update Details" class="btn btn-primary pull-right" id="updateDetails" name="updateDetails">
			</cfform><!--- End cfform --->
		</div><!--- End panel body --->
	  </div><!--- End panel --->

	<!--- Edit button --->
	<input type="button" value="Edit details" class="btn btn-primary " id="edit">
</cfoutput>