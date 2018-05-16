  <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<%@include file="../public/metaSet.jsp"%>
		<title>任务执行列表</title>
		<link type="text/css" rel="stylesheet" href="../css/bootstrap/bootstrap.min.css" />
		<link href="/dsp/css/layer/layer.css" rel="stylesheet" type="text/css" />
		<script type="application/javascript" src="../js/common/jquery-3.2.1.min.js"></script>
		<script type="application/javascript" src="../js/common/bootstrap.min.js"></script>
		<script type="text/javascript" src="/dsp/js/common/layer.js"></script>
		<script type="text/javascript" src="/dsp/js/globalVal.js"></script>
		<script type="text/javascript" src="/dsp/js/ops/task.js"></script>
		<style>
			.table th,
			#div1{
				padding-top: 10px;
			}
		</style>
		<script type="text/javascript">
			
			function getPage(currPage){
				if(currPage<1||currPage>${taskList.totalPage}){
					return;
				}
				$("#page").val(currPage);
				$("#rows").val(rows);
				$("#form1").submit();
			};
			
			//跳转
			function goPage(){
				var page = $("#go1").val();
				if(page==${taskList.currPage}){
					return;
				}
				if(page<1){
					$("#page").val(1);
				}else if(page>${taskList.totalPage}){
					$("#page").val(${taskList.totalPage});
				}else{
					$("#page").val(page);
				}
				$("#rows").val(rows);
				$("#form1").submit();
			};
			
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
                        
                        <div class="panel-body" style="width: 100%">
                            <form id="form1" role="form" class="form-inline" action="/dsp/ops/taskList.do">
                                <div class="form-group" style="padding-bottom: 5px;width: 25%">
                                    <label for="报表名称">报表名称</label>
                                    <input type="text" class="form-control" id="reportName"  style="width:185px"
                                    value="${reportName}" name="reportName" placeholder="请输入名称">
                                </div>
                                
                                <div class="form-group" style="padding-bottom: 5px;width: 25%">
                                    <label for="reportBussOwner">业务联系人</label>
                                    <input style="width: 185px" type="text" class="form-control" id="reportBussOwner" 
                                    value="${reportBussOwner}" name="reportBussOwner" placeholder="请输入联系人">
                                </div>
                                <div class="form-group" style="padding-bottom: 5px;width: 25%">
                                    <label for="reportItOwner">IT联系人</label>
                                    <input style="width: 185px" type="text" class="form-control" id="reportItOwner" 
                                    value="${reportItOwner}" name="reportItOwner" placeholder="请输入联系人">
                                </div>
                                
                                <div class="form-group" style="padding-bottom: 5px;width: 20%">
                                    <label for="excute">是否执行</label>
                                    <select class="form-control" id="excute" name="excute"> 
                                          <option value="" <c:if test="${reportType eq '' }">selected="selected"</c:if> >所有</option>
									      <option value="Y" <c:if test="${excute eq 'Y' }">selected="selected"</c:if> >已执行</option> 
									      <option value="N" <c:if test="${excute eq 'N' }">selected="selected"</c:if> >未执行</option>
									</select>
                                </div>
                                <div class="form-group"  style="padding-bottom: 5px;width: 25%">
                                    <label for="startDate">开始时间</label>
                                    <input type="text" class="form-control" id="startDate" name="startDate" value="${startDate }" style="width:185px" placeholder="yyyy-mm-dd">
                                </div>
	                            <div class="form-group" style="padding-bottom: 5px;width: 25%">
	                                 <label for="endDate"><span style="padding-left: 14px">结束时间</span></label>
	                                 <input type="text" class="form-control" id="endDate" name="endDate" value="${endDate }" style="width:185px" placeholder="yyyy-mm-dd">
	                            </div>
	                             <div class="form-group" style="padding-bottom: 5px;width: 25%">
                                    <label for="reportType">报表类型</label>
                                    <select class="form-control" id="reportType" name="reportType" style="width: 185px" > 
                                          <option value="" <c:if test="${reportType eq '' }">selected="selected"</c:if> >所有报表</option>
									      <c:forEach var="dic" items="${dictList}">
									      		<option value="${dic.paramCode}" <c:if test="${reportType eq dic.paramCode }">selected="selected"</c:if> >${dic.paramValue}</option>
									      </c:forEach>
									     <%--  <option value="1" <c:if test="${reportType eq '1' }">selected="selected"</c:if> >ISQL报表</option> 
									      <option value="2" <c:if test="${reportType eq '2' }">selected="selected"</c:if> >ESQL报表</option>
									      <option value="3" <c:if test="${reportType eq '3' }">selected="selected"</c:if> >通用报表</option>
									      <option value="4" <c:if test="${reportType eq '4' }">selected="selected"</c:if> >手工报表</option>  --%>
									</select>
                                </div>   
                                
                                <div class="form-group" style="padding-bottom: 5px">
                                    <button type="button" id="btnSearch" class="btn btn-info">
                                    	<div class="glyphicon glyphicon-search"></div>查询
                                    </button>
                                </div>
                                    <input id="page" name="page" type="hidden"/>
									<input id="rows" name="rows" type="hidden"/>
                            		<input id="msg" name="msge" value="${msg}" type="hidden"/>
                            </form>
                            
                        </div>
                    </div>
                    
                    <!--列表展示-->
                    <!-- <div class="table-responsive" style="padding-top: 16px">
	                    <ul class="pagination"  style="float:left;margin-top:-15px">
	                 		<li>
	                 			<a href="#" id="a1">全部暂停</a>
	                 		</li>
	                 		<li>
	                 			<a href="#" id="a1">全部开启</a>
	                 		</li>
	                 	</ul>
                 	</div> -->
                    <div class="table-responsive">
                    	<form id="form2" action="/dsp/ops/dotask.do" method="post">
                        <table id="tb1" class="table table-bordered" style="table-layout:fixed">
                            <thead>
                                <tr>
                                	<th style="width:3%"><input type="checkbox" id="checkAll" name="checkAll" /></th>
                                    <th style="width:10%">任务名称</th>
                                    <th style="width:10%">执行时间</th>
                                    <th style="width:12%">报表名称</th>
                                    <th style="width:8%">报表类型</th>
                                    <th style="width:8%">业务联系人</th>
                                    <th style="width:8%">IT联系人</th>
                                    <th style="width:15%">参数</th>
                                    <th style="width:10%">规则</th>
                                    <th style="width:8%">描述</th>
                                    <th style="width:8%">是否执行</th>
                                </tr>
                            </thead>
                            <tbody>
                            	<c:forEach var="task" items="${taskList.rows}">
                                <tr>
                                	<td><input type="checkbox" name="checkItem" value="${task.idTaskLog }"/></td>
                                    <td>${task.jobName }</td>
                                    <td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis" title="${task.operationDate }">${task.operationDate }</td>
                                    <td style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis" title="${task.reportName }" >${task.reportName }</td>
                                   
                                   <td style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis">
                                    	  <c:forEach var="dic" items="${dictList}">
									      		<c:if test="${task.reportType eq dic.paramCode}">${dic.paramValue}</c:if>
									      </c:forEach>
                                    </td>
                                   
                                    <%-- <c:if test="${task.reportType eq '1'}">
                                    	<td style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis">ISQL报表</td>
                                    </c:if>
                                    <c:if test="${task.reportType eq '2'}">
                                    	<td style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis">ESQL报表</td>
                                    </c:if>
                                    <c:if test="${task.reportType eq '3'}">
                                    	<td style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis">通用报表</td>
                                    </c:if>
                                    <c:if test="${task.reportType eq '4'}">
                                    	<td style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis">手工报表</td>
                                    </c:if> --%>
                                    <td style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis" title="${task.reportBussOwner}">${task.reportBussOwner}</td>
                                    <td style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis" title="${task.reportItOwner }">${task.reportItOwner }</td>
                                    <td style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis" title=${task.paramValue }>${task.paramValue }</td>
                                    <td style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis" title="${task.cron }">${task.cron }</td>
                                    <td style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis" title="${task.description }">${task.description }</td>
                                    <td class="tdExcute"><c:if test="${task.excute eq 'N'}">未执行</c:if><c:if test="${task.excute eq 'Y'}">已执行</c:if></td>
                                </tr>
								</c:forEach>
                            </tbody>
                        </table>
                        </form>
                    </div>
                 	<ul class="pagination"  style="float:left;margin-top:-10px">
                 		<li>
	                 		<a href="#" id="a1">执行选中任务</a>
	                 	</li>
	                 	<li>
	                 		<a href="#" id="a2">暂停所有任务</a>
	                 	</li>
                 		<li>
                 			<a href="#" id="a3">开启所有任务</a>
                 		</li>
                 	</ul>
                    <ul class="pagination" style="float:right;margin-top:-10px" >
                        <li><a href="#" onclick="getPage(1)">首页</a></li>
                        <li><a href="#" onclick="getPage(${taskList.currPage-1})">上一页</a></li>
                        <li>
                        	<a href="#">
                        		当前<input id="go1" onblur="goPage()" value="${taskList.currPage}" style="width:30px; height:16px;font-size:90%;text-align:center;line-height:10px" type="text">
                        		/
                        		${taskList.totalPage}页 &nbsp;共${taskList.total}条记录
                        	</a>
                        </li>
                        <li><a href="#" onclick="getPage(${taskList.currPage+1})">下一页</a></li>
                        <li><a href="#" onclick="getPage(${taskList.totalPage})">尾页</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </body>
</html>
<script type="text/javascript" src="/dsp/js/common/laydate/laydate.js"></script> 
<script type="text/javascript">
			laydate.render({
			  elem: '#startDate',
			  trigger: 'click' ,
		      showBottom: false
			});
			laydate.render({
		      elem: '#endDate',
		      trigger: 'click' ,
		      showBottom: false
			});
</script>
