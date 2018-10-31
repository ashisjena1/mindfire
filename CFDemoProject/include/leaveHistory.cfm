
<cfoutput>
	<div class="card">
		<div class="panel">
			<div class="row">
				<div class="col-md-4"></div>
				<div class="col-md-4"><h3>Leave history</h3></div>
				<div class="col-md-4"></div>
			</div><!--- End row --->
			<div class="row">
				<div class="panel-info panel-body">
					<table class="table table-responsive">
						<thead>
							<tr>
								<th class="col-md-7">Reason</th>
								<th class="col-md-4">Duration</th>
								<th class="col-md-1">Number of Days</th>
							</tr>
						</thead>
						<tbody>
						<cfloop query="VARIABLES.leaveTakenDetails">
							<!--- loop over leaveTakenDetails --->
							<tr>
								<td class="col-md-7">#VARIABLES.leaveTakenDetails.reason#</td>
								<td class="col-md-4">
									#DATEFORMAT(VARIABLES.leaveTakenDetails.leaveFromDate,"dd/mm/yyyy")# -
									#DATEFORMAT(VARIABLES.leaveTakenDetails.leaveToDate,"dd/mm/yyyy")#</td>
								<td class="col-md-1">#VARIABLES.leaveTakenDetails.totalNumberOfDays#</td>
							</tr>
						</cfloop>
						</tbody>
					</table><!--- End table --->
				</div><!--- End panel-body panel-info --->
			</div><!--- End row --->
		</div><!--- End panel --->
	</div><!--- End card --->
</cfoutput>
