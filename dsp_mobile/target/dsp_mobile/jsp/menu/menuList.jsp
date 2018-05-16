<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta charset="UTF-8">
		<title>资源列表</title>
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
					title: '新增资源',
					shadeClose: true,
					shade: false,
					maxmin: true, //开启最大化最小化按钮
					area: ['800px', '500px'],
					content: '/dsp/menu/create.do'
				});
			}
			
			function openEdit(resourceId){
				layer.open({
					type: 2,
					title: '编辑资源',
					shadeClose: true,
					shade: false,
					maxmin: true, //开启最大化最小化按钮
					area: ['800px', '500px'],
					content: '/dsp/menu/edit.do?resourceId='+resourceId
				});
			}
			
			//删除
			function openDelete(resourceId){
				 layer.confirm(DELETEMSG, function (index) {
					 layer.close(index);  
		              $.post("/dsp/menu/delete.do", { resourceId:resourceId }, function (data) {  
		            	  window.location.href = "/dsp/menu/menuList.do";
		                });  
				 });
			}
			
			function getPage(currPage){
				if(currPage<1||currPage>${menuList.totalPage}){
					return;
				}
				$("#page").val(currPage);
				$("#rows").val(rows);
				$("#form1").submit();
			}
			
			//跳转
			function goPage(){
				var page = $("#go1").val();
				if(page==${menuList.currPage}){
					return;
				}
				if(page<1){
					$("#page").val(1);
				}else if(page>${menuList.totalPage}){
					$("#page").val(${menuList.totalPage});
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
                            <form id="form1" role="form" class="form-inline" action="/dsp/menu/menuList.do">
                                <div class="form-group">
                                    <label for="resourceId">资源Id</label>
                                    <input type="text" class="form-control" id="resourceId" name="resourceId"
                                    value="${resourceId}" placeholder="请输入id">
                                </div>
                                <div class="form-group">
                                    <label for="resourceName">资源名称</label>
                                    <input type="text" class="form-control" id="resourceName" name="resourceName" 
                                     value="${resourceName}" placeholder="请输入名称">
                                </div>
                                <div class="form-group">
                                    <label for="resourceType">资源类型</label>
                                    <select class="form-control" id="resourceType" name="resourceType">
                                    	 <option value="">所有</option> 
										 <option value="1" <c:if test="${resourceType eq '1' }"> selected="selected" </c:if> >页面</option> 
										 <option value="2" <c:if test="${resourceType eq '2' }"> selected="selected" </c:if> >按钮</option>
										 <option value="3" <c:if test="${resourceType eq '3' }"> selected="selected" </c:if> >模块</option>  
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
                        <table class="table table-bordered" style="table-layout:fixed">
                            <thead>
                                <tr>
                                    <th style="width:10%">资源id</th>
                                    <th style="width:10%">资源名称</th>
                                    <th style="width:20%">资源地址</th>
                                    <th style="width:5%">资源类型</th>
                                    <th style="width:10%">上级资源</th>
                                    <th style="width:10%">是否为页面导航</th>
                                    <th style="width:10%">操作</th>
                                </tr>
                            </thead>
                            <tbody>
                            	<c:forEach var="menu" items="${menuList.rows}">
                                <tr>
                                    <td>${menu.resourceId }</td>
                                    <td>${menu.resourceName }</td>
                                    <td>${menu.resourceUrl }</td>
                                    <td>
                                    	<c:if test="${menu.resourceType==1}">页面</c:if>    
										<c:if test="${menu.resourceType==2}">按钮</c:if>
										<c:if test="${menu.resourceType==3}">模块</c:if>
                                   </td>
                                   <td>${menu.resourcePosition }</td>
                                   <td>
                                   		<c:if test="${menu.isNavigation=='Y'}">是</c:if>    
										<c:if test="${menu.isNavigation=='N'}">否</c:if>
                                   </td>
                                    <td>
                                        <div class="btn-group">
                                            <a href="#" onclick="openEdit('${menu.resourceId}')" class="btn btn-default">修改</a>
                                            <a href="#" onclick="openDelete('${menu.resourceId}')" class="btn btn-danger">删除</a>
                                         </div>
                                    </td>
                                </tr>
								</c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <ul class="pagination" style="float: right; margin-top:-15px">
                        <li><a href="#" onclick="getPage(1)">首页</a></li>
                        <li><a href="#" onclick="getPage(${menuList.currPage-1})">上一页</a></li>
                        <li>
                        	<a href="#">
                        	当前<input id="go1" onblur="goPage()" value="${menuList.currPage}" style="width: 30px;height: 16px;text-align: center;font-size:90%;line-height:10px" type="text">/${menuList.totalPage}页 &nbsp;共${menuList.total}条记录
                        	</a>
                        </li>
                        <li><a href="#" onclick="getPage(${menuList.currPage+1})">下一页</a></li>
                        <li><a href="#" onclick="getPage(${menuList.totalPage})">尾页</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </body>
</html>
