<cfparam name="VARIABLES.isPersonalDetailsUpdated" default="false">
<cfoutput>
	<cfif VARIABLES.isPersonalDetailsUpdated>
		<p class="text-success" id="successMessage">Updated sucessfully</p>
	</cfif>
	  <div class="panel panel-info">
		<div class="panel-heading">
		  <h3 class="panel-title">#personalDetails.firstName# #personalDetails.middleName# #personalDetails.lastName#</h3>
		</div><!--- End panel heading --->
		<div class="panel-body">
			<cfform id="updateProfile">
				<table class="table table-user-information">
					<tbody>
					  <tr>
						<td>Department:</td>
						<td>#personalDetails.departmentName#</td>
					  </tr>
					  <tr>
						<td>Role Of The Employee:</td>
						<td>#personalDetails.roleName#</td>
					  </tr>
					  <tr>
						<td>Joining Date:</td>
						<td>#DATEFORMAT(personalDetails.joiningDate,"mmm-dd-yyyy")#</td>
					  </tr>
					  <tr>
						<td>Date of Birth</td>
						<td>
							<span id="dob">#DATEFORMAT(personalDetails.dateOfBirth,"mmm-dd-yyyy")#</span>
							<span id="editDob">
								<input type="date" id="dateOfBirthInput" name="dateOfBirth" class="form-control" value="#DATEFORMAT(personalDetails.dateOfBirth,"yyyy-MM-dd")#">
							</span>
							<span id="dobError" class="text-danger">#VARIABLES.updatePersonalDetailsErrorMessage.dob#</span>
						</td>
					  </tr>
					  <tr>
						<td>Gender</td>
						<td>
							<span id="gender">#personalDetails.gender#</span>
							<input type="hidden" id="genderHidden" value="#personalDetails.gender#">
							<span id="editGender">
								<div class="form-group">
									<div class="row">
										<div class="col-sm-4">
											<label class="radio-inline">
												<input type="radio" name="gender" value="f" id="female">Female
											</label>
										</div>
										<div class="col-sm-4">
											<label class="radio-inline">
												<input type="radio" name="gender" value="m" id="male">Male
											</label>
										</div>
										<div class="col-sm-4">
											<label class="radio-inline">
												<input type="radio" name="gender" value="o" id="other">Other
											</label>
										</div>
									</div>
								</div>
							</span>
						</td>
					  </tr>
					  <tr>
						<td>Email</td>
						<td>#personalDetails.email#</td>
					  </tr>
					  <tr>
						<td>Phone Number</td>
						<td>
							<span id="phoneNumber">#personalDetails.phoneNumber#</span>
							<span id="editPhoneNumber">
								<input type="number" id="phoneNumberInput" name="phoneNumber" class="form-control" value="#personalDetails.phoneNumber#">
							</span>
							<span id="phoneNumberError" class="text-danger">#VARIABLES.updatePersonalDetailsErrorMessage.phoneNumber#</span>
						</td>
					  </tr>
					  <tr>
						<td>Basic Salary</td>
						<td>#personalDetails.basicSalary#</td>
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
	<input type="button" value="Edit details" class="btn btn-primary" id="edit">
</cfoutput>