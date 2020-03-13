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
			<p class="p1">售票系统</p>
			<ul class="layui-nav nav1" lay-filter="">
			 
			  <li class="layui-nav-item">
			    <a href="javascript:;">个人中心</a>
			    <dl class="layui-nav-child"> <!-- 二级菜单 -->
			      <dd><a>用户:${username}</a></dd>
			      <dd><a class="alertpass">修改密码</a></dd>
			      <dd><a class="logout">退出登录</a></dd>
			    </dl>
			  </li>
			 
			</ul>
		</div>
		<div class="layui-side layui-bg-black">
			<ul class="layui-nav layui-nav-tree" lay-filter="test">
				<li class="layui-nav-item"><a href="page2.jsp">车票</a>
				</li>
				<li class="layui-nav-item "><a
					href="page3.jsp">订单</a></li>
					<li class="layui-nav-item layui-this"><a href="page4.jsp">日志</a></li>
				<li class="layui-nav-item"><a href="index.jsp">首页</a></li>
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

$.post({
	url:"UserController/logined.action",
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
	url:"logController/showLog.action",
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