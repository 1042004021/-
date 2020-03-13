<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/layui.css">
<link rel="stylesheet" href="css/page2.css">
<meta charset="UTF-8">
<title>售票系统</title>
</head>
<body>
	<div class="layui-layout layui-layout-admin">
		<div style="color: white;"
			class="layui-bg-black layui-header header-demo header">
			<p class="p1">售票系统</p>
			<ul class="layui-nav  nav1" lay-filter="">
				<li class="layui-nav-item layui-this now"><a href="javascript:;">当前订单</a>
				</li>
				<li class="layui-nav-item wait"><a href="javascript:;">待审核订单</a></li>
				<li class="layui-nav-item done"><a href="javascript:;">已完成订单</a></li>
				<li class="layui-nav-item"><a href="javascript:;">个人中心</a>
					<dl class="layui-nav-child">
						<!-- 二级菜单 -->
						<dd>
							<a>用户:${username}</a>
						</dd>
						<dd><a class="alertpass">修改密码</a></dd>
						<dd><a class="logout">退出登录</a></dd>
					</dl></li>

			</ul>
		</div>
		<div class="layui-side layui-bg-black">
			<ul class="layui-nav layui-nav-tree" lay-filter="test">
				<li class="layui-nav-item "><a href="page2.jsp">车票</a></li>
				<li class="layui-nav-item layui-this  layui-nav-itemed"><a
					href="page3.jsp">订单</a></li>
				<li class="layui-nav-item"><a href="page4.jsp">日志</a></li>
				<li class="layui-nav-item"><a href="index.jsp">首页</a></li>
			</ul>
		</div>
		<div class="layui-body">

			<table id="demo" lay-filter="test"></table>
		</div>
	</div>
</body>
<script class="autoinsert" src="js/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="layui.js"></script>
<script type="text/html" id="barDemo">
  <span><a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="back">退票</a></span>
  <span><a class="layui-btn layui-btn-xs" lay-event="finish">完成订单</a></span>	
