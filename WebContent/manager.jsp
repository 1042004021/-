<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/layui.css">
<link rel="stylesheet" href="css/page2.css">
<meta charset="UTF-8">
<title>售票管理系统</title>
</head>
<body>
	<div class="layui-layout layui-layout-admin">
		<div style="color: white;"
			class="layui-bg-black layui-header header-demo header">
			<p class="p1">售票管理系统</p>
			<ul class="layui-nav  nav1" lay-filter="">
				<li class="layui-nav-item layui-this order"><a href="javascript:;">订单管理</a>
				</li>
				<li class="layui-nav-item user"><a href="javascript:;">用户信息</a></li>
				<li class="layui-nav-item carticket"><a href="javascript:;">车票管理</a></li>
				<li class="layui-nav-item"><a href="javascript:;">个人中心</a>
					<dl class="layui-nav-child">
						<!-- 二级菜单 -->
						<dd>
							<a>用户:${adminname}</a>
						</dd>
						<dd><a class="alertpass">修改密码</a></dd>
						<dd><a class="logout">退出登录</a></dd>
					</dl></li>

			</ul>
		</div>
		<div class="layui-side layui-bg-black">
			<ul class="layui-nav layui-nav-tree" lay-filter="test">
				<li class="layui-nav-item layui-this" ><a href="javascript:;">售票管理系统</a></li>
				<li class="layui-nav-item"><a href="page5.jsp">日志</a></li>
				
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
<span><a class="layui-btn layui-btn-xs" lay-event="sure">确认退票</a></span>
<span><a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="no">拒绝退票</a></span>	
</script>
<script type="text/html" id="barCarticket">
<span><a class="layui-btn layui-btn-xs" lay-event="update">修改车票</a></span>
<span><a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="down">下架车票</a></span>	
</script>
<script type="text/html" id="toolbarDemo">
  <div class="layui-btn-container">
    <button class="layui-btn layui-btn-sm" lay-event="add">添加</button>
  </div>
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
	url:"UserController/adminLogined.action",
	success:function(data){
		if(data==0){
			layer.alert('您还未登录，正在跳转到登录页面', function(index){
				window.location.href="login.jsp";
			});
			
			}
		}
});


//点击下架车票时
$(document).on("click","#test1",function() {
	console.log($(this));
	layui.use('laydate', function(){
		  var laydate = layui.laydate;
		  laydate.render({
			    elem: '#test1'
			    ,show: true //直接显示
			    ,closeStop: '#test1' //这里代表的意思是：点击 test1 所在元素阻止关闭事件冒泡。如果不设定，则无法弹出控件
			  });
	});
	

});

layui.use('element', function(){
	  var element = layui.element;
	});

