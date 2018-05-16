<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta charset="UTF-8">
		
		<title>报表统计</title>
		<link type="text/css" rel="stylesheet" href="/dsp/css/bootstrap/bootstrap.min.css" />
		<script type="text/javascript" src="/dsp/js/common/laydate/laydate.js"></script> 
		<script type="application/javascript" src="/dsp/js/common/jquery-3.2.1.min.js"></script>
		<script type="application/javascript" src="/dsp/js/common/bootstrap.min.js"></script>
		<script type="text/javascript" src="/dsp/js/norm/jquery.serializejson.min.js"></script>
		<script type="text/javascript" src="/dsp/js/echart/echarts.js"></script>
		<script type="text/javascript" src="/dsp/js/ops/rchart.js"></script>
	</head>
	<body>
        <div class="container-fluid">
            <div class="row" id="div1">
                <div class="col-sm-12">
                    <div class="panel panel-default" >
                    
                        <div class="panel-heading">
                        	搜索
                        </div>
                        
                        <div class="panel-body">
                            <form id="form1" role="form" class="form-inline">
                               	<!-- 查询参数div -->
                                <div id="paramDiv">
                                	<div class="form-group" >
                                    <label for="startDate">开始日期</label>
                                    <input type="text" class="form-control" id="startDate" name="startDate" style="width:150px" placeholder="yyyy-mm-dd">
                                	</div>
                                	
	                                <div class="form-group">
	                                    <label for="endDate">结束时期</label>
	                                    <input type="text" class="form-control" id="endDate" name="endDate" style="width:150px" placeholder="yyyy-mm-dd">
	                                </div>
	                                <div class="form-group">
	                                    <label for="productCode">统计类型</label>
	                                </div>
	                                <div class="form-group">
	                                    <select class="form-control" id="type" name="type">
	                                     	<option value="1">日</option>
	                                     	<option value="2">周</option>
	                                     	<option value="3">月</option>
										</select>
	                                </div>
	                                
	                                <div class="form-group">
	                                    <button type="button" id="btnSearch" class="btn btn-info">
	                                    	查看
	                                    </button>
	                                </div>
                             	</div>
                            </form>
                            
                        </div>
                    </div>
                    
                	<!--指标显示-->
					<div id="divli" style="border:1px solid #DDDDDD;min-width:1126px;height: 500px; display: none;">
							
					</div>
                </div>
            </div>
        </div>
       
    </body>
</html>
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