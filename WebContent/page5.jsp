<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/layui.css">
<link rel="stylesheet" href="css/page2.css">
<title>售票系统</title>
</head>
<body>
	<div class="layui-layout layui-layout-admin">
		<div style="color: white;" class="layui-bg-black layui-header header-demo header">
			<p class="p1">售票管理系统</p>
			<ul class="layui-nav nav1" lay-filter="">
			
			  <li class="layui-nav-item">
			    <a href="javascript:;">个人中心</a>
			    <dl class="layui-nav-child"> <!-- 二级菜单 -->
			      <dd><a>用户:${adminname}</a></dd>
			      <dd><a class="alertpass">修改密码</a></dd>
			      <dd><a class="logout">退出登录</a></dd>
			    </dl>
			  </li>
			 
			</ul>
		</div>
		<div class="layui-side layui-bg-black">
			<ul class="layui-nav layui-nav-tree" lay-filter="test">
				<li class="layui-nav-item"><a href="manager.jsp">售票管理系统</a>
				</li>
				
					<li class="layui-nav-item layui-this"><a href="page4.jsp">日志</a></li>
				
			</ul>
		</div>
		<div class="layui-body">
			<table class="layui-table">
			  <colgroup>
			    <col width="150">
			    <col width="200">
			    <col>
			  </colgroup>
			  <thead>
			    <tr>
			      <th>时间</th>
			      <th>日志内容</th>
			    </tr> 
			  </thead>
			  <tbody class = "tb">
			   
			  </tbody>
			</table>
		</div>
	</div>
</body>
<script class="autoinsert" src="js/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="layui.js"></script>

<script type="text/javascript">


$(".logout").click(function(){
	$.post({
		url:"UserController/logout.action",
		success:function(data){
			if(data==1){
				layer.alert('退出登录成功！为您跳转到登录页面', function(index){
    				window,location.href="login.jsp"
    				});
				
			}
		}
	})
})
//点击修改密码
$(".alertpass").click(function(){
	layer.confirm('<div class="layui-form-item"><label class="layui-form-label">用户名</label><label class="layui-form-label uname">${adminname}</label></div><div class="layui-form-item"><label class="layui-form-label">原密码</label><div class="layui-input-block"><input type="text" id="upass" autocomplete="off" class="layui-input"></div></div><div class="layui-form-item"><label class="layui-form-label">新密码</label><div class="layui-input-block"><input type="text" id="newPass" autocomplete="off" class="layui-input"></div></div><div class="layui-inline"><label class="layui-form-label">确认密码</label><div class="layui-input-inline"><input type="text" class="layui-input" id="confirm"></div></div>', { title:'修改密码'}, function(index){
		  //do something
		  var username = $(".uname").text();
		  var password = $("#upass").val();
		  var pass = $("#newPass").val();
		  var comfirmpass = $("#confirm").val();
		  if(pass!=comfirmpass){
			  layer.alert("两次密码不一致！");
		  }else{
			  $.post({
					url:"UserController/alertAdminPass.action",
					data:{
						"password":password,
						"username":username,
						"pass":pass
					},
					success:function(data){
						if(data==1){
							layer.alert("密码修改成功！",function(index){
								$.post({
									url:"UserController/logout.action",
									success:function(data){
										layer.alert('当前登录信息已失效，正在跳转到登录页面', function(index){
						    				window.location.href="login.jsp";
						    			});
									}
								});
							});	
						}else if(data==-1) {
							layer.alert("原密码错误，请检查后重新输入！");
						}else{
							layer.alert("修改出错，请联系开发人员");
						}
					}
				
			  });
		  }
		  
		  layer.close(index);
		});
});

$.post({
	url:"UserController/adminlogined.action",
	success:function(data){
		if(data==0){
			layer.alert('您还未登录，正在跳转到登录页面', function(index){
				window.location.href="login.jsp";
			});
		
		}
		}
});
	layui.use('element', function(){
	  var element = layui.element;
	  
	});
	layui.use('table', function(){
		  var table = layui.table;
	});
$.post({
	url:"logController/adminshowLog.action",
	success:function(data){
		var td = "";
		for ( var list1 in data) {
			console.log(data[list1]);
			td += '<tr><td>'+data[list1][0]+'</td><td>'+data[list1][1]+'</td><tr>';
		}
		console.log(td);
		$(".tb").append(td);
		
	}
	});		 

</script>
</html>