</script>
<script type="text/html" id="barShow">
  <p class="layui-btn layui-btn-primary layui-btn-xs">待审核</p>
  {{#  if(d.auth > 2){ }}
    <a class="layui-btn layui-btn-xs" lay-event="check">审核</a>
  {{#  } }}

</script>
<script type="text/javascript">
//点击退出登录
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
$(".alertpass").click(function(){
	layer.confirm('<div class="layui-form-item"><label class="layui-form-label">用户名</label><label class="layui-form-label uname">${username}</label></div><div class="layui-form-item"><label class="layui-form-label">原密码</label><div class="layui-input-block"><input type="text" id="upass" autocomplete="off" class="layui-input"></div></div><div class="layui-form-item"><label class="layui-form-label">新密码</label><div class="layui-input-block"><input type="text" id="newPass" autocomplete="off" class="layui-input"></div></div><div class="layui-inline"><label class="layui-form-label">确认密码</label><div class="layui-input-inline"><input type="text" class="layui-input" id="confirm"></div></div>', { title:'修改密码'}, function(index){
		  //do something
		  var username = $(".uname").text();
		  var password = $("#upass").val();
		  var pass = $("#newPass").val();
		  var comfirmpass = $("#confirm").val();
		  if(pass!=comfirmpass){
			  layer.alert("两次密码不一致！");
		  }else{
			  $.post({
					url:"UserController/alertPass.action",
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
	url:"UserController/logined.action",
	success:function(data){
		if(data==0){
			layer.alert('您还未登录，正在跳转到登录页面', function(index){
				window.location.href="login.jsp";
			});
		
		}
		}
});

	layui.use('element', function() {
		var element = layui.element;

	});
	layui.use('table', function() {
		var table = layui.table;

		//第一个实例
		table.render({
			elem : '#demo',
			url : 'OrderController/allOrder.action' //数据接口
			,
			method : "get",
			page : true //开启分页
			,
			height : 610,
			toolbar : true,
			title : '用户数据表',
			parseData : function(res) { //res 即为原始返回的数据
				console.log(res);
				return {
					"code" : 0, //解析接口状态
					"msg" : "", //解析提示文本
					"count" : res.total, //解析数据长度
					"data" : res.data
				//解析数据列表
				};
			},
			request : {
				pageName : "page" //页码的参数名称，默认：page
				,
				limitName : "limit" //每页数据量的参数名，默认：limit

			},
			cols : [ [ //表头
			{
				field : 'cid',
				title : 'id',
				width : 200,
				sort : true
			},
			{
				field : 'start',
				title : '出发地',
				width : 200,
				sort : true
			}, {
				field : 'end',
				title : '到达地',
				sort : true,
				width : 200
			}, {
				field : 'time',
				title : '发车日期',
				width : 200,
				sort : true
			}, {
				fixed : 'right',
				title : '操作',
				toolbar : '#barDemo',
				width : 150
			}

			] ],
			id : 'testReload'
		});

		//监听行工具
		table.on('tool(test)', function(obj) {
			var data = obj.data;
			console.log(obj)
			//点击退票时
			if (obj.event === 'back') {
				console.log(obj.data)
				layer.confirm('真的要取消订单么?' + "<br>" + '出发地：' + obj.data["start"]
						+ ",到达地：" + obj.data["end"], function(index) {
					console.log(obj.data['cid']);
					$.post({
						url : 'OrderController/backOrder.action',
						data : {
							cid : obj.data['cid']
						},
						success : function(data) {
							if (data != -1) {
								layer.alert('退票申请成功，请在待审核订单查看进度', function(index){
			        				location.replace(location);
			        				});
							} else {
								layer.alert("退票失败！")
							}
						}
					});
					layer.close(index);
				});
			}
			//点击完成订单时
			if (obj.event === 'finish') {
				var cid = obj.data['cid'];
				var start = obj.data['start'];
				var end = obj.data['end'];
				var time = obj.data['time'];
			
					$.post({
						url : 'OrderController/finishOrder.action',
						data : {
							"start":start,
							"end":end,
							"time":time,
							"cid":cid,
							"status":"1"
						},
						success : function(data) {
							if (data != -1) {
								layer.alert('操作成功', function(index){
			        				location.replace(location);
			        				});
							} else {
								layer.alert("操作失败！")
							}
						}
					}); 
				
				}
			});
		
		
		//点击当前订单
		$(".now").click(function(){
			table.render({
				elem : '#demo',
				url : 'OrderController/allOrder.action' //数据接口
				,
				method : "get",
				page : true //开启分页
				,
				height : 610,
				toolbar : true,
				title : '用户数据表',
				parseData : function(res) { //res 即为原始返回的数据
					console.log(res);
					return {
						"code" : 0, //解析接口状态
						"msg" : "", //解析提示文本
						"count" : res.total, //解析数据长度
						"data" : res.data
					//解析数据列表
					};
				},
				request : {
					pageName : "page" //页码的参数名称，默认：page
					,
					limitName : "limit" //每页数据量的参数名，默认：limit

				},
				cols : [ [ //表头
				{
					field : 'cid',
					title : 'id',
					width : 200,
					sort : true
				},
				{
					
					field : 'start',
					title : '出发地',
					width : 200,
					sort : true
				}, {
					field : 'end',
					title : '到达地',
					sort : true,
					width : 200
				}, {
					field : 'time',
					title : '发车日期',
					width : 200,
					sort : true
				}, {
					fixed : 'right',
					title : '操作',
					toolbar : '#barDemo',
					width : 150
				}

				] ],
				id : 'testReload'
			});
		});
		
		//点击待审核订单
		$(".wait").click(function(){
			table.render({
				elem : '#demo',
				url : 'OrderController/showBackOrder.action' //数据接口
				,
				method : "get",
				page : true //开启分页
				,
				height : 610,
				toolbar : true,
				title : '用户数据表',
				parseData : function(res) { //res 即为原始返回的数据
					console.log(res);
					return {
						"code" : 0, //解析接口状态
						"msg" : "", //解析提示文本
						"count" : res.total, //解析数据长度
						"data" : res.data
					//解析数据列表
					};
				},
				request : {
					pageName : "page" //页码的参数名称，默认：page
					,
					limitName : "limit" //每页数据量的参数名，默认：limit

				},
				cols : [ [ //表头
				{
					field : 'cid',
					title : 'id',
					width : 200,
					sort : true
				},
				{
					field : 'start',
					title : '出发地',
					width : 200,
					sort : true
				}, {
					field : 'end',
					title : '到达地',
					sort : true,
					width : 200
				}, {
					field : 'time',
					title : '发车日期',
					width : 200,
					sort : true
				}, {
					fixed : 'right',
					title : '操作',
					toolbar : '#barShow',
					width : 150
				}

				] ],
				id : 'testReload'
			});
		});
		
		//点击已完成订单后
		$(".done").click(function(){
			table.render({
				elem : '#demo',
				url : 'FinishOrderController/allFinishOrder.action' //数据接口
				,
				method : "get",
				page : true //开启分页
				,
				height : 610,
				toolbar : true,
				title : '用户数据表',
				parseData : function(res) { //res 即为原始返回的数据
					console.log(res);
					return {
						"code" : 0, //解析接口状态
						"msg" : "", //解析提示文本
						"count" : res.total, //解析数据长度
						"data" : res.data
					//解析数据列表
					};
				},
				request : {
					pageName : "page" //页码的参数名称，默认：page
					,
					limitName : "limit" //每页数据量的参数名，默认：limit

				},
				cols : [ [ //表头
				
				{
					field : 'start',
					title : '出发地',
					width : 200,
					sort : true
				}, {
					field : 'end',
					title : '到达地',
					sort : true,
					width : 200
				}, {
					field : 'time',
					title : '发车日期',
					width : 200,
					sort : true
				}, {
					field : 'status',
					title : '状态',
					width : 150,
					sort : true,
					templet: function(d){
						if(d.status==1){
				        	return '<span style="color: #c00;">订单已完成</span>'
						}else{
							return '<span style="color: #c00;">订单已取消</span>'
						}
				      }
				}

				] ],
				id : 'testReload'
			});
		});
		
	});
</script>
</html>