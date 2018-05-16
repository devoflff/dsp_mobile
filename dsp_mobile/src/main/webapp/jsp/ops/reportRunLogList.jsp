<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<%@include file="../public/metaSet.jsp"%>
		<title>报表运行监控</title>
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
		
		//查看	
		function openReport(reportId){
			parent.layer.open({
				type: 2,
				shadeClose: true,
				shade: false,
				maxmin: true, //开启最大化最小化按钮
				area: ['98%', '600px'],
				content: '/dsp/ops/getRunLog.do?reportId='+reportId
			});
		};
			
			function getPage(currPage){
				if(currPage<1||currPage>${reportList.totalPage}){
					return;
				}
				$("#page").val(currPage);
				$("#rows").val(rows);
				$("#form1").submit();
			}
			
			//跳转
			function goPage(){
				var page = $("#go1").val();
				if(page==${reportList.currPage}){
					return;
				}
				if(page<1){
					$("#page").val(1);
				}else if(page>${reportList.totalPage}){
					$("#page").val(${reportList.totalPage});
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
                            <form id="form1" role="form" class="form-inline" action="/dsp/ops/runReport.do">
                                <div class="form-group">
                                    <label for="operationName">报表名称</label>
                                    <input type="text" value="${reportName}" class="form-control" id="reportName" name="reportName" placeholder="请输报表名称" style="width: 140px">
                                </div>
                                
                                <div class="form-group" >
                                    <label for="operationName">业务联系人</label>
                                    <input type="text" style="width: 140px" value="${reportBussOwner}" class="form-control" id="reportBussOwner" name="reportBussOwner" placeholder="请输业务属主">
                                </div>
                               
                               <div class="form-group" >
                                    <label for="operationName">IT联系人</label>
                                    <input type="text" style="width: 140px" value="${reportItOwner}" class="form-control" id="reportItOwner" name="reportItOwner" placeholder="请输IT属主" >
                                </div>
                                
                                <div class="form-group" >
                                    <label for="timeSet">耗时超过(秒)</label>
                                    <input id="timeSet" name="timeSet" value="${timeSet }" type="text" class="form-control" style="width: 80px" placeholder="60" >
                                </div>
                                
                                <div class="form-group">
                                    <label for="reportType">报表类型   </label>
                                    <select class="form-control" id="reportType" name="reportType"> 
                                          <option value="" <c:if test="${reportType eq '' }">selected="selected"</c:if> >所有报表</option>
									      <c:forEach var="dic" items="${dictList}">
									      		<option value="${dic.paramCode}" <c:if test="${reportType eq dic.paramCode }">selected="selected"</c:if> >${dic.paramValue}</option>
									      </c:forEach>	
									      <%-- <option value="1" <c:if test="${reportType eq '1' }">selected="selected"</c:if> >ISQL报表</option> 
									      <option value="2" <c:if test="${reportType eq '2' }">selected="selected"</c:if> >ESQL报表</option>
									      <option value="3" <c:if test="${reportType eq '3' }">selected="selected"</c:if> >通用报表</option>
									      <option value="4" <c:if test="${reportType eq '4' }">selected="selected"</c:if> >手工报表</option> 
                                     	  <option value="MOBILE" <c:if test="${reportType eq 'MOBILE' }">selected="selected"</c:if>>移动报表</td> --%>
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
                        <table class=" table table-bordered" style="table-layout:fixed">
                            <thead>
                                <tr>
                                    <th style="width:20%">报表名称</th>
                                    <th style="width:16%">开始时间</th>
                                    <th style="width:16%">结束日期</th>
                                    <th style="width:10%">耗时(秒)</th>
                                    <th style="width:8%">状态</th>
                                    <th style="width:10%">业务联系人</th>
                                    <th style="width:10%">IT联系人</th>
                                 <!--   <th style="width:12%">创建人</th>-->
                                    <th style="width:10%">操作</th>
                                </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="report" items="${reportList.rows}">
                                <tr>
                                    <td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis" title="${report.reportName }">${report.reportName }</td>
                                    <td style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis"  ><fmt:formatDate value="${report.createdDate }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                    <td style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis"  ><fmt:formatDate value="${report.updatedDate }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                    <td><fmt:formatNumber value="${((report.updatedDate.time-report.createdDate.time)/1000)}" pattern="#0" /></td>
                                    <td><c:if test="${report.updatedBy eq 'RUNNING'}">
		                                    	执行中
		                                    </c:if>
		                                    <c:if test="${report.updatedBy eq 'FINISHED'}">
		                                    	完成
		                                    </c:if>
		                                    <c:if test="${report.updatedBy eq 'ERROR'}">
		                                    	 运行出错
		                                    </c:if></td>
                                    <td style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis" title="${report.reportBussOwner}">${report.reportBussOwner}</td>
                                    <td style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis" title="${report.reportItOwner }">${report.reportItOwner }</td>
                                   <!--  <td> ${report.createdBy}</td>-->
                                      <td>
                                        <div class="btn-group">
 	                                        	<a href="#" onclick="openReport('${report.reportId }')" class="btn btn-success">查看</a>
                                         </div>
                                    </td>
                                 </tr>
								</c:forEach>
                             </tbody>
                        </table>
                    </div>
                    <ul class="pagination" style="float: right;margin-top:-15px">
                        <li><a href="#" onclick="getPage(1)">首页</a></li>
                        <li><a href="#" onclick="getPage(${reportList.currPage-1})">上一页</a></li>
                        <li>
                        	<a href="#">
                        	当前<input id="go1" onblur="goPage()" value="${reportList.currPage}" style="width: 30px;height: 16px;text-align: center;font-size:90%;line-height:10px" type="text">/${reportList.totalPage}页 &nbsp;共${reportList.total}条记录
                        	</a>
                        </li>
                        <li><a href="#" onclick="getPage(${reportList.currPage+1})">下一页</a></li>
                        <li><a href="#" onclick="getPage(${reportList.totalPage})">尾页</a></li>
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