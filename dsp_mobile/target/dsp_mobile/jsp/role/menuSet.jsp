<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
	<head>
		<%@include file="../public/metaSet.jsp"%>
		<title>角色菜单权限设置</title>
		<style type="text/css">
			*{margin:0;padding:0;list-style-type:none;outline:none;}
			a,img{border:0;}
			body{font:12px/normal "microsoft yahei";}
			.selectbox{width:600px;height:400px;margin:50px 100px auto;}
			.selectbox div{float:left;}
			.selectbox .select-bar{padding:0 20px;}
			.selectbox .select-bar select{width:200px;height:300px;border:1px #A0A0A4 solid;padding:4px;font-size:14px;font-family:"microsoft yahei";}
			.btn-bar{}
			.btn-bar p{margin-top:30px;}
			.btn-bar p .btn{width:50px;height:30px;cursor:pointer;font-family:simsun;font-size:14px;}
		</style>
		
		<link type="text/css" rel="stylesheet" href="../css/bootstrap/bootstrap.min.css" />
		<link href="/dsp/css/layer/layer.css" rel="stylesheet" type="text/css" />
		<script type="application/javascript" src="../js/common/jquery-3.2.1.min.js"></script>
		<script type="application/javascript" src="../js/common/bootstrap.min.js"></script>
		<script type="text/javascript" src="/dsp/js/common/layer.js"></script>
		<script>
			$(function(){	
				//移到右边
				$('#add').click(function(){
					//先判断是否有选中
					if(!$("#select1 option").is(":selected")){			
						alert("请选择需要移动的选项")
					}
					//获取选中的选项，删除并追加给对方
					else{
						$('#select1 option:selected').appendTo('#select2');
					}	
				});
				
				//移到左边
				$('#remove').click(function(){
					//先判断是否有选中
					if(!$("#select2 option").is(":selected")){			
						alert("请选择需要移动的选项")
					}
					else{
						$('#select2 option:selected').appendTo('#select1');
					}
				});
				
				//全部移到右边
				$('#add_all').click(function(){
					//获取全部的选项,删除并追加给对方
					$('#select1 option').appendTo('#select2');
				});
				
				//全部移到左边
				$('#remove_all').click(function(){
					$('#select2 option').appendTo('#select1');
				});
				
				//双击选项
				$('#select1').dblclick(function(){ //绑定双击事件
					//获取全部的选项,删除并追加给对方
					$("option:selected",this).appendTo('#select2'); //追加给对方
				});
				
				//双击选项
				$('#select2').dblclick(function(){
					$("option:selected",this).appendTo('#select1');
				});
				
				//提交
				$('#bt1').bind('click',function(){
					var obj = $("#select2 option");
					var menuIds="";
					for(var i=0;i<obj.length;i++){
					    var opt = obj[i];
					    menuIds+=","+opt.value;
					}
					menuIds = menuIds.substring(1);
					$("#menuIds").val(menuIds);
					$("#form1").submit();
					//var roleId = $("#u1").val();
					//window.location.href = "/dsp/role/menuSet.do?roleId="+roleId+"&menuIds="+menuIds;
				});
				
				/* 角色权限设置结果提示 */
				var msg = $("#msg").val();
				if (null !== msg && "" !== msg) {
					layer.confirm(msg,{
						btn : [ '关闭' ]//按钮
					},
					function() {
						parent.window.location.href = "/dsp/role/pageList.do";
					});
				}
			});
		</script>
	</head>
	
	<body">
    	<div class="container-fluid">
           <div class="selectbox">
				<div class="select-bar">
				    <select multiple="multiple" id="select1" class="form-control">
				    	<c:forEach var="menu" items="${menuList }">
				       		<c:if test="${fn:length(menu.resourceId)==4}">
					    		<option value="${menu.resourceId}">${menu.resourceName }</option>
					    	</c:if>
					    	<c:if test="${fn:length(menu.resourceId)==7}">
					    		<option value="${menu.resourceId}">&nbsp;&nbsp;&nbsp;&nbsp;${menu.resourceName }</option>
					    	</c:if>
					    	 <c:if test="${fn:length(menu.resourceId)==10}">
					    		<option value="${menu.resourceId}">&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;${menu.resourceName }</option>
					    	</c:if>
				        </c:forEach>
				    </select>
				</div>
				
				<div class="btn-bar">
				    <p><span id="add"><input type="button" class="btn" value=">" title="移动选择项到右侧"/></span></p>
				    <p><span id="add_all"><input type="button" class="btn" value=">>" title="全部移到右侧"/></span></p>
				    <p><span id="remove"><input type="button" class="btn" value="<" title="移动选择项到左侧"/></span></p>
				    <p><span id="remove_all"><input type="button" class="btn" value="<<" title="全部移到左侧"/></span></p>
				    <p><span id="sp1"><input id="bt1" type="button" class="btn" value="提交" title="提交"/></span></p>
				</div>
				
				<div class="select-bar">
					<form id="form1" action="/dsp/role/menuSet.do" method="post">
				    	<select multiple="multiple" id="select2" class="form-control">
					    	<c:forEach var="roleMenu" items="${roleMenuList }">
					    		<c:if test="${fn:length(roleMenu.resourceId)==4}">
					    			<option value="${roleMenu.resourceId}">${roleMenu.resourceName}</option>
					    		</c:if>
					    		<c:if test="${fn:length(roleMenu.resourceId)==7}">
					    			<option value="${roleMenu.resourceId}">&nbsp;&nbsp;&nbsp;&nbsp;${roleMenu.resourceName}</option>
					    		</c:if>
					    		<c:if test="${fn:length(roleMenu.resourceId)==10}">
					    			<option value="${roleMenu.resourceId}">&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;${roleMenu.resourceName}</option>
					    		</c:if>
					        </c:forEach>
				    	</select>
				    	<input id="u1" name="roleId" value="${roleId}" type="hidden"/>
				    	<input id="menuIds" name="menuIds" value="" type="hidden"/>
				   		<input id="msg" name="msg" type="hidden" value="${msg}"/>
				    </form>
				</div>	
			</div>
        </div>
    </body>
</html>
