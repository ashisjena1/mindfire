
<cfoutput>
	<p id = "message"></p>
	<div class="card">
		<div class="panel">
			<div class="row">
				<div class="col-md-1"></div>
				<div class="col-md-10"><h4>Skills of the employee</h4></div>
				<div class="col-md-1"></div>
			</div><!--- End row --->

			<div class="panel-body" id = "skillHistory">
				<!--- loop over employee personal skills --->
				<cfloop query="VARIABLES.skillDetails">
						<span class="btn">#VARIABLES.skillDetails.skillName#</span>
				</cfloop>
			</div><!--- End panel info --->
		</div><!--- End panel --->
	</div><!--- End card --->
	<cfif not structKeyExists(URL,'id')>
	<div class="row">
		<cfform>
			<div class="form-group">
				<div class="col-md-4"><label class="form-label">Add skills</label></div>
				<div class="col-md-5">
					<input type = "hidden" id = "id" value = "#SESSION.setLoggedInUser.empId#">
					<select class="form-control" name = "newSkill" id = "skills">
						<!--- loop over skills --->
						<cfloop query="VARIABLES.skills">
							<option value="#VARIABLES.skills.skillId#">#VARIABLES.skills.skillName#</option>
						</cfloop>
					</select>
				</div><!--- End column --->
				<div class="col-md-3"><input type="button" id = "addSkill" value="Add Skills" class="btn btn-primary" name="addSkill"></div>
			</div>
		</cfform>
	</div><!--- End row --->
	</cfif>
</cfoutput>