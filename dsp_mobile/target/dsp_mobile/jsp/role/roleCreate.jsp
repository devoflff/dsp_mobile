<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<%@include file="../public/metaSet.jsp"%>
		<title>新增角色</title>
		<link type="text/css" rel="stylesheet" href="../css/bootstrap/bootstrap.min.css" />
		<link href="/dsp/css/layer/layer.css" rel="stylesheet" type="text/css" />
		<script type="application/javascript" src="../js/common/jquery-3.2.1.min.js"></script>
		<script type="application/javascript" src="../js/common/bootstrap.min.js"></script>
		<script type="text/javascript" src="/dsp/js/common/layer.js"></script>
		<script type="text/javascript">
			var flag = true;
			$(function() {
				//提交表单
				$('#submitBtn').bind('click', function() {
					var flag1 = true;
					/*判断是否有未填写项*/
					$("#roleId, #roleName").each(function() {
						var temVal = $(this).val();
						if (temVal == null || temVal.length == 0) {
							flag1 = false;
							return false;
						}
					});
	
					//校验通过提交表单
					if (flag && flag1) {
						$("#form1").submit();
					} else {
						return;
					}
				});
	
				//返回
				$('#returnBtn').bind('click',function() {
					parent.window.location.href = "/dsp/role/pageList.do";
					window.close();
				});
	
				/* 新增用户结果提示 */
				var msg = $("#msg").val();
				if (null !== msg && "" !== msg) {
					layer.confirm(msg,{
						btn : [ '关闭' ]//按钮
					},
					function() {
						parent.window.location.href = "/dsp/role/pageList.do";
					});
				}
				
				
				//数据维度显示
				$('#roleType').change(function(){
					var typeValue = $('#roleType').val();
					if(typeValue==2){
						$('#dict').show();
					}else{
						$('#dict').hide();
					}
					
				});
	
			});
	
			/*input校验*/
			var InputValidation = function(inputId, spanId) {
				var temp = $('#' + inputId).val();
				if (temp == null || temp.length == 0) {
					flag = false;
					$('#' + spanId).html("<font color='red'>此为必填项！</font>");
				} else {
					flag = true;
					$('#' + spanId).html("");
				}
			};
	
			/*input校验*/
			var idValidation = function(inputId, spanId) {
				var temp = $('#' + inputId).val();
				if (temp == null || temp.length == 0) {
					flag = false;
					$('#' + spanId).html("<font color='red'>此为必填项！</font>");
				} else {
					$.ajax({
						url : '/dsp/role/getRole.do?roleId='
								+ temp,
						dataType : 'json',
						success : function(value) {
							if (value) {
								$('#' + spanId).html("<font color='red'>已存在的ID</font>");
								flag = false;
							} else {
								flag = true;
								$('#' + spanId).html("");
							}
						},
					});
				}
			};
		</script>
	</head>
	
	<body>
    	<div class="container-fluid">
            <div class="row">
                <div class="col-sm-12" >
                    <div class="panel panel-default" style="width: 80%;margin: 20px auto auto 10%;">
                        <div class="panel-heading" style="display: none;">
                            	新增角色
                        </div>
                        <div class="panel-body">
                         
							<form id="form1" class="form-horizontal" role="form" action="/dsp/role/insert.do">
								<div class="form-group">
									<label for="roleId" class="col-sm-2 control-label">角色Id</label>
									<div class="col-sm-6">
										<input type="text" class="form-control" id="roleId" name="roleId" value="" placeholder="请输入Id" onblur="idValidation('roleId','span1')">
									</div>
									<div class="col-sm-4">
										<span id="span1" class="text-control"></span>
									</div>
								</div>
								<div class="form-group">
									<label for="roleName" class="col-sm-2 control-label">角色名称</label>
									<div class="col-sm-6">
										<input type="text" class="form-control" id="roleName" name="roleName" value="" placeholder="请输入名称" onblur="InputValidation('roleName','span2')">
									</div>
									<div class="col-sm-4">
										<span id="span2" class="text-control"></span>
									</div>
								</div>
								<div class="form-group">
									<label for="roleType" class="col-sm-2 control-label">角色类型</label>
									<div class="col-sm-6">
										<select class="form-control" id="roleType" name="roleType"> 
									      	<option value="1">资源角色</option> 
									      	<option value="2">数据角色</option>
									      	<option value="3">报表角色</option>
										</select>
									</div>
									<div class="col-sm-4">
										<span id="span3" class="text-control"></span>
									</div>
								</div>
								
								<div class="form-group" id="dict" style="display: none;">
									<label for="roleDim" class="col-sm-2 control-label">数据维度</label>
									<div class="col-sm-6">
										<select class="form-control" id="roleDim" name="roleDim"> 
											<c:forEach var="dict" items="${dictList }">
												<option value="${dict.paramCode}">${dict.paramValue }</option>
											</c:forEach>
										</select>
									</div>
									<div class="col-sm-4">
										<span id="span4" class="text-control"></span>
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
</body>
</html>
