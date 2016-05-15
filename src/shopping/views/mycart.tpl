<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>购物车</title>

<link href="static/css/index.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="static/js/jquery.1.4.2-min.js"></script>
<script type="text/javascript" src="static/js/Calculation.js"></script>
<script type="text/javascript">
$(document).ready(function () {

	//jquery特效制作复选框全选反选取消(无插件)
	// 全选
	$(".allselect").click(function () {
		$(".gwc_tb2 input[name=newslist]").each(function () {
			$(this).attr("checked", true);
			// $(this).next().css({ "background-color": "#3366cc", "color": "#ffffff" });
		});
		GetCount();
	});

	//反选
	$("#invert").click(function () {
		$(".gwc_tb2 input[name=newslist]").each(function () {
			if ($(this).attr("checked")) {
				$(this).attr("checked", false);
				//$(this).next().css({ "background-color": "#ffffff", "color": "#000000" });
			} else {
				$(this).attr("checked", true);
				//$(this).next().css({ "background-color": "#3366cc", "color": "#000000" });
			}
		});
		GetCount();
	});

	//取消
	$("#cancel").click(function () {
		$(".gwc_tb2 input[name=newslist]").each(function () {
			$(this).attr("checked", false);
			// $(this).next().css({ "background-color": "#ffffff", "color": "#000000" });
		});
		GetCount();
	});

	// 所有复选(:checkbox)框点击事件
	$(".gwc_tb2 input[name=newslist]").click(function () {
		if ($(this).attr("checked")) {
			//$(this).next().css({ "background-color": "#3366cc", "color": "#ffffff" });
		} else {
			// $(this).next().css({ "background-color": "#ffffff", "color": "#000000" });
		}
	});

	// 输出
	$(".gwc_tb2 input[name=newslist]").click(function () {
		// $("#total2").html() = GetCount($(this));
		GetCount();
		//alert(conts);
	});
});
//******************
function GetCount() {
	var conts = 0;
	var aa = 0;
	$(".gwc_tb2 input[name=newslist]").each(function () {
		if ($(this).attr("checked")) {
			for (var i = 0; i < $(this).length; i++) {
				conts += parseInt($(this).val());
				aa += 1;
			}
		}
	});
	$("#shuliang").text(aa);
	$("#zong1").html((conts).toFixed(2));
	$("#jz1").css("display", "none");
	$("#jz2").css("display", "block");
}
</script>


</head>
<body>