layui.use('table', function(){
	  var table = layui.table;
	  
	  //第一个实例
	  table.render({
	    elem: '#demo'
	    ,url: 'OrderController/allBackOrder.action' //数据接口
	    ,method:"get"
	    ,page: true //开启分页
	    ,height: 610
	    ,toolbar: true
	    ,title: '用户数据表'
	    ,parseData: function(res){ //res 即为原始返回的数据
	    	console.log(res);
	        return {
	          "code": 0, //解析接口状态
	          "msg": "", //解析提示文本
	          "count": res.total, //解析数据长度
	          "data": res.data //解析数据列表
	        };	
	      }
	  ,request: {
		    pageName: "page" //页码的参数名称，默认：page
		        ,limitName: "limit" //每页数据量的参数名，默认：limit
		      }
	    ,cols: [[ //表头
	      {field: 'uid', title: '用户id', width: 177}
	      ,{field: 'start', title: '出发地', width:200, sort: true}
	      ,{field: 'end', title: '到达地',sort: true,width:200}
	      ,{field: 'time', title: '发车日期', width:200, sort: true}
	      ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:150}
	      
	    ]]
	    ,id: 'testReload'
	  });
	  
	  table.on('toolbar(test)', function(obj){
		    var data = obj.data;
		  //点击添加时
			  if(obj.event === 'add'){
			      console.log(obj.data)
			       layer.confirm('<div class="layui-form-item"><label class="layui-form-label">起始地</label><div class="layui-input-block"><input type="text" id="start" placeholder="成都" autocomplete="off" class="layui-input"></div></div><div class="layui-form-item"><label class="layui-form-label">到达地</label><div class="layui-input-block"><input type="text" id="end" placeholder="上海" autocomplete="off" class="layui-input"></div></div><div class="layui-form-item"><label class="layui-form-label">票数</label><div class="layui-input-block"><input type="text" id="quantity" placeholder="99" autocomplete="off" class="layui-input"></div></div><div class="layui-inline"><label class="layui-form-label">上车日期</label><div class="layui-input-inline"><input type="text" class="layui-input" id="test1" placeholder="yyyy-MM-dd"></div></div>', function(index){
			    	   var start = $("#start").val();
			    	   var end = $("#end").val();
			    	   var quantity = $("#quantity").val();
			    	   var startime = $("#test1").val();
			    	   $.post({
				        	url:'TicketServlet/addTicket.action',
				        	data:{
				        		"start":start,
								"end":end,
								"time":startime,
								"quantity":quantity
				        	},
				        	success : function(data) {
				        		if(data!=-1){
				        			layer.alert('操作成功', function(index){
				        				location.replace(location);
				        				});
				        			
				        		}else{
				        			layer.alert("操作失败")
				        		}
				        	} 
				       	 });
			    	   layer.close(index);
			    	});
			    	 
			  }
		   });
			    
		  
		   
		 
	 
	  //监听行工具事件
	  table.on('tool(test)', function(obj){
	    var data = obj.data;
	    console.log(obj)
	    //点击确认退单时
	    if(obj.event === 'sure'){
	      console.log(obj.data)
	       layer.confirm('请确认是否同意退票'+"<br>"+'出发地：'+obj.data["start"]+",到达地："+obj.data["end"], function(index){
	    	 var cid = obj.data['cid'];
	    	 var uid = obj.data['uid'];
	    	 var start = obj.data['start'];
	    	 var end = obj.data['end'];
	    	 var time = obj.data['time'];
	     	 $.post({
	        	url:'OrderController/sureBackOrder.action',
	        	data:{
	        		"cid":cid,
					"uid":uid,
					"start":start,
					"end":end,
					"status":"-1",
					"time":time
	        	},
	        	success : function(data) {
	        		if(data!=-1){
	        			layer.alert('操作成功', function(index){
	        				location.replace(location);
	        				});
	        			
	        		}else{
	        			layer.alert("操作失败")
	        		}
	        	} 
	       	 });  
	    	  layer.close(index);
	      });
	    } 
	    //点击拒绝退票时
	    if(obj.event === 'no'){
		      console.log(obj.data)
		       layer.confirm('请确认是否拒绝退票'+"<br>"+'出发地：'+obj.data["start"]+",到达地："+obj.data["end"], function(index){
		    	 var cid = obj.data['cid'];
		    	 var uid = obj.data['uid'];
		    	
		     	 $.post({
		        	url:'OrderController/noBackOrder.action',
		        	data:{
		        		"cid":cid,
						"uid":uid,
						
		        	},
		        	success : function(data) {
		        		if(data!=-1){
		        			layer.alert('操作成功', function(index){
		        				location.replace(location);
		        				});
		        			
		        		}else{
		        			layer.alert("操作失败")
		        		}
		        	} 
		       	 });  
		    	  layer.close(index);
		      });
		    }
	    //点击修改车票时
	    if(obj.event === 'update'){
		      console.log(obj.data)
		       layer.confirm('出发地：'+obj.data["start"]+'<br>到达地：'+obj.data["end"]+'<br>发车时间：'+obj.data['time']+'<br><div style="margin-left:-50px" class="layui-form-item"><label class="layui-form-label">余票数</label><div class="layui-input-block"><input type="text" name="" placeholder="'+obj.data["quantity"]+'" autocomplete="off" class="layui-input in"></div></div>',{title:"修改车票"}, function(index){
		    	 var cid = obj.data['cid'];
		    	 var quantity = $(".in").val();
		    	 console.log(quantity);
		    	 
		     	 $.post({
		        	url:'TicketServlet/updateTicket.action',
		        	data:{
		        		"cid":cid,
						"quantity":quantity
						
		        	},
		        	success : function(data) {
		        		if(data!=-1){
		        			
		        			layer.alert('操作成功', function(index){
		        				location.replace(location);
		        				});
		        			
		        		}else{
		        			layer.alert("操作失败")
		        		}
		        	} 
		       	 });  
		    	  layer.close(index);
		      });
		    }
	    
	  //点击下架车票时
		  if(obj.event === 'down'){
		      console.log(obj.data)
		       layer.confirm('请确认是否下架车票'+"<br>"+'出发地：'+obj.data["start"]+",到达地："+obj.data["end"], function(index){
		    	 var cid = obj.data['cid'];
		    	
		    	
		     	 $.post({
		        	url:'TicketServlet/deleteTicket.action',
		        	data:{
		        		"cid":cid
		        	},
		        	success : function(data) {
		        		if(data!=-1){
		        			layer.alert('操作成功', function(index){
		        				location.replace(location);
		        				});
		        			
		        		}else{
		        			layer.alert("操作失败")
		        		}
		        	} 
		       	 });  
		    	  layer.close(index);
		      });
		    }
		
	
	  });
	  
	  //点击订单管理时
	 $(".order").click(function(){
		 table.render({
			    elem: '#demo'
			    ,url: 'OrderController/allBackOrder.action' //数据接口
			    ,method:"get"
			    ,page: true //开启分页
			    ,height: 610
			    ,toolbar: true
			    ,title: '用户数据表'
			    ,parseData: function(res){ //res 即为原始返回的数据
			    	console.log(res);
			        return {
			          "code": 0, //解析接口状态
			          "msg": "", //解析提示文本
			          "count": res.total, //解析数据长度
			          "data": res.data //解析数据列表
			        };	
			      }
			  ,request: {
				    pageName: "page" //页码的参数名称，默认：page
				        ,limitName: "limit" //每页数据量的参数名，默认：limit
				      }
			    ,cols: [[ //表头
			      {field: 'uid', title: '用户id', width: 177}
			      ,{field: 'start', title: '出发地', width:200, sort: true}
			      ,{field: 'end', title: '到达地',sort: true,width:200}
			      ,{field: 'time', title: '发车日期', width:200, sort: true}
			      ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:150}
			      
			    ]]
			    ,id: 'testReload'
			 });
	 });
	  
	  
	  //点击用户信息时
	  $(".user").click(function(){
		  table.render({
			    elem: '#demo'
			    ,url: 'UserController/allUser.action' //数据接口
			    ,method:"get"
			    ,page: true //开启分页
			    ,height: 610
			    ,toolbar: true
			    ,title: '用户数据表'
			    ,parseData: function(res){ //res 即为原始返回的数据
			    	console.log(res);
			        return {
			          "code": 0, //解析接口状态
			          "msg": "", //解析提示文本
			          "count": res.total, //解析数据长度
			          "data": res.data //解析数据列表
			        };	
			      }
			  ,request: {
				    pageName: "page" //页码的参数名称，默认：page
				        ,limitName: "limit" //每页数据量的参数名，默认：limit
				      }
			    ,cols: [[ //表头
			    	{field: 'uid', title: '用户id', width: 177}
				    ,{field: 'username', title: '用户名', width:200, sort: true}
				    ,{field: 'password', title: '用户密码',sort: true,width:200}
				      
			      
			    ]]
			    ,id: 'testReload'
			  });
	  });
	  
	  
	  //点击车票管理时
	  $(".carticket").click(function(){
		  table.render({
			    elem: '#demo'
			    ,url: 'TicketServlet/allTicket.action' //数据接口
			    ,method:"get"
			    ,page: true //开启分页
			    ,height: 610
			    ,toolbar: true
			    ,toolbar: '#toolbarDemo'
			    ,title: '用户数据表'
			    ,parseData: function(res){ //res 即为原始返回的数据
			    	console.log(res);
			        return {
			          "code": 0, //解析接口状态
			          "msg": "", //解析提示文本
			          "count": res.total, //解析数据长度
			          "data": res.data //解析数据列表
			        };	
			      }
			  ,request: {
				    pageName: "page" //页码的参数名称，默认：page
				        ,limitName: "limit" //每页数据量的参数名，默认：limit
				      }
			    ,cols: [[ //表头
			    	{field: 'start', title: '出发地', width:200, sort: true}
				    ,{field: 'end', title: '到达地',sort: true,width:200}
		            ,{field: 'time', title: '发车日期', width:200, sort: true}
			        ,{field: 'quantity', title: '余票数', width:200, sort: true}
			        ,{fixed: 'right', title:'操作', toolbar: '#barCarticket', width:150}
			      
			      
			    ]]
			    ,id: 'testReload'
			  });
	  });
	});
</script>
</html>