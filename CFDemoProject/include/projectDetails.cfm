
<cfoutput>
	<div class="card">
		<div class="panel">
			<div class="row">
				<div class="col-md-4"></div>
				<div class="col-md-4"><h3>Project Details</h3></div>
				<div class="col-md-4"></div>
			</div><!--- End row --->
			<div class="row">
				<div class="panel-info panel-body">
					<table class="table table-responsive">
						<thead>
							<tr>
								<th class="col-md-4">ProjectName</th>
								<th class="col-md-4">Manager</th>
								<th class="col-md-2">Start Date</th>
								<th class="col-md-2">Finish Date</th>
							</tr>
						</thead>
						<tbody>
							<!--- loop over employee project --->
							<cfloop query="employeeProjectDetails">
								<tr>
									<td class="col-md-4">#employeeProjectDetails.projectName#</td>
									<td class="col-md-4">#employeeProjectDetails.manager#</td>
									<td class="col-md-2">#employeeProjectDetails.projectJoinDate#</td>
									<td class="col-md-2">#employeeProjectDetails.projectFinishDate#</td>
								</tr>
							</cfloop><!--- End cfloop --->
						</tbody>
					</table><!--- End table --->
				</div><!--- End panel-info panel-body --->
			</div><!--- End row --->
		</div><!--- End panel --->
	</div><!--- End card --->
</cfoutput>