<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
	<head>
		<%@include file="../public/metaSet.jsp"%>
		<title>用户角色设置</title>
		<style type="text/css">
			*{margin:0;padding:0;list-style-type:none;outline:none;}
			a,img{border:0;}
			body{font:12px/normal "microsoft yahei";}
			.selectbox{width:600px;height:400px;margin:10px 10px auto 50px;padding-top: 20px;}
			.selectbox .select-bar{padding:0 10px;}
			.selectbox .select-bar select{width:300px;height:320px;border:1px #A0A0A4 solid;padding:10px;font-size:14px;font-family:"microsoft yahei";}
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
				var roleData = ${roleList }
				var userRoleData = ${userRoleList}
				/* 加载多选框数据 */
				doViewSelect("select1",roleData);
				doViewSelect("select2",userRoleData);
				
				//移到右边
				$('#add').click(function(){
					//先判断是否有选中
					if(!$("#select1 option").is(":selected")){			
						alert("请选择需要移动的选项")
					}
					//获取选中的选项，删除并追加给对方
					else{
						var itm = $('#select1').val();
						for (i=0;i<itm.length ;i++ ) 
						{
							rmdim(roleData,itm[i],userRoleData);
							
						}
						//追加到右边方框
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
						var itm = $('#select2').val();
						for (i=0;i<itm.length ;i++ ) 
						{
							rmdim(userRoleData,itm[i],roleData);
						}
						$('#select2 option:selected').appendTo('#select1');
					}
				});
				
				//全部移到右边
				$('#add_all').click(function(){
					mvArr(roleData,userRoleData);
					//获取全部的选项,删除并追加给对方
					$('#select1 option').appendTo('#select2');
				});
				
				//全部移到左边
				$('#remove_all').click(function(){
					mvArr(userRoleData,roleData); 
					
					$('#select2 option').appendTo('#select1');
				});
				
				//双击选项
				$('#select1').dblclick(function(){ //绑定双击事件
					var itm = $("option:selected",this).val();
					rmdim(roleData,itm,userRoleData);
					//获取全部的选项,删除并追加给对方
					$("option:selected",this).appendTo('#select2'); //追加给对方
				});
				
				//双击选项
				$('#select2').dblclick(function(){
					var itm = $("option:selected",this).val();
					rmdim(userRoleData,itm,roleData);
					$("option:selected",this).appendTo('#select1');
				});
				
				//提交
				$('#bt1').bind('click',function(){
					//var obj = $("#select2 option");
					var roleIds="";
					for(var i=0;i<userRoleData.length;i++){
					    var opt = userRoleData[i].roleId;
					    roleIds+=","+opt;
					}
					roleIds = roleIds.substring(1);
					$("#roleIds").val(roleIds)
					$("#roleForm").submit();
				});
				
				//角色数据权限设置结果提示 
				var msg = $("#msg").val();
				if (null !== msg && "" !== msg) {
					layer.confirm(msg,{
						btn : [ '关闭' ]//按钮
					},
					function() {
						parent.window.location.href = "/dsp/user/pageList.do";
					});
				}
				
				//维度筛选
				$('#s1').bind('change',function(){
					var inputValue = $("#s1").val();
					if(inputValue==""){
						doViewSelect("select1",roleData);
					}else{
						var len = roleData.length;
						var arr = [];
						for(var i=0;i<len;i++){
						    //如果字符串中不包含目标字符会返回-1
						    if(roleData[i].roleDim==inputValue){
						        arr.push(roleData[i]);
						    }
						}
						doViewSelect("select1",arr);
					}
				});
				
				//模糊查询 
				$("#input1").keyup(function(){
					var inputValue = $("#input1").val();
					var sValue = $("#s1").val();
					var len = roleData.length;
					var arr = [];
					if(sValue==""){
						for(var i=0;i<len;i++){
						    //如果字符串中不包含目标字符会返回-1
						    if(roleData[i].roleName.indexOf(inputValue)>=0){
						        arr.push(roleData[i]);
						    }
						}
					}else{
						for(var i=0;i<len;i++){
						    //如果字符串中不包含目标字符会返回-1
						    if(roleData[i].roleName.indexOf(inputValue)>=0&&roleData[i].roleDim==sValue){
						        arr.push(roleData[i]);
						    }
						}
					}
					doViewSelect("select1",arr);
				});
				
				//模糊查询 
				$("#input2").keyup(function(){
					var inputValue = $("#input2").val();
					var len = userRoleData.length;
					var arr = [];
					for(var i=0;i<len;i++){
					    //如果字符串中不包含目标字符会返回-1
					    if(userRoleData[i].roleName.indexOf(inputValue)>=0){
					        arr.push(userRoleData[i]);
					    }
					}
					doViewSelect("select2",arr);
				});
				
			});
			
			function doViewSelect(id,arr){
				if(arr!=null){
					var optionlist = '';
					$.each(arr, function(i, n) {
						optionlist+='<option value="'+n.roleId+'">'+n.roleName+'</option>';
					});
					$('#'+id).html("");
					$('#'+id).append(optionlist);
				}
			}
			
			//两数组数据左右互移
			function rmdim(arr,temValue,arr1) {
				 var len = arr.length-1;
				 for(var i=len;i>=0;i--){
					 if(arr[i].roleId==temValue){
					  arr1.push(arr[i]);
					  arr.splice(i,1);
					 }
				 }
			}
			
			function mvArr(arr1,arr2){
				for (i=arr1.length-1;i>=0;i--) 
				{
					arr2.push(arr1[i]);
					arr1.splice(i,1);
				}
			}
		</script>
	</head>
	
	<body">
    	<div class="container-fluid">
           <div class="selectbox">
           
	           <table>
	           		<tr>
	           			<td>
	           				<div class="select-bar">
							    <%-- <select multiple="multiple" id="select1" class="form-control">
							    	<c:forEach var="role" items="${roleList }">
							        	<option value="${role.roleId }">${role.roleName }</option>
							        </c:forEach>
							    </select> --%>
							    <span style="float: left;width: 30%"> 
							    	<select id="s1" style="width: 100%;height: 39px" class="form-control">
							    		<option value="">所有</option>
							    		<c:if test="${roleType==2}">
								    		<c:forEach var="dic" items="${dictList}">
								    			<option value="${dic.paramCode}">${dic.paramValue}</option>
								    		</c:forEach>
							    		</c:if>
							    	</select>
							    </span>
							    <span style="float: left;width: 70%"> <input id="input1" style="height: 39px" class="form-control" /></span>
							    <select id="select1" class="form-control" multiple="multiple" >
							    </select>
							</div>
	           			</td>
	           			<td>
	           				<div class="btn-bar">
							    <p><span id="add"><input type="button" class="btn" value=">" title="移动选择项到右侧"/></span></p>
							    <p><span id="add_all"><input type="button" class="btn" value=">>" title="全部移到右侧"/></span></p>
							    <p><span id="remove"><input type="button" class="btn" value="<" title="移动选择项到左侧"/></span></p>
							    <p><span id="remove_all"><input type="button" class="btn" value="<<" title="全部移到左侧"/></span></p>
							    <p><span id="sp1"><input id="bt1" type="button" class="btn" value="提交" title="提交"/></span></p>
							</div>
	           			</td>
	           			<td>
	           				<div class="select-bar">
								<%-- <form id="roleForm" action="/dsp/user/roleSet.do" method="post" >
							    	<select multiple="multiple" id="select2" name="roleIds" class="form-control">
								    	<c:forEach var="userRole" items="${userRoleList }">
								        	<option value="${userRole.roleId}">${userRole.roleName}</option>
								        </c:forEach>
							    	</select>
							    	<input id="u1" name="userId" value="${userId}" type="hidden"/>
							    	<input id="u2" name="roleType" value="${roleType}" type="hidden"/>
							   		<input id="msg" name="msg" type="hidden" value="${msg}"/>
							    </form> --%>
							    <input id="input2" style="height: 39px" class="form-control" />
								<form id="roleForm"  method="post" action="/dsp/user/roleSet.do">
							    	<select multiple="multiple" id="select2" class="form-control">
							    	</select>
							    	<input id="roleIds" name="roleIds" value="" type="hidden">
							    	<input id="u1" name="userId" value="${userId}" type="hidden"/>
							    	<input id="u2" name="roleType" value="${roleType}" type="hidden"/>
							   		<input id="msg" name="msg" type="hidden" value="${msg}"/>
							    </form>
							</div>	
	           			</td>
	           		</tr>
	           </table>
				
			</div>
        </div>
        
        
	 	<!--<a data-toggle="modal" href="to-another-url-page" data-target="#myModal">Click me !</a>-->

		<!-- Modal -->
		<!--<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h4 class="modal-title">Modal title</h4>
		
					</div>
					<div class="modal-body">
						<div class="te"></div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						<button type="button" class="btn btn-primary">Save changes</button>
					</div>
				</div>
			</div>
		</div>-->
</body>
</html>
