<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
 <title>渠道查询</title>
 <link type="text/css" rel="stylesheet" href="/dsp/css/bootstrap/bootstrap.min.css" />
<link type="text/css" rel="stylesheet" href="/dsp/css/norm/bootstrap-select.css" />
<link href="/dsp/css/layer/layer.css" rel="stylesheet" type="text/css" />
<script type="application/javascript" src="/dsp/js/common/jquery-3.2.1.min.js"></script>
<script type="application/javascript" src="/dsp/js/common/bootstrap.min.js"></script>
<script type="application/javascript" src="/dsp/js/common/bootstrap-select.js"></script>
<script type="text/javascript" src="/dsp/js/norm/jquery.serializejson.min.js"></script>
<script type="text/javascript">
$(function(){
	
	getchannalsecond();
});


//获取一级渠道


//获取二级渠道
function getchannalsecond(){
 	
	//初始化查询参数
	$.ajax({
		url:'/dsp/mobile/getchannelsec.do',
		dataType : 'json',
		success: function(date){
			var channelNoSecondList=date;
			var channelNoSecond="";
			$.each(channelNoSecondList,function(i,n){
 				channelNoSecond+='<option value="'+n.paramCode+'">'+n.paramValue+'</option>';
			});
			$('#channelNoSecond').html("");
			$('#channelNoSecond').append(channelNoSecond);
			
 		}
	});
 };
 
 function findBalance(){
 	 var channelNoSecond=$("#channelNoSecond").val();
 	 var startDate=$("#startDate").val();
 	 var endDate=$("#endDate").val();
	 parent.document.getElementById('starDate').value=startDate;
	 parent.document.getElementById('channelSecond').value=channelNoSecond;
	 parent.document.getElementById('endDate').value=endDate;
	 window.parent.openView();
	 
 };
</script>
</head>
<body>
 			<div class="panel panel-default">
				<div class="panel-heading">搜索</div>
				<div class="panel-body" style="text-align: center;">
					<form id="form1" role="form" class="form-inline">
						<!-- 查询参数div -->
						<div id="paramDiv">
							<div class="form-group">
								<label for="reportType">二级渠道</label> 
								<select class="form-control" id="channelNoSecond" name="channelNoSecond" style="width: 200px">
								</select>
							</div>
		
							<div class="form-group">
								<label for="startDate">开始日期</label> <input type="text" class="form-control" 
									id="startDate" name="startDate" placeholder="yyyy-mm-dd">
							</div>
		
							<div class="form-group">
								<label for="endDate">结束时期</label> <input type="date" class="form-control" 
									id="endDate" name="endDate" placeholder="yyyy-mm-dd">
							</div>
 		
							<div class="form-group">
  								<button type="button" id="btnSearch" class="btn btn-info" onclick="findBalance()">
									查询
								</button>
							</div>
						</div>
					</form>
				</div>
			</div>
  </body>
</html>

<script type="text/javascript" src="/dsp/js/common/laydate/laydate.js"></script> 
<script type="text/javascript">
			laydate.render({
			  elem: '#startDate',
			  trigger: 'click' ,
		      showBottom: false,
 		      
			});
			laydate.render({
		      elem: '#endDate',
		      trigger: 'click' ,
		      showBottom: false
			});
</script>