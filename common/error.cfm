<cf_headerFooter>
		<!--- Import external style sheet --->
		<link rel="stylesheet" type="text/css" href="../assets/css/error.css">
	</head>
	<body>


		<div class="error">
			<h1 class="text-center">
				<span class="text-danger">O</span>
				<span class="text-warning">O</span>
				<span class="text-success">P</span>
				<span class="text-primary">S</span>
			</h1>
			<p class="text-center text-warning">some error occoured</p>
			<button class="btn btn-success" id="home">Go Back to Home</button>
		</div>

		<script type="text/javascript">
			$(document).ready(function(){
				$("#home").click(function(){
					window.location.href = "../index.cfm";
				});
			});
		</script>

</cf_headerFooter>