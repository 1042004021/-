<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
	<title>去你想去的地方</title>
	<link rel="stylesheet" href="css/page1.css" />
	<link rel="stylesheet" href="css/bootstrap.min.css"/>
</head>
<style>
	
</style>
<body>
	<div class="back">
		<img width="50%" src="image/db.png" alt="">
		<div>即刻启航</div>
	</div>
	<div class="div1">
		<div class="bg1">
			<div class="cheng"></div>
			<div class="p1">
				<div class="title">西湖</div>
				<div class="p2">西湖有100多处公园景点，包括三秋桂子、六桥烟柳、九里云松、十里荷花景观、有“西湖十景”、“新西湖十景”、“三评西湖十景”之说，有60多处国家、省、市级重点文物保护单位和20多座博物馆。</div>
			</div>
		</div>
	</div>
	<div class="div2">
		<div class="bg2">
			<div class="cheng"></div>
			<div class="p1">
				<div class="title2">布达拉宫</div>
				<div class="p3">布达拉宫依山垒砌，群楼重叠，是藏式古建筑的杰出代表（据说源于桑珠孜宗堡），中华民族古建筑的精华之作，是第五套人民币50元纸币背面的风景图案 。主体建筑分为白宫和红宫两部分。宫殿高200余米，外观13层，内为9层。布达拉宫前辟有布达拉宫广场，是世界上海拔最高的城市广场。</div>
			</div>
		</div>
	</div>
	<div class="div3">
		<div class="bg3">
			<div class="cheng"></div>
			<div class="p1">
				<div class="title3">丽江</div>
				<div class="p4">丽江市位于云贵高原与青藏高原的连接部位，地势西北高而东南低，最高点为玉龙雪山主峰，海拔一般都在2000米以上，属低纬暖温带高原山地季风气候，境内水利资源丰富，动植物种类繁多，为云南省重点林区、中国水电西电东送基地之一。</div>
			</div>
		</div>
	</div>
	<div class="div4">
		<div class="bg4">
			<div class="cheng"></div>
			<div class="p1">
				<div class="title4">黄山</div>
				<div class="p5">黄山位于安徽省南部黄山市境内，有72峰，主峰莲花峰海拔1864米，与光明顶、天都峰并称三大黄山主峰，为36大峰之一。黄山是安徽旅游的标志，是中国十大风景名胜唯一的山岳风光。</div>
			</div>
		</div>
	</div>
</body>
	<script  class="autoinsert" src="js/jquery-3.4.1.min.js"></script>
	<script>
		$(document).ready(function () {
			$(".back").click(function(){
				window.location.href="page2.jsp";
			});
			//图一
			$(".bg1").hover(function(){
				$(".bg1").css("margin-top","0");
				$(".bg1").css("margin-left","0");
				$(".bg1").css("width","100%");
				$(".title").css("padding-top","0px");
				$(".p2").css("opacity","1");
			},function(){
				$(".bg1").css("margin-top","10%");
				$(".bg1").css("margin-left","20%");
				$(".bg1").css("width","60%");
				$(".title").css("padding-top","20%");
				$(".p2").css("height","0");
				$(".p2").css("opacity","0");
				
			})
			//图二
			$(".bg2").hover(function(){
				$(".bg2").css("margin-top","0");
				$(".bg2").css("margin-left","0");
				$(".bg2").css("width","100%");
				$(".title2").css("padding-top","0px");
				$(".p3").css("opacity","1");
			},function(){
				$(".bg2").css("margin-top","10%");
				$(".bg2").css("margin-left","20%");
				$(".bg2").css("width","60%");
				$(".title2").css("padding-top","20%");
				$(".p3").css("opacity","0");
				
			})
			//图三
			$(".bg3").hover(function(){
				$(".bg3").css("margin-top","0");
				$(".bg3").css("margin-left","0");
				$(".bg3").css("width","100%");
				$(".title3").css("padding-top","0px");
				$(".p4").css("opacity","1");
			},function(){
				$(".bg3").css("margin-top","10%");
				$(".bg3").css("margin-left","20%");
				$(".bg3").css("width","60%");
				$(".title3").css("padding-top","20%");
				$(".p4").css("height","0");
				$(".p4").css("opacity","0");
				
			})
			//图四
			$(".bg4").hover(function(){
				$(".bg4").css("margin-top","0");
				$(".bg4").css("margin-left","0");
				$(".bg4").css("width","100%");
				$(".title4").css("padding-top","0px");
				$(".p5").css("opacity","1");
			},function(){
				$(".bg4").css("margin-top","10%");
				$(".bg4").css("margin-left","20%");
				$(".bg4").css("width","60%");
				$(".title4").css("padding-top","20%");
				$(".p5").css("height","0");
				$(".p5").css("opacity","0");
				
			})
		});
		
	</script>
</html>
