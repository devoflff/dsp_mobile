<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
	<head>
		<%@include file="../public/metaSet.jsp"%>
		<title>角色报表权限设置</title>
		<style type="text/css">
			*{margin:0;padding:0;list-style-type:none;outline:none;}
			a,img{border:0;}
			body{font:12px/normal "microsoft yahei";}
			.selectbox{width:600px;height:400px;margin:10px 10px auto 50px;padding-top: 20px;}
			.selectbox .select-bar{padding:0 10px;}
			.selectbox .select-bar select{width:300px;height:320px;border:1px #A0A0A4 solid;padding:10px;font-size:14px;font-family:"microsoft yahei";}
			.btn-bar{}
			.btn-bar p{margin-top:30px;}
			.btn-bar p .btn{width:50px;height:30px;cursor:pointer;font-family:simsun;font-size:14px;}
		</style>
		
		<link type="text/css" rel="stylesheet" href="/dsp/css/bootstrap/bootstrap.min.css" />
		<link href="/dsp/css/layer/layer.css" rel="stylesheet" type="text/css" />
		<script type="application/javascript" src="/dsp/js/common/jquery-3.2.1.min.js"></script>
		<script type="application/javascript" src="/dsp/js/common/bootstrap.min.js"></script>
		<script type="text/javascript" src="/dsp/js/common/layer.js"></script>
		<script>
			$(function(){	
				var reportData = ${reportList }
				var roleReportData = ${roleReportList}
				/* 加载多选框数据 */
				doViewSelect("select1",reportData);
				doViewSelect("select2",roleReportData);
				
				//移到右边
				$('#add').click(function(){
					//先判断是否有选中
					if(!$("#select1 option").is(":selected")){			
						alert("请选择需要移动的选项")
					}
					//获取选中的选项，删除并追加给对方
					else{
						var itm = $('#select1').val();
						for (i=0;i<itm.length ;i++ ) 
						{
							rmReport(reportData,itm[i],roleReportData);
							
						}
						//追加到右边方框
						$('#select1 option:selected').appendTo('#select2');
					}	
				});
				
				//移到左边
				$('#remove').click(function(){
					//先判断是否有选中
					if(!$("#select2 option").is(":selected")){			
						alert("请选择需要移动的选项")
					}
					else{
						var itm = $('#select2').val();
						for (i=0;i<itm.length ;i++ ) 
						{
							rmReport(roleReportData,itm[i],reportData);
						}
						$('#select2 option:selected').appendTo('#select1');
					}
				});
				
				//全部移到右边
				$('#add_all').click(function(){
					mvArr(reportData,roleReportData);
					//获取全部的选项,删除并追加给对方
					$('#select1 option').appendTo('#select2');
				});
				
				//全部移到左边
				$('#remove_all').click(function(){
					mvArr(roleReportData,reportData); 
					
					$('#select2 option').appendTo('#select1');
				});
				
				//双击选项
				$('#select1').dblclick(function(){ //绑定双击事件
					var itm = $("option:selected",this).val();
					rmReport(reportData,itm,roleReportData);
					//获取全部的选项,删除并追加给对方
					$("option:selected",this).appendTo('#select2'); //追加给对方
				});
				
				//双击选项
				$('#select2').dblclick(function(){
					var itm = $("option:selected",this).val();
					rmReport(roleReportData,itm,reportData);
					$("option:selected",this).appendTo('#select1');
				});
				
				//提交
				$('#bt1').bind('click',function(){
					//var obj = $("#select2 option");
					var reportIds="";
					for(var i=0;i<roleReportData.length;i++){
					    var opt = roleReportData[i].reportId;
					    reportIds+=","+opt;
					}
					reportIds = reportIds.substring(1);
					$("#reportIds").val(reportIds);
					$("#form1").submit();
					//var roleId = $("#u1").val();
					//window.location.href = "/dsp/role/roleReportSet.do?roleId="+roleId+"&reportIds="+reportIds;
				});
				
				/* 角色数据权限设置结果提示 */
				var msg = $("#msg").val();
				if (null !== msg && "" !== msg) {
					layer.confirm(msg,{
						btn : [ '关闭' ]//按钮
					},
					function() {
						parent.window.location.href = "/dsp/role/pageList.do";
					});
				}
				
				/* 模糊查询  */
				$("#input1").keyup(function(){
					var inputValue = $("#input1").val();
					var len = reportData.length;
					var arr = [];
					for(var i=0;i<len;i++){
					    //如果字符串中不包含目标字符会返回-1
					    if(reportData[i].reportName.indexOf(inputValue)>=0){
					        arr.push(reportData[i]);
					    }
					}
					doViewSelect("select1",arr);
				});
				
				/* 模糊查询  */
				$("#input2").keyup(function(){
					var inputValue = $("#input2").val();
					var len = roleReportData.length;
					var arr = [];
					for(var i=0;i<len;i++){
					    //如果字符串中不包含目标字符会返回-1
					    if(roleReportData[i].reportName.indexOf(inputValue)>=0){
					        arr.push(roleReportData[i]);
					    }
					}
					doViewSelect("select2",arr);
				});
				
			});
			
			function doViewSelect(id,arr){
				if(arr!=null){
					var optionlist = '';
					$.each(arr, function(i, n) {
						optionlist+='<option value="'+n.reportId+'">'+n.reportName+'</option>';
					});
					$('#'+id).html("");
					$('#'+id).append(optionlist);
				}
			}
			
			//两数组数据左可互移
			function rmReport(arr,temValue,arr1) {
				 var len = arr.length-1;
				 for(var i=len;i>=0;i--){
					 if(arr[i].reportId==temValue){
					  arr1.push(arr[i]);
					  arr.splice(i,1);
					 }
				 }
			}
			
			function mvArr(arr1,arr2){
				for (i=arr1.length-1;i>=0;i--) 
				{
					arr2.push(arr1[i]);
					arr1.splice(i,1);
				}
			}
		</script>
	</head>
	
	<body">
    	<div class="container-fluid">
           <div class="selectbox">
           		<table>
           			<tr>
           				<td>
           					<div class="select-bar " id="div1" >
           						<input id="input1" class="form-control" />
							    <select id="select1" name="usertype" class="form-control" multiple="multiple" >
							    </select>
							</div>
           				</td>
           				<td>
           					<div class="btn-bar">
							    <p><span id="add"><input type="button" class="btn" value=">" title="移动选择项到右侧"/></span></p>
							    <p><span id="add_all"><input type="button" class="btn" value=">>" title="全部移到右侧"/></span></p>
							    <p><span id="remove"><input type="button" class="btn" value="<" title="移动选择项到左侧"/></span></p>
							    <p><span id="remove_all"><input type="button" class="btn" value="<<" title="全部移到左侧"/></span></p>
							    <p><span id="sp1"><input id="bt1" type="button" class="btn" value="提交" title="提交"/></span></p>
							</div>
           				</td>
           				<td>
           					<div class="select-bar">
           						<input id="input2" class="form-control" />
								<form id="form1"  method="post" action="/dsp/role/roleReportSet.do">
							    	<select multiple="multiple" id="select2" class="form-control">
							    	</select>
							    	<input id="reportIds" name="reportIds" value="" type="hidden"/>
							    	<input id="u1" name="roleId" value="${roleId}" type="hidden"/>
							   		<input id="msg" name="msg" type="hidden" value="${msg}"/>
							    </form>
							</div>	
           				</td>
           			</tr>
           		</table>
			</div>
        </div>
    </body>
</html>
