<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/style.css">
<meta charset="utf-8">
<title>Insert title here</title>
<script src="js/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="js/vector.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		Victor("container", "output"); //登录背景函数
		$("#entry_name").focus();
		$(document).keydown(function(event) {
			if (event.keyCode == 13) {
				$("#entry_btn").click();
			}
		});
		
		
		$(".regist").click(function(){
			window.location.href="register.jsp";
		});
		$(".user").click(function() {
			$("#username").val("");
			$("#password").val("");
			$(".user").css("background", "rgba(255,255,255,0.4)");
			$(".admin").css("background", "rgba(255,255,255,0)");
			$("#sub").attr("action", "UserController/login.action");
			$("#error").text("");
		});
		$(".admin").click(function() {
			$("#username").val("");
			$("#password").val("");
			$(".admin").css("background", "rgba(255,255,255,0.4)");
			$(".user").css("background", "rgba(255,255,255,0)");
			$("#sub").attr("action", "UserController/adminLogin.action");
			$("#error").text("");
		});
	});
	function checkForm() {
		var username = document.getElementById("username").value;
		var password = document.getElementById("password").value;
		if (username == null || username == "") {
			/* alert("用户名不能为空"); */
			document.getElementById("error").innerHTML = "用户名不能为空";
			return false;
		}
		if (password == null || password == "") {
			/* alert("密码不能为空"); */
			document.getElementById("error").innerHTML = "密码不能为空";
			return false;
		}
		if (password.length < 6) {
			document.getElementById("error").innerHTML = "密码不能少于6位";
			return false;
		}
		return true;
	}
</script>
</head>
<body>
	<div id="container">
		<div id="output">
			<div class="containerT">
				<div class="div1">
					<div class="title">售票系统</div>
					<div class="user">用户登录</div>
					<div class="admin">管理员登录</div>
					<div class="div2">
						<form id="sub" action="UserController/login.action" method="post" onsubmit="return checkForm()">
							<input style="margin-top: 60px;" type="text"
								name="username" id="username" placeholder="&nbsp;用户名"><br>
							<input type="password"
								name="password" id="password" placeholder="&nbsp;密码"><br>
							<input type="submit" value="登录"> 
						</form>
						<div class=regist>注册</div>
						<div class="font">
							<font id="error" color=red>${error}</font>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>



</body>
</html>