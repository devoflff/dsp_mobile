<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>数据服务平台移动端报表首页</title>
<link type="text/css" rel="stylesheet"
	href="/dsp_mobile/css/bootstrap/bootstrap.min.css" />
<script type="application/javascript"
	src="/dsp_mobile/js/common/jquery-3.2.1.min.js"></script>
<script type="application/javascript"
	src="/dsp_mobile/js/common/bootstrap.min.js"></script>
<script type="text/javascript" src="/dsp_mobile/js/globalVal.js"></script>
<script src="/dsp_mobile/js/amazeui.js"></script>

<script type="text/javascript">

$(document).ready(function (){
 	getchannalsecond();
});
//获取二级渠道
function getchannalsecond(){
 	
	//初始化查询参数
	$.ajax({
		type:"GET",
		url:'/dsp_mobile/mobile/reportList.do',
		dataType : 'json',
		beforeSend: LoadFunction, //加载执行方法      
        error: erryFunction,  //错误执行方法      
        success: succFunction //成功执行方法      
    })  
    function LoadFunction() {  
       // $("#report").html('加载中...');  
    }  
    function erryFunction() {  
        alert("error");  
    }  
    function succFunction(data) {  
    	/* <a  href="/dsp_mobile/ops/getRunLog.do?reportId='+n.reportId+'"> */
        var b=data;
        var reportHtml = '';
        $.each(b, function(i, n){
        reportHtml+="<table style='width: 100%;'><tr><td style='width: 80%;'><p style='margin-bottom:5px;margin-left:5px;' onclick=openReport('"+n.reportId+"','"+n.REPORT_NAME+"')>"+n.REPORT_NAME+"</p></td>" +
		"<td align='right'>"+
		"<span class='am-badge am-badge-primary am-text-sm' onclick=openReport('"+n.reportId+"','"+n.REPORT_NAME+"')>[查看]</span></td></tr></table>";
        });
        $('#report').append(reportHtml);
  }
};
	
function openReport(reportId,reportName){
	parent.layer.open({
		type: 2,
		shadeClose: true,
		shade: false,
		maxmin: true, //开启最大化最小化按钮
		area: ['98%', '600px'],
		content: '/dsp_mobile/mobile/getRunLog.do?reportId='+reportId+'&reportName='+reportName
	});
};	
</script>
</head>
<body>
	<%-- <form id="form1" action="/dsp_mobile/mobile/reportList.do">
			<div class="row">
				<div class="col-lg-6">
					<div class="input-group" >
						<input type="text" name="reportName" class="form-control"
							style="height: 30px" placeholder="输入相关报表名称..."
							value="${reportName}" autocomplete="off" /> <input id="page"
							name="page" type="hidden" /> <input id="rows" name="rows"
							type="hidden" /> <input id="resourceId" name="resourceId"
							value="${resourceId}" type="hidden" /> <span
							class="input-group-btn">
							<button id="btnSearch" class="btn btn-default"
								style="height: 30px" type="button">Go!</button>
						</span>
					</div>
				</div>
			</div>
		</form> --%>
	
			<div id="report" style='margin-top:10px;margin-bottom:10px;border:solid white;' class='am-panel am-panel-default'>
				<div class='am-panel-bd' style='padding:0.3rem;'>
				<!-- <ul class="list-group" style="float: center; padding: 0; margin: 0">
						<c:forEach var="report" items="${reportMap.reportList}">
							<li class="list-group-item"><span class="badge">${report.reportId}</span>
								<a style="font-family: Microsoft YaHei"
								href="/dsp/mobile/inserRunLog.do?reportId=${report.reportId}">${report.reportName }</a>
							</li>
						</c:forEach>
					</ul> -->
			</div>
		</div>
</body>
</html>




