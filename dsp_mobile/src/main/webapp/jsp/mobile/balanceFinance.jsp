<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>互联网余额理财报表</title>
 
<link type="text/css" rel="stylesheet" href="/dsp/css/bootstrap/bootstrap.min.css" />
<link type="text/css" rel="stylesheet" href="/dsp/css/norm/bootstrap-select.css" />
<link href="/dsp/css/layer/layer.css" rel="stylesheet" type="text/css" />
<script type="application/javascript" src="/dsp/js/common/jquery-3.2.1.min.js"></script>
<script type="application/javascript" src="/dsp/js/common/bootstrap.min.js"></script>
<script type="application/javascript" src="/dsp/js/common/bootstrap-select.js"></script>
<script type="text/javascript" src="/dsp/js/norm/jquery.serializejson.min.js"></script>
<script type="text/javascript" src="/dsp/js/common/laydate/laydate.js"></script> 
<script type="text/javascript">
$(function(){
	
	var sum =$("#sum").val();
  	if(sum=='' ||sum==null){
		 $("#query").hide();
	}
	var value="";
	openView(value);
	getchannalsecond();
});
//获取二级渠道
function getchannalsecond(){
 	
	//初始化查询参数
	$.ajax({
		url:'/dsp/mobile/getchannelsec.do',
		dataType : 'json',
		success: function(date){
			var channelNoSecondList=date;
			var channelNoSecond1="";
			$.each(channelNoSecondList,function(i,n){
 				channelNoSecond1+='<option value="'+n.channelNoSecond+'">'+n.channelName+'</option>';
			});
			var string='所有渠道'
			var value='';
			var channeNoNull='<option value="'+ value+ '">'+string+'</option>';
			$('#channelNoSecond').html("");
			$('#channelNoSecond').append(channeNoNull);
			$('#channelNoSecond').append(channelNoSecond1);
			
 		}
	});
 };
 
 //查询
 function findBalance(){
 
	 var value=$("#channelNoSecond").find("option:selected").text();
   	 openView(value);
	 
 };
</script>

</head>
<body>
     <div  id="query" class="panel panel-default">
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
								<label for="endDate">结束时期</label> <input type="text" class="form-control" 
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
	<div id="main" style="height: 400px"></div>
	<input type="hidden" id="sum" value="${sum }">
  	<script src="/dsp/js/echart/echarts.js"></script>
	<script type="text/javascript">
 
     function openView(value){
     	  var myChart
           require.config({
            paths: {
                echarts: '/dsp/js/echart'
            }
        });
        require(
            [
                'echarts',
                'echarts/chart/bar', // 使用柱状图就加载bar模块，按需加载
				'echarts/chart/line'
            ],
             function (ec){
           	 var Chart=ec.init(document.getElementById("main"));  
           	 Chart.showLoading(  
           	         {text: 'Loding...'  }  
           	);
           	 
           	//ajax后台交互
                var pc=[];
                var av=[];
                var no=[];
                var starDate=$("#startDate").val();
                var endDate=$("#endDate").val();
                var channelSecondNo=$("#channelNoSecond").val();
                 $.ajax({
               	    type : "post",  
                    async : false, //同步执行  
                    url : " /dsp/mobile/getView.do",  
                    data : {"starDate":starDate,"endDate":endDate,"channelSecondNo":channelSecondNo},  
                    dataType : "json",
                    success:function(date){
                    	pc=date.time1;
                 	    av=date.applySumList;
                 	    no=date.netAssertSumList;
                	    var option={
                	    		 title : {
            				        text: value+'余额理财的销售进展',
            				        subtext: '仅供参考',
            					    x: 'center'
            				    },
            				   tooltip : {
            				        trigger: 'axis',
            						textStyle:{ 
            							fontSize: 12, 
            							font:'微软雅黑'
            				        }
            				       /* ,
            				       formatter: function(params){
            				    	   var num =params[0].value;
            				    	   var num1=params[1].value;
            				    	   var pan= (num || 0).toString().replace(/(\d)(?=(?:\d{3})+$)/g, '$1,');
            				    	   var pan1=(num1 || 0).toString().replace(/(\d)(?=(?:\d{3})+$)/g, '$1,');
             						  var res = params[0].name +  '<br/>'  +  params[0].seriesName + ":" + pan;
            						      res +=  '<br/>'  +  params[1].seriesName + ":" + pan1;
            						  return res;
            				       } */
            				   },
            				   legend: {
           				        data:['净申购','保有量'],
           						x: 'center',
           						y: 'bottom'
           				},
           				 toolbox: {
           				        show : true,
           				        feature : {
           				           // mark : {show: true},
           				            // dataView : {show: true, readOnly: true},
           				           // magicType : {show: true, type: ['line', 'bar']},
           				            restore : {show: false},
           				            saveAsImage : {show: true},
           				        }
           				    },
           				    calculable : false,
           				    xAxis : [
           				        {
           				            type : 'category',
           							splitLine:{show: false},
           				            //boundaryGap : false,
           				            data : pc
           				        }
           				    ],
           				    yAxis : [
           				        {
           						    name: '净申购(万元)',
           				            type : 'value',
           						   // max:1000000000,
           							axisLine: {onZero: false},
           							//splitLine:{show: false},
           				            axisLabel : {	
           				                //formatter: '{value}'
           								formatter:function(v){
           				                    return v/10000;
           				                }
           				            }
           				        },
           						 {
           						    name: '保有量(万元)',
           				            type : 'value',
           							//max:10000000000,
           							min:-10000,
           							splitLine:{show: false},
           							axisLine: {onZero: true},
           				            axisLabel : {
           				                formatter:function(v){
           				                    return v/10000;
           				                 
           				                }
           				            }
           				        }
           				    ],
           				    series : [
           				        {
           				            name:'净申购',
           				            type:'bar',
           				            data:av
           				         
           				            
           				        },
           				        {
           				            name:'保有量',
           				            type:'line',
           							symbol:'none',
           							yAxisIndex:1,
           				            data:no,
           				            data2:['111','22']
           				        }
           				    ]
                	    };
                	   Chart.hideLoading();  
                       Chart.setOption(option); 
                    },
                });
            }
            )
     };
   
           </script>
</body>
</html>
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