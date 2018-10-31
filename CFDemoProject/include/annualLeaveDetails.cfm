
<cfoutput>
	<div class="card">
		<div class="panel">
			<div class="row">
				<div class="col-md-1"></div>
				<div class="col-md-10"><h4>Leave Balance of the employee</h4></div>
				<div class="col-md-1"></div>
			</div>
			<div class="row">
				<div class="panel-info panel-body">
					<table class="table table-responsive">
						<thead>
							<tr>
							<th>Total Leave Assigned</th>
							<th>Total Leave Taken</th>
							<th>Total Remaining leave</th>
							</tr>
						</thead>
						<tbody>
						<!--- loop over leave details --->
						<cfloop query="VARIABLES.leaveDetails">
							<tr>
								<td>#VARIABLES.leaveDetails.totalLeaveAssigned#</td>
								<td>#VARIABLES.leaveDetails.totalLeaveTaken#</td>
								<td>#VARIABLES.leaveDetails.totalRemainingLeave#</td>
							</tr>
						</cfloop>
						</tbody>
					</table><!--- End table --->
				</div><!--- End panel info --->
			</div><!--- End row --->
		</div><!--- End panel --->
	</div><!--- End card --->
</cfoutput>

