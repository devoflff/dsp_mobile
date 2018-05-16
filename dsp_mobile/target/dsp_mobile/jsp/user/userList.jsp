<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<%@include file="../public/metaSet.jsp"%>
		<title>用户列表</title>
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
					title: '新增用户',
					shadeClose: true,
					shade: false,
					maxmin: true, //开启最大化最小化按钮
					area: ['800px', '500px'],
					content: '${pageContext.request.contextPath}/user/create.do'
				});
			}
			
			function openEdit(userId){
				layer.open({
					type: 2,
					title: '编辑用户',
					shadeClose: true,
					shade: false,
					maxmin: true, //开启最大化最小化按钮
					area: ['800px', '500px'],
					content: '${pageContext.request.contextPath}/user/edit.do?userId='+userId
				});
			}
			
			function openRole(userId,roleType){
				layer.open({
					type: 2,
					title: '用户角色设置',
					shadeClose: true,
					shade: false,
					maxmin: true, //开启最大化最小化按钮
					area: ['800px', '500px'],
					content: '/dsp/user/toRole.do?userId='+userId+'&roleType='+roleType
				});
			}
			
			//删除
			function openDelete(userId){
				 layer.confirm(DELETEMSG, function (index) {
					 layer.close(index);  
		              $.post("/dsp/user/delete.do", { userId:userId }, function (data) {  
		            	  window.location.href = "/dsp/user/pageList.do";
		                });  
				 });
			}
			
			function getPage(currPage){
				if(currPage<1||currPage>${userList.totalPage}){
					return;
				}
				$("#page").val(currPage);
				$("#rows").val(rows);
				$("#form1").submit();
			}
			
			//跳转
			function goPage(){
				var page = $("#go1").val();
				if(page==${userList.currPage}){
					return;
				}
				if(page<1){
					$("#page").val(1);
				}else if(page>${userList.totalPage}){
					$("#page").val(${userList.totalPage});
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
                            <form id="form1" role="form" class="form-inline" action="${pageContext.request.contextPath}/user/pageList.do">
                                <div class="form-group">
                                    <label for="userId">用户id</label>
                                    <input type="text" value="${userId}" class="form-control" id="userId" name="userId" placeholder="请输入id">
                                </div>
                                <div class="form-group">
                                    <label for="userName">姓名</label>
                                    <input type="text" value="${userName}" class="form-control" id="userName" name="userName" placeholder="请输入姓名">
                                </div>
                                <div class="form-group">
                                    <label for="department">部门</label>
                                    <input type="text" value="${department}" class="form-control" id="department" name="department" placeholder="请输入部门">
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
                        <table class="table table-bordered" style="table-layout:fixed">
                            <thead>
                                <tr>
                                    <th style="width:12%">用户id</th>
                                    <th style="width:12%">用户姓名</th>
                                    <th style="width:12%">部门</th>
                                    <th style="width:28%">邮件</th>
                                    <th style="width:36%">操作</th>
                                </tr>
                            </thead>
                            <tbody>
                            	<c:forEach var="user" items="${userList.rows}">
                                <tr>
                                    <td>${user.userId }</td>
                                    <td>${user.userName }</td>
                                    <td>${user.department }</td>
                                    <td>${user.mail }</td>
                                    <td>
                                        <div class="btn-group">
                                        	<a href="#" onclick="openRole('${user.userId}','1')" class="btn btn-default">资源授权</a>
                                        	<a href="#" onclick="openRole('${user.userId}','3')" class="btn btn-default">报表授权</a>
                                        	<a href="#" onclick="openRole('${user.userId}','2')" class="btn btn-default">数据授权</a>
                                            <a href="#" onclick="openEdit('${user.userId}')" class="btn btn-info">修改</a>
                                            <a href="#" onclick="openDelete('${user.userId}')" class="btn btn-danger">删除</a>
                                        </div>
                                    </td>
                                </tr>
								</c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <ul class="pagination" style="float: right;margin-top:-15px">
                        <li><a href="#" onclick="getPage(1)">首页</a></li>
                        <li><a href="#" onclick="getPage(${userList.currPage-1})">上一页</a></li>
                        <li>
                        	<a href="#">
                        	当前<input id="go1" onblur="goPage()" value="${userList.currPage}" style="width: 30px;height: 16px;text-align: center;font-size:90%;line-height:10px" type="text">/${userList.totalPage}页 &nbsp;共${userList.total}条记录
                        	</a>
                        </li>
                        <li><a href="#" onclick="getPage(${userList.currPage+1})">下一页</a></li>
                        <li><a href="#" onclick="getPage(${userList.totalPage})">尾页</a></li>
                       
                    </ul>
                </div>
            </div>
        </div>
    </body>
</html>
