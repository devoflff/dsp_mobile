<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>资源编辑</title>
		<link type="text/css" rel="stylesheet" href="../css/bootstrap/bootstrap.min.css" />
		<link href="/dsp/css/layer/layer.css" rel="stylesheet" type="text/css" />
		<script type="application/javascript" src="../js/common/jquery-3.2.1.min.js"></script>
		<script type="application/javascript" src="../js/common/bootstrap.min.js"></script>
		<script type="text/javascript" src="/dsp/js/common/layer.js"></script>
		<script>
			var flag = true;
			$(function(){
				//提交表单
				$('#submitBtn').bind('click',function(){
					var flag1=true;
					/*判断是否有未填写项*/
					$("#userId, #userName, #passwd").each(function(){
					    var temVal = $(this).val();
					    if(temVal==null||temVal.length==0){
							flag1=false;
							return false;
						}
					});
					
					//校验通过提交表单
					if(flag&&flag1){
						$("#form1").submit();
					}else{
						return;
					}
				});
				
				//返回
				$('#returnBtn').bind('click',function(){
					parent.window.location.href="/dsp/menu/menuList.do";
				});
				
				/* 修改用户结果提示 */
				var msg = $("#msg").val();
				if (null !== msg && "" !== msg) {
					layer.confirm(msg,{
						btn : [ '关闭' ]//按钮
					},
					function() {
						parent.window.location.href = "/dsp/menu/menuList.do";
					});
				}
				
			});
			
			/*input校验*/
			var InputValidation=function(inputId,spanId){
					var temp = $('#'+inputId).val();
					if(temp==null||temp.length==0){
						flag = false;
						$('#'+spanId).html("<font color='red'>此为必填项！</font>");
					}else{
						flag = true;
						$('#'+spanId).html("");
					}
				}
			
		</script>
	</head>
	
	<body">
    	<div class="container-fluid">
            <div class="row">
                <div class="col-sm-12">
                    <div class="panel panel-default" style="width: 80%;margin: 20px auto auto 10%;">
                        <div class="panel-heading" style="display: none;">
                            	资源编缉
                        </div>
                        <div class="panel-body">
							<form id="form1" class="form-horizontal" role="form" action="/dsp/menu/update.do">
								<div class="form-group">
									<label for="resourceId" class="col-sm-2 control-label">资源Id</label>
									<div class="col-sm-6">
										<input type="text" readonly="readonly" class="form-control" id="resourceId" name="resourceId" value="${menu.resourceId}" placeholder="请输入Id" onblur="InputValidation('resourceId','span1')">
									</div>
									<div class="col-sm-4">
										<span id="span1" class="text-control"></span>
									</div>
								</div>
								<div class="form-group">
									<label for="resourceName" class="col-sm-2 control-label">资源名称</label>
									<div class="col-sm-6">
										<input type="text" class="form-control" id="resourceName" name="resourceName" value="${menu.resourceName}" placeholder="请输入姓名" onblur="InputValidation('resourceName','span2')">
									</div>
									<div class="col-sm-4">
										<span id="span2" class="text-control"></span>
									</div>
								</div>
								
								<div class="form-group">
									<label for="resourceUrl" class="col-sm-2 control-label">资源URL</label>
									<div class="col-sm-6">
										<input type="text" class="form-control" id="resourceUrl" name="resourceUrl" value="${menu.resourceUrl}" placeholder="请输入密码" onblur="InputValidation('resourceUrl','span3')">
									</div>
									<div class="col-sm-4">
										<span id="span3" class="text-control"></span>
									</div>
								</div>
								
								<div class="form-group">
									<label for="resourceType" class="col-sm-2 control-label">资源类型</label>
									<div class="col-sm-6">
										<select class="form-control" id="resourceType" name="resourceType"> 
											<c:if test="${menu.resourceType==1}">
												<option value="1" selected="selected">页面</option> 
									      		<option value="2">按钮</option>
									      		<option value="3">模块</option>
											</c:if>
											<c:if test="${menu.resourceType==2}">
												<option value="1">页面</option> 
									      		<option value="2" selected="selected">按钮</option>
									      		<option value="3">模块</option>
											</c:if>
											<c:if test="${menu.resourceType==3}">
												<option value="1">页面</option> 
									      		<option value="2">按钮</option>
									      		<option value="3" selected="selected">模块</option>
											</c:if>
										</select>
									</div>
									<div class="col-sm-4">
										<span id="span4" class="text-control"></span>
									</div>
								</div>
								
								<div class="form-group">
									<label for="resourcePosition" class="col-sm-2 control-label">上级资源</label>
									<div class="col-sm-6">
 										<select class="form-control selectpicker show-tick" id="resourcePosition" name="resourcePosition">
 										<c:forEach var="resource" items="${menuList}">
  										<c:if test="${fn:length(resource.resourceId) eq '4'}">
 										<option value="${resource.resourceId }" <c:if test="${menu.resourcePosition==resource.resourceId}">selected="selected"</c:if>>${resource.resourceName }</option>
 										</c:if>	
 										<c:if test="${fn:length(resource.resourceId) eq '7'}">
 										<option value="${resource.resourceId }" <c:if test="${menu.resourcePosition==resource.resourceId}">selected="selected"</c:if>>&nbsp;&nbsp;&nbsp;${resource.resourceName }</option>
 										</c:if>
 										<c:if test="${fn:length(resource.resourceId) eq '10'}">
 										<option value="${resource.resourceId }" <c:if test="${menu.resourcePosition==resource.resourceId}">selected="selected"</c:if>>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${resource.resourceName }</option>
 										</c:if>
 										</c:forEach>
 										</select>
									</div>
									<div class="col-sm-4">
										<span id="span5" class="text-control"></span>
									</div>
								</div>
								
								<div class="form-group">
									<label for="isNavigation" class="col-sm-2 control-label">是否为页面导航</label>
									<div class="col-sm-6">
										<select class="form-control" id="isNavigation" name="isNavigation"> 
											<c:if test="${menu.isNavigation=='Y'}">
												<option value="Y" selected="selected">是</option> 
									      		<option value="N">否</option>
											</c:if>
											<c:if test="${menu.isNavigation=='N'}">
												<option value="Y">是</option> 
									      		<option value="N" selected="selected">否</option>
											</c:if>
										</select>
									</div>
									<div class="col-sm-4">
										<span id="span6" class="text-control"></span>
									</div>
								</div>
								
								<div class="form-group">
									<div class="col-sm-offset-2 col-sm-6">
										<button id="returnBtn" type="button" class="btn btn-default">返回</button>
										<button id="submitBtn" type="button" class="btn btn-default">提交</button>
										<input id="msg" name="msg" type="hidden" value="${msg}"></input>
									</div>
								</div>
 							</form>
                            
                        </div>
                    </div>    
                </div>
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
