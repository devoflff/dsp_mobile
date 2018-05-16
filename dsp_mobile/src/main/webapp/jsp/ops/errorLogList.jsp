<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<%@include file="../public/metaSet.jsp"%>
		<title>系统监控日志列表</title>
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
			
			//删除
			function openDeal(idErrorLog){
				 layer.confirm("您确定处理完成了吗？", function (index) {
					 layer.close(index);  
		              $.post("/dsp/ops/resolve.do", { idErrorLog:idErrorLog }, function (data) {  
		            	  window.location.href = "/dsp/ops/pageList.do";
		                });  
				 });
			}
			
			function getPage(currPage){
				if(currPage<1||currPage>${errorLogList.totalPage}){
					return;
				}
				$("#page").val(currPage);
				$("#rows").val(rows);
				$("#form1").submit();
			}
			
			//跳转
			function goPage(){
				var page = $("#go1").val();
				if(page==${errorLogList.currPage}){
					return;
				}
				if(page<1){
					$("#page").val(1);
				}else if(page>${errorLogList.totalPage}){
					$("#page").val(${errorLogList.totalPage});
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
                            <form id="form1" role="form" class="form-inline" action="/dsp/ops/pageList.do">
                                <div class="form-group">
                                    <label for="operationName">操作名称</label>
                                    <input type="text" value="${operationName}" class="form-control" id="operationName" name="operationName" placeholder="请输操作名称">
                                </div>
                                
                                <div class="form-group">
                                    <label for="lvl">日志级别</label>
                                    <select class="form-control" id="lvl" name="lvl">
                                    	  <option></option> 
									      <option value="INFO" <c:if test="${lvl eq 'INFO' }">selected="selected"</c:if> >INFO</option> 
									      <option value="ERROR" <c:if test="${lvl eq 'ERROR' }">selected="selected"</c:if>>ERROR</option>
									      <option value="WARNING" <c:if test="${lvl eq 'WARNING' }">selected="selected"</c:if>>WARNING</option> 
									</select>
                                </div>
                                <div class="form-group">
                                    <label for="status">状态</label>
                                    <select class="form-control" id="status" name="status">
                                    	  <option></option> 
									      <option value="ERROR" <c:if test="${status eq 'ERROR' }">selected="selected"</c:if>>报错</option> 
									      <option value="DOING" <c:if test="${status eq 'DOING' }">selected="selected"</c:if>>处理中</option>
									      <option value="FINISHED" <c:if test="${status eq 'FINISHED' }">selected="selected"</c:if>>已处理</option> 
									</select>
                                </div>
                               
                                <div class="form-group">
                                    <button type="button" id="btnSearch" class="btn btn-info">
                                    	<div class="glyphicon glyphicon-search"></div>查询
                                    </button>
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
                                    <th style="width:12%">操作名称</th>
                                    <th style="width:10%">操作人</th>
                                    <th style="width:14%">操作日期</th>
                                    <th style="width:10%">日志级别</th>
                                    <th style="width:10%">是否发送邮件</th>
                                    <th style="width:24%">错误信息</th>
                                    <th style="width:10%">状态</th>
                                    <th style="width:10%">操作</th>
                                </tr>
                            </thead>
                            <tbody>
                            	<c:forEach var="errorLog" items="${errorLogList.rows}">
                                <tr>
                                    <td>${errorLog.operationName }</td>
                                    <td>${errorLog.operationBy }</td>
                                    <td>
                                    <fmt:formatDate value="${errorLog.operationDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td>${errorLog.lvl }</td>
                                    <td>
                                    	<c:if test="${errorLog.isSendMail eq 'Y'}">
		                                                                                         是
		                                </c:if>
		                                <c:if test="${errorLog.isSendMail eq 'N'}">
		                                   	否
		                                </c:if>
                                    </td>
                                    <td>${errorLog.errorMsg }</td>
                                    <td>
                                    	<c:if test="${errorLog.status eq 'ERROR'}">
		                                                                                          错误                                                    
		                                </c:if>
		                                <c:if test="${errorLog.status eq 'DOING'}">
		                                   	处理中
		                                </c:if>
		                                <c:if test="${errorLog.status eq 'FINISHED'}">
		                                   	处理完成
		                                </c:if>
                                    </td>
                                    <td>
                                        <div class="btn-group">
	                                        <c:if test="${errorLog.status eq 'DOING'}">
	                                        	<a href="#" onclick="openDeal('${errorLog.idErrorLog}')" class="btn btn-success">处理完成</a>
			                                </c:if>
                                        </div>
                                    </td>
                                </tr>
								</c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <ul class="pagination" style="float: right;margin-top:-15px">
                        <li><a href="#" onclick="getPage(1)">首页</a></li>
                        <li><a href="#" onclick="getPage(${errorLogList.currPage-1})">上一页</a></li>
                        <li>
                        	<a href="#">
                        	当前<input id="go1" onblur="goPage()" value="${errorLogList.currPage}" style="width: 30px;height: 16px;text-align: center;font-size:90%;line-height:10px" type="text">/${errorLogList.totalPage}页 &nbsp;共${errorLogList.total}条记录
                        	</a>
                        </li>
                        <li><a href="#" onclick="getPage(${errorLogList.currPage+1})">下一页</a></li>
                        <li><a href="#" onclick="getPage(${errorLogList.totalPage})">尾页</a></li>
                       
                    </ul>
                </div>
            </div>
        </div>
    </body>
</html>
