
<!--- Fetch pall skills from skill table --->
<cfset skills = APPLICATION.personalService.getSkills()/>
<cfparam name="VARIABLES.isSkillAdded" default="false"/>
<cfoutput>
	<cfif VARIABLES.isSkillAdded>
					<div class="col-md-4"><span class="text-success text-center">Skill Added sucessfully</span></div>
				<cfelse>
					<div class="col-md-4"><span class="text-danger text-center">Skill was already added </span></div>
				</cfif>
	<div class="card">
		<div class="panel">
			<div class="row">
				<div class="col-md-1"></div>
				<div class="col-md-10"><h4>Skills of the employee</h4></div>
				<div class="col-md-1"></div>
			</div><!--- End row --->

			<div class="panel-body">
				<!--- loop over employee personal skills --->
				<cfloop query="skillDetails">
						<span class="btn">#skillDetails.skillName#</span>
				</cfloop>
			</div><!--- End panel info --->
		</div><!--- End panel --->
	</div><!--- End card --->

	<div class="row">
		<cfform>
			<div class="form-group">
				<div class="col-md-4"><label class="form-label">Add skills</label></div>
				<div class="col-md-5">

					<select class="form-control" name = "newSkill">
						<!--- loop over skills --->
						<cfloop query="skills">
							<option value="#skills.skillId#">#skills.skillName#</option>
						</cfloop>
					</select>
				</div><!--- End column --->
				<div class="col-md-3"><input type="submit" value="Add Skills" class="btn btn-primary" name="addSkill"></div>

			</div>
		</cfform>
	</div><!--- End row --->
</cfoutput>