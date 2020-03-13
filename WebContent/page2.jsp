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
			  <div class="layui-form-item form1">
			    <label class="layui-form-label">起始地</label>
			    <div class="layui-input-block">
			      <input type="text" name="title" required  lay-verify="required" placeholder="请输入起始地" autocomplete="off" class="layui-input start">
			    </div>
			  </div>
			  <div class="layui-form-item form2">
			    <label class="layui-form-label">到达地</label>
			    <div class="layui-input-block">
			      <input type="text" name="title" required  lay-verify="required" placeholder="请输入到达地" autocomplete="off" class="layui-input end">
			    </div>
			  </div>
			  <button class="layui-btn search">查询</button>
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
				<li class="layui-nav-item layui-this"><a href="page2.jsp">车票</a>
				</li>
				<li class="layui-nav-item "><a
					href="page3.jsp">订单</a></li>
					<li class="layui-nav-item"><a href="page4.jsp">日志</a></li>
				<li class="layui-nav-item"><a href="index.jsp">首页</a></li>
			</ul>
		</div>
		<div class="layui-body">
			<table id="demo" lay-filter="test">
			
			</table>
		</div>
	</div>
</body>
<script class="autoinsert" src="js/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="layui.js"></script>
<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="buy">购买</a>
</script>
<script type="text/javascript">
//查询指定车票
$(".search").click(function(){
	var start = $(".start").val();
	var end = $(".end").val();
	layui.use('table', function(){
		  var table = layui.table;
		  
		  //第一个实例
		  table.render({
		    elem: '#demo'//在id为demo的元素里面渲染
		    ,url: 'TicketServlet/searchTicket.action' //数据接口
		    ,method:"get"//请求方法为get
		    ,page: true //开启分页
		    ,height: 610
		    ,where:{//传到后台
		    	"start":start,
		    	"end":end
		    }
		  //实现分页
		    ,parseData: function(res){ //res 即为原始返回的数据
		    	console.log(res);
		        return {
		          "code": 0, //解析接口状态
		          "msg": "", //解析提示文本
		          "count": res.total, //解析数据长度
		          "data": res.data //解析数据列表
		        };	
		      }
		  ,request: {//传入后台
			    pageName: "page" //页码的参数名称，默认：page
			        ,limitName: "limit" //每页数据量的参数名，默认：limit
			      }
		    ,cols: [[ //表头
		      {field: 'cid', title: 'id', width: 177}
		      ,{field: 'start', title: '出发地', width:200, sort: true}
		      ,{field: 'end', title: '到达地',sort: true,width:200}
		      ,{field: 'time', title: '发车日期', width:200, sort: true}
		      ,{field: 'quantity', title: '余票数',sort: true, width:200} 
		      ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:150}
		      
		    ]]
		    ,id: 'testReload'
		  });
		  
		
		 
		  //监听行工具事件
		  table.on('tool(test)', function(obj){
		    var data = obj.data;
		    console.log(obj)
		    if(obj.event === 'buy'){
		      console.log(obj.data)
		       layer.confirm('真的要购买车票么?'+"<br>"+'出发地：'+obj.data["start"]+",到达地："+obj.data["end"], function(index){
		    	 console.log(obj.data['cid']);
		    	 $.post({
		        	url:'OrderController/insertOrder.action',
		        	data:{
		        		cid:obj.data['cid']
		        	},
		        	success : function(data) {
		        		if(data!=-1){
		        			layer.alert('购票成功', function(index){
		        				location.replace(location);
		        				});
		        		}else{
		        			layer.alert("购票失败，请勿重复购票")
		        		}
		        	} 
		       	 }); 
		    	  layer.close(index);
		      });
		    } 
		  });
		});
});
//点击修改密码
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
//退出登录
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

layui.use('layer', function(){
  var layer = layui.layer;
  //登陆时验证用户是否登录登录
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
}); 

	layui.use('element', function(){
	  var element = layui.element;
	  
	});
	
	layui.use('table', function(){
		  var table = layui.table;
		  
		  //第一个实例
		  table.render({
		    elem: '#demo'
		    ,url: 'TicketServlet/allTicket.action' //数据接口
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
		      {field: 'cid', title: 'id', width: 177}
		      ,{field: 'start', title: '出发地', width:200, sort: true}
		      ,{field: 'end', title: '到达地',sort: true,width:200}
		      ,{field: 'time', title: '发车日期', width:200, sort: true}
		      ,{field: 'quantity', title: '余票数',sort: true, width:200} 
		      ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:150}
		      
		    ]]
		    ,id: 'testReload'
		  });
		  
		
		 
		  //监听行工具事件
		  table.on('tool(test)', function(obj){
		    var data = obj.data;
		    console.log(obj)
		    //点击购买车票
		    if(obj.event === 'buy'){
		      console.log(obj.data)
		       layer.confirm('真的要购买车票么?'+"<br>"+'出发地：'+obj.data["start"]+",到达地："+obj.data["end"], function(index){
		    	 console.log(obj.data['cid']);
		    	 $.post({
		        	url:'OrderController/insertOrder.action',
		        	data:{
		        		cid:obj.data['cid']
		        	},
		        	success : function(data) {
		        		if(data!=-1){
		        			layer.alert('购票成功', function(index){
		        				location.replace(location);
		        				});
		        		}else{
		        			layer.alert("购票失败，请勿重复购票")
		        		}
		        	} 
		       	 }); 
		    	  layer.close(index);
		      });
		    } 
		  });
		});
</script>
</html>