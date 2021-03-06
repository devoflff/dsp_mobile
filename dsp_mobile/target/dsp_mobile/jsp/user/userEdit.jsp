<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<%@include file="../public/metaSet.jsp"%>
		<title>用户编辑</title>
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
					parent.window.location.href="${pageContext.request.contextPath}/user/pageList.do";
				});
				
				/* 修改用户结果提示 */
				var msg = $("#msg").val();
				if (null !== msg && "" !== msg) {
					layer.confirm(msg,{
						btn : [ '关闭' ]//按钮
					},
					function() {
						parent.window.location.href = "${pageContext.request.contextPath}/user/pageList.do";
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
                            	用户编缉
                        </div>
                        <div class="panel-body">
                         
							<form id="form1" class="form-horizontal" role="form" action="${pageContext.request.contextPath}/user/update.do">
								<div class="form-group">
									<label for="userId" class="col-sm-2 control-label">用户Id</label>
									<div class="col-sm-6">
										<input type="text" readonly="readonly" class="form-control" id="userId" name="userId" value="${user.userId}" placeholder="请输入Id" onblur="InputValidation('userId','span1')">
									</div>
									<div class="col-sm-4">
										<span id="span1" class="text-control"></span>
									</div>
								</div>
								<div class="form-group">
									<label for="userName" class="col-sm-2 control-label">姓名</label>
									<div class="col-sm-6">
										<input type="text" class="form-control" id="userName" name="userName" value="${user.userName}" placeholder="请输入姓名" onblur="InputValidation('userName','span2')">
									</div>
									<div class="col-sm-4">
										<span id="span2" class="text-control"></span>
									</div>
								</div>
								
								<div class="form-group">
									<label for="passwd" class="col-sm-2 control-label">密码</label>
									<div class="col-sm-6">
										<input type="text" class="form-control" id="passwd" name="passwd" value="${user.passwd}" placeholder="请输入密码" onblur="InputValidation('passwd','span3')">
									</div>
									<div class="col-sm-4">
										<span id="span3" class="text-control"></span>
									</div>
								</div>
								<div class="form-group">
									<label for="mail" class="col-sm-2 control-label">邮箱</label>
									<div class="col-sm-6">
										<input type="text" class="form-control" id="mail" name="mail" value="${user.mail}" placeholder="请输入邮箱" >
									</div>
									<div class="col-sm-4">
										<span id="span4" class="text-control"></span>
									</div>
								</div>
								<div class="form-group">
									<label for="department" class="col-sm-2 control-label">部门</label>
									<div class="col-sm-6">
										<input type="text" class="form-control" id="department" name="department" value="${user.department}" placeholder="请输入部门">
									</div>
									<div class="col-sm-4">
										<span id="span5" class="text-control"></span>
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
