<!DOCTYPE html>
<html>
<head>
<title>show</title>
<link rel="stylesheet" href="static/css/reset.css" type="text/css" />
<link rel="stylesheet" href="static/css/style.css" type="text/css" />
<script src="static/js/modernizr.js"></script>
</head>
<body>

<a href="/showcart" class="cd-cart">
	<span>0</span>
</a>

<ul class="cd-gallery">
	<li>
		<div class="cd-single-item">
			<a href="#0">


					<img src="static/img/thumb-2.jpg" alt="Preview image">


			</a>
			<div class="cd-customization">
				<button class="add-to-cart" onclick="add(1);">
					<em>Add to Cart</em>
					<svg x="0px" y="0px" width="32px" height="32px" viewBox="0 0 32 32">
						<path stroke-dasharray="19.79 19.79" stroke-dashoffset="19.79" fill="none" stroke="#FFFFFF" stroke-width="2" stroke-linecap="square" stroke-miterlimit="10" d="M9,17l3.9,3.9c0.1,0.1,0.2,0.1,0.3,0L23,11"/>
					</svg>
				</button>
			</div> <!-- .cd-customization -->

			<button class="cd-customization-trigger">Customize</button>
		</div> <!-- .cd-single-item -->

    <div class="cd-item-info">
			<b>Red-----数量：</b>
      <input id="id_num1" type="number" min="0" step="1" value="1" width="35px">
			<em>$50</em>
		</div> <!-- cd-item-info -->
	</li>

	<li>
		<div class="cd-single-item">
			<a href="#0">
			<img src="static/img/thumb-1.jpg" alt="Preview image">

			</a>

			<div class="cd-customization">
				<button class="add-to-cart" onclick="add(2);">
					<em>Add to Cart</em>
					<svg x="0px" y="0px" width="32px" height="32px" viewBox="0 0 32 32">
						<path stroke-dasharray="19.79 19.79" stroke-dashoffset="19.79" fill="none" stroke="#FFFFFF" stroke-width="2" stroke-linecap="square" stroke-miterlimit="10" d="M9,17l3.9,3.9c0.1,0.1,0.2,0.1,0.3,0L23,11"/>
					</svg>
				</button>
			</div> <!-- .cd-customization -->

			<button class="cd-customization-trigger">Customize</button>
		</div> <!-- .cd-single-item -->

    <div class="cd-item-info">
			<b>Black-----数量：</b>
      <input id="id_num2" type="number" min="0" step="1" value="1" width="35px">
			<em>$20</em>
		</div> <!-- cd-item-info -->
	</li>

	<li>
		<div class="cd-single-item">
			<a href="#0">
        <img src="static/img/thumb-3.jpg" alt="Preview image">
			</a>

			<div class="cd-customization">
				<button class="add-to-cart" onclick="add(3);">
					<em>Add to Cart</em>
					<svg x="0px" y="0px" width="32px" height="32px" viewBox="0 0 32 32">
						<path stroke-dasharray="19.79 19.79" stroke-dashoffset="19.79" fill="none" stroke="#FFFFFF" stroke-width="2" stroke-linecap="square" stroke-miterlimit="10" d="M9,17l3.9,3.9c0.1,0.1,0.2,0.1,0.3,0L23,11"/>
					</svg>
				</button>
			</div> <!-- .cd-customization -->

			<button class="cd-customization-trigger">Customize</button>
		</div> <!-- .cd-single-item -->

		<div class="cd-item-info">
			<b>Yellow-----数量：</b>
      <input id="id_num3" type="number" min="0" step="1" value="1" width="35px">
			<em>$10</em>
		</div> <!-- cd-item-info -->
	</li>
</ul> <!-- cd-gallery -->
<p></p>
<script type="text/javascript" src="static/js/jquery-2.1.4.js"></script>
<script type="text/javascript" src="static/js/main.js"></script>

</body>
<script>
function add(pid)
{
  var num = $("#id_num"+pid).val();
  //alert(num);
  $.ajax({
						 type: "post",
             //async: false,
						 url: "/additem",
             data:{p:pid,n:num},
             dataType: "json",
             //contentType: "application/json; charset=utf-8",
						 success: function(data){
					   if(data){
											 //$("#id_span").text(data.name);
											 alert(data.status);
									 } else{
											//	alert('失败');
									 }
											}
				 });
}

</script>
</html>
