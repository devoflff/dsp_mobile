<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<%@include file="../public/metaSet.jsp"%>
		<title>角色列表</title>
		<link type="text/css" rel="stylesheet" href="../css/bootstrap/bootstrap.min.css" />
		<link href="/dsp/css/layer/layer.css" rel="stylesheet" type="text/css" />
		<script type="application/javascript" src="../js/common/jquery-3.2.1.min.js"></script>
		<script type="application/javascript" src="../js/common/bootstrap.min.js"></script>
		<script type="text/javascript" src="/dsp/js/common/layer.js"></script>
		<script type="text/javascript" src="/dsp/js/globalVal.js"></script>
		<style>
			.table th,
			#div1{
				padding-top: 10px;
			}
		</style>
		<script type="text/javascript">
			function openwin(){
			layer.open({
					type: 2,
					title: '新增角色',
					shadeClose: true,
					shade: false,
					maxmin: true, //开启最大化最小化按钮
					area: ['800px', '500px'],
					content: '/dsp/role/create.do'
				});
			}
			
			function openEdit(roleId){
				layer.open({
					type: 2,
					title: '编辑角色',
					shadeClose: true,
					shade: false,
					maxmin: true, //开启最大化最小化按钮
					area: ['800px', '500px'],
					content: '/dsp/role/edit.do?roleId='+roleId
				});
			}
			
			function openRole(roleId,roleType,roleDim){
				layer.open({
					type: 2,
					title: '角色权限设置',
					shadeClose: true,
					shade: false,
					maxmin: true, //开启最大化最小化按钮
					area: ['800px', '500px'],
					content: '/dsp/role/toMenu.do?roleId='+roleId+'&roleType='+roleType+'&roleDim='+roleDim
				});
			}
			
			//删除
			function openDelete(rolrId){
				 layer.confirm(DELETEMSG, function (index) {
					 layer.close(index);  
		              $.post("/dsp/role/delete.do", { roleId:rolrId }, function (data) {  
		            	  window.location.href = "/dsp/role/pageList.do";
		                });  
				 });
			}
			
			function getPage(currPage){
				if(currPage<1||currPage>${roleList.totalPage}){
					return;
				}
				$("#page").val(currPage);
				$("#rows").val(rows);
				$("#form1").submit();
			}
			
			//跳转
			function goPage(){
				var page = $("#go1").val();
				if(page==${roleList.currPage}){
					return;
				}
				if(page<1){
					$("#page").val(1);
				}else if(page>${roleList.totalPage}){
					$("#page").val(${roleList.totalPage});
				}else{
					$("#page").val(page);
				}
				$("#rows").val(rows);
				$("#form1").submit();
			}
			
			$(function(){
				//查询
				$('#btnSearch').bind('click',function(){
					$("#page").val(1);
					$("#rows").val(rows);
					$("#form1").submit();
				})
			});
			
		</script>
	</head>
	<body>
        <div class="container-fluid">
            <div class="row" id="div1">
                <div class="col-sm-12">

                    <div class="panel panel-default">
                    
                        <div class="panel-heading">
                        	搜索
                        </div>
                        
                        <div class="panel-body">
                            <form id="form1" role="form" class="form-inline" action="/dsp/role/pageList.do">
                                <div class="form-group">
                                    <label for="roleId">角色id</label>
                                    <input type="text" class="form-control" id="roleId" value="${roleId }" name="roleId" placeholder="请输入id">
                                </div>
                                <div class="form-group">
                                    <label for="roleName">角色名称</label>
                                    <input type="text" class="form-control" id="roleName" value="${roleName }" name="roleName" placeholder="请输入名称">
                                </div>
                                <div class="form-group">
                                    <label for="roleType">角色类型</label>
                                    <select class="form-control" id="roleType" name="roleType">
                                    	  <option></option> 
									      <option value="1" <c:if test="${roleType eq '1' }">selected="selected"</c:if> >资源角色</option> 
									      <option value="2" <c:if test="${roleType eq '2' }">selected="selected"</c:if>>数据角色</option>
									      <option value="3" <c:if test="${roleType eq '3' }">selected="selected"</c:if>>报表角色</option> 
									</select>
                                </div>
                                <div class="form-group">
                                    <button type="button" id="btnSearch" class="btn btn-info">
                                    	<div class="glyphicon glyphicon-search"></div>查询
                                    </button>
                                </div>
                                <div class="form-group" style="margin-left:1% ">
									<a href="#" onclick="openwin()" class="btn btn-success">
								    	<span class="glyphicon glyphicon-plus"></span>新增
								    </a>
                                </div>
                                <input id="page" name="page" type="hidden"/>
								<input id="rows" name="rows" type="hidden"/>
                            </form>
                            
                        </div>
                    </div>
                    
                    <!--列表展示-->
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>角色id</th>
                                    <th>角色名称</th>
                                    <th>角色类型</th>
                                    <th>数据维度</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <tbody>
                            	<c:forEach var="role" items="${roleList.rows}">
                                <tr>
                                    <td>${role.roleId }</td>
                                    <td>${role.roleName }</td>
                                    <td>
                                    	<c:if test="${role.roleType eq '1'}">
                                    		资源角色
                                    	</c:if>
                                    	<c:if test="${role.roleType eq '2'}">
                                    		数据角色
                                    	</c:if>
                                    	<c:if test="${role.roleType eq '3'}">
                                    		报表角色
                                    	</c:if>
                                    </td>
                                    <td>
                                    	<c:forEach var="dic" items="${dictList}">
									      	<c:if test="${dic.paramCode eq role.roleDim}">${dic.paramValue}</c:if>
									     </c:forEach>
                                    </td>
                                    <td>
                                        <div class="btn-group">
                                        	<a href="#" onclick="openRole('${role.roleId }','${role.roleType}','${role.roleDim}')" class="btn btn-default">权限设置</a>
                                            <a href="#" onclick="openEdit('${role.roleId }')" class="btn btn-info">修改</a>
                                            <a href="#" onclick="openDelete('${role.roleId }')" class="btn btn-danger">删除</a>
                                        </div>
                                    </td>
                                </tr>
								</c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <ul class="pagination" style="float: right; margin-top:-15px">
                        <li><a href="#" onclick="getPage(1)">首页</a></li>
                        <li><a href="#" onclick="getPage(${roleList.currPage-1})">上一页</a></li>
                        <li>
                        	<a href="#">
                        	当前<input id="go1" onblur="goPage()" value="${roleList.currPage}" style="width: 30px;height: 16px;text-align: center;font-size:90%;line-height:10px" type="text">/${roleList.totalPage}页 &nbsp;共${roleList.total}条记录
                        	</a>
                        </li>
                        <li><a href="#" onclick="getPage(${roleList.currPage+1})">下一页</a></li>
                        <li><a href="#" onclick="getPage(${roleList.totalPage})">尾页</a></li>
                       
                    </ul>
                </div>
            </div>
        </div>
    </body>
</html>