<div class="gwc" style=" margin:auto;">
	<table cellpadding="0" cellspacing="0" class="gwc_tb1">
		<tr>
			<td class="tb1_td1"><input id="Checkbox1" type="checkbox"  class="allselect"/></td>
			<td class="tb1_td1">全选</td>
			<td class="tb1_td3">产品名称</td>
			<td class="tb1_td4">备注信息</td>
			<td class="tb1_td5">数量</td>
			<td class="tb1_td6">价格</td>
			<td class="tb1_td7">操作</td>
		</tr>
	</table>

	<!---商品加减算总数---->
	<script type="text/javascript">


		/*$("#add1").click(function () {
			t.val(parseInt(t.val()) + 1)
			setTotal(); GetCount();
		})
		$("#min1").click(function () {
			t.val(parseInt(t.val()) - 1)
			setTotal(); GetCount();
		})*/
		function setTotal(id,price) {
      var t = $("#text_box"+id);
			$("#price"+id).html((parseInt(t.val()) * price).toFixed(2));
			$("#newslist"+id).val(parseInt(t.val()) * price);
		}

    function setmin(id,price){
      var t = $("#text_box"+id);
      t.val(parseInt(t.val()) - 1)
      addmin(id,t.val())
			setTotal(id,price); GetCount();
    }
    function setadd(id,price){
      var t = $("#text_box"+id);
      t.val(parseInt(t.val()) + 1)
      addmin(id,t.val())
      setTotal(id,price); GetCount();
    }
		//setTotalini();



	</script>
  {{range $k,$v :=.list}}
	<table cellpadding="0" cellspacing="0" class="gwc_tb2">
		<tr>
			<td class="tb2_td1"><input type="checkbox" value="{{.total}}" name="newslist" id="newslist{{.itemid}}" /></td>
			<td class="tb2_td2"><a href="#"><img src="static/img/{{.img}}"/></a></td>
			<td class="tb2_td3"><a href="#">{{.proname}}</a></td>
			<td class="tb1_td4">{{.proname}}</td>
			<td class="tb1_td5">
				<input id="min{{.itemid}}" name=""  style=" width:20px; height:18px;border:1px solid #ccc;" type="button" value="-" onclick="setmin({{.itemid}},{{.price}});" />
				<input id="text_box{{.itemid}}" name="" type="text" value="{{.num}}" style=" width:30px; text-align:center; border:1px solid #ccc;" />
				<input id="add{{.itemid}}" name="" style=" width:20px; height:18px;border:1px solid #ccc;" type="button" value="+" onclick="setadd({{.itemid}},{{.price}});" />
			</td>
			<td class="tb1_td6"><label id="price{{.itemid}}" class="tot" style="color:#ff5500;font-size:14px; font-weight:bold;">{{.total}}</label></td>
			<td class="tb1_td7"><a href="javascript:void(0)" onclick="deleteitem({{.itemid}})">删除</a></td>
		</tr>
	</table>
{{end}}
	<table cellpadding="0" cellspacing="0" class="gwc_tb3">
		<tr>
			<td class="tb1_td1"><input id="checkAll" class="allselect" type="checkbox" /></td>
			<td class="tb1_td1">全选</td>
			<td class="tb3_td1">
				<input id="invert" type="checkbox" />反选
				<input id="cancel" type="checkbox" />取消
			</td>
			<td class="tb3_td2">已选商品 <label id="shuliang" style="color:#ff5500;font-size:14px; font-weight:bold;">0</label> 件</td>
			<td class="tb3_td3">合计(不含运费):<span>￥</span><span style=" color:#ff5500;"><label id="zong1" style="color:#ff5500;font-size:14px; font-weight:bold;"></label></span></td>
			<td class="tb3_td4"><span id="jz1">结算</span><a href="#" style=" display:none;"  class="jz2" id="jz2" onclick="pay();">结算</a></td>
		</tr>
	</table>

</div>

</body>

<script>
function addmin(itid,num)
{
  //var num = $("#id_num"+pid).val();
  //alert(num);
  $.ajax({
						 type: "post",
             //async: false,
						 url: "/addmin",
             data:{p:itid,n:num},
             dataType: "json",
             //contentType: "application/json; charset=utf-8",
						 success: function(data){
					   if(data){
											 alert(data.status);//测试
									 } else{
											//	alert('失败');
									 }
											}
				 });
}

function deleteitem(itid)
{
  //var num = $("#id_num"+pid).val();
  //alert(num);
  $.ajax({
						 type: "post",
             //async: false,
						 url: "/deleteitem",
             data:{p:itid},
             dataType: "json",
             //contentType: "application/json; charset=utf-8",
						 success: function(data){
					   if(data){
											 alert(data.status);//测试
									 } else{
											//	alert('失败');
									 }
											}
				 });
   location.reload();
}

function pay()
{

  var ids =[];
  $(".gwc_tb2 input[name=newslist]").each(function () {
		if ($(this).attr("checked")) {
			for (var i = 0; i < $(this).length; i++) {
				//ids.push($(this).attr('id').substring(8)); 取不到值，再改进
        //ids += ","+$(this).attr('id').substring(8);
        ids.push($(this).attr('id').substring(8));
        //var arr = []
				//aa += 1;
			}
		}
	});
  //alert(ids);
  var tot = $("#zong1").html();
  //ids= ["1","2","3"];
  $.ajax({
						 type: "post",
             //async: false,
             traditional :true,
						 url: "/order",
             data:{'ids':ids,'totp':tot},
             dataType: "json",
             //contentType: "application/json; charset=utf-8",
						 success: function(data){
					   if(data){
											 alert(data.status);//测试
									 } else{
											//	alert('失败');
									 }
											}
				 });

  location.reload();
}

</script>
</html>
