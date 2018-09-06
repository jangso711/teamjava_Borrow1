<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="robots" content="noindex, nofollow">

<title>Fancy tabs non-responsive - Bootsnipp.com</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<link href="${pageContext.request.contextPath }/template/fancytab/css/fancytab.css" rel="stylesheet">
<link rel="stylesheet"
	href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" />
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script
	src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script type="text/javascript">
	window.alert = function() {
	};
	var defaultCSS = document.getElementById('bootstrap-css');
	function changeCSS(css) {
		if (css)
			$('head > link')
					.filter(':first')
					.replaceWith(
							'<link rel="stylesheet" href="'+ css +'" type="text/css" />');
		else
			$('head > link').filter(':first').replaceWith(defaultCSS);
	}
	$(document).ready(function() {
		var iframe_height = parseInt($('html').height());
		window.parent.postMessage(iframe_height, 'https://bootsnipp.com');
	});
</script>
</head>
<body>
<head>
</head>
<div class="container text-center">
	<div class="row">
		<div class="col-md-6 col-md-offset-3" role="tabpanel">
			<!-- Nav tabs -->
			<ul class="nav nav-justified" id="nav-tabs" role="tablist">
				<li role="presentation" class="active"><a href="#dustin"
					aria-controls="dustin" role="tab" data-toggle="tab"> <img
						class="img-circle"
						src="https://s3.amazonaws.com/uifaces/faces/twitter/dustinlamont/128.jpg" />
						<span class="quote"><i class="fa fa-quote-left"></i></span>
				</a></li>
				<li role="presentation"><a href="#daksh" aria-controls="daksh"
					role="tab" data-toggle="tab"> <img class="img-circle"
						src="https://s3.amazonaws.com/uifaces/faces/twitter/dakshbhagya/128.jpg" />
						<span class="quote"><i class="fa fa-quote-left"></i></span>
				</a></li>
<!-- 				<li role="presentation"><a href="#anna" aria-controls="anna"
					role="tab" data-toggle="tab"> <img class="img-circle"
						src="https://s3.amazonaws.com/uifaces/faces/twitter/annapickard/128.jpg" />
						<span class="quote"><i class="fa fa-quote-left"></i></span>
				</a></li>
				<li role="presentation"><a href="#wafer" aria-controls="wafer"
					role="tab" data-toggle="tab"> <img class="img-circle"
						src="https://s3.amazonaws.com/uifaces/faces/twitter/waferbaby/128.jpg" />
						<span class="quote"><i class="fa fa-quote-left"></i></span>
				</a></li> -->
			</ul>

			<!-- Tab panes -->
			<div class="tab-content" id="tabs-collapse">
				<div role="tabpanel" class="tab-pane fade in active" id="dustin">
					<div class="tab-inner">
						<p class="lead">Etiam tincidunt enim et pretium efficitur.
							Donec auctor leo sollicitudin eros iaculis sollicitudin.</p>
						<hr>
						<p>
							<strong class="text-uppercase">Dustin Lamont</strong>
						</p>
						<p>
							<em class="text-capitalize"> Senior web developer</em> at <a
								href="#">Apple</a>
						</p>
					</div>
				</div>
				<div role="tabpanel" class="tab-pane fade" id="daksh">
					<div class="tab-inner">
						<p class="lead">Suspendisse dictum gravida est, nec consequat
							tortor venenatis a. Suspendisse vitae venenatis sapien.</p>
						<hr>
						<p>
							<strong class="text-uppercase">Daksh Bhagya</strong>
						</p>
						<p>
							<em class="text-capitalize"> UX designer</em> at <a href="#">Google</a>
						</p>
					</div>
				</div>
<!-- 				<div role="tabpanel" class="tab-pane fade" id="anna">
					<div class="tab-inner">
						<p class="lead">Nullam suscipit ante ac arcu placerat, nec
							sagittis quam volutpat. Vestibulum aliquam facilisis velit ut
							ultrices.</p>
						<hr>
						<p>
							<strong class="text-uppercase">Anna Pickard</strong>
						</p>
						<p>
							<em class="text-capitalize"> Master web developer</em> at <a
								href="#">Intel</a>
						</p>
					</div>
				</div> -->
<!-- 				<div role="tabpanel" class="tab-pane fade" id="wafer">
					<div class="tab-inner">
						<p class="lead">Fusce erat libero, fermentum quis sollicitudin
							id, venenatis nec felis. Morbi sollicitudin gravida finibus.</p>
						<hr>
						<p>
							<strong class="text-uppercase">Wafer Baby</strong>
						</p>
						<p>
							<em class="text-capitalize"> Web designer</em> at <a href="#">Microsoft</a>
						</p>
					</div>
				</div> -->
			</div>

		</div>
	</div>
</div>
<script type="text/javascript">
	
</script>
</body>
</html>
