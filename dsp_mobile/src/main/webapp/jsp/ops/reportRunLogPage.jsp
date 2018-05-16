<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<style>
* {
	padding: 0;
	margin: 0;
}

body, html {
	font-size: 14px;
}

#div1 {
	padding-top: 10px;
}

ul, li {
	list-style: none;
}

.title {
	height: 30px;
	width: 100%;
	border-top: 1px solid #DDDDDD;
	margin-bottom: 2px;
}

.title li {
	float: left;
	width: 25%;
	line-height: 30px;
	box-sizing: border-box;
}

#tb1 {
	border: 0;
	border-collapse: collapse;
}

#tb1 .c1 {
	height: 60px;
}

#table1 tbody tr td {
	border: 1px solid #DDDDDD;
	height: 30px;
	padding: 10px;
}

#table1 thead tr th {
	border: 1px solid #DDDDDD;
	padding: 10px;
	height: 30px;
}
</style>
<head>
<meta charset="utf-8">
<title>报表运行记录耗时图</title>
<link type="text/css" rel="stylesheet"
	href="/dsp_mobile/css/bootstrap/bootstrap.min.css" />
<script type="application/javascript"
	src="/dsp_mobile/js/common/jquery-3.2.1.min.js"></script>
<script type="application/javascript"
	src="/dsp_mobile/js/common/bootstrap.min.js"></script>
<script type="application/javascript"
	src="/dsp_mobile/js/common/bootstrap-select.js"></script>
<script type="application/javascript"
	src="/dsp_mobile/js/common/jquery.ba-resize.js"></script>	
<script type="text/javascript">
      $(function(){
    	var reportId=$('#reportId').val();
    	var reportName=$("#reportName").val();
      	openView(reportId,reportName);
     });
 		
    function openView(reportId,reportName){
    	require.config({
            paths: {
                echarts: '/dsp_mobile/js/echart'
            }
        });
        require(
            [
                'echarts',
 				'echarts/chart/line'
            ],
            function (ec) {
                var myChart = ec.init(document.getElementById('main')); 
                
            	//ajax后台交互
                var xtime=[];
                var ytime=[];
                   $.ajax({
                 	type : "GET",
                	async : false, //同步执行
                	url : " /dsp_mobile/mobile/getMrData.do",
                	data : {"reportId":reportId}, 
                	dataType : "json",
                	success:function(date){
                		
                		//赋值
                		xtime=date.xtime;
                		ytime=date.ytime;
                  		var option={
                				title : {
            				        text: reportName+'(最近六个月)运行记录耗时图',
            				        subtext: '仅供参考',
            					    x: 'center',
            					    textStyle:{
            					        //文字颜色
            					        color:'#000000',
            					        //字体风格,'normal','italic','oblique'
            					        fontStyle:'normal',
            					        //字体粗细 'normal','bold','bolder','lighter',100 | 200 | 300 | 400...
            					        fontWeight:'bold',
            					        //字体系列
            					        fontFamily:'sans-serif',
            					        //字体大小
            					        fontSize:15	

            					    }
            				    },
                				tooltip : {
                        	        trigger: 'axis',
                        	        axisPointer: {
                        	            type: 'cross',
                        	            label: {
                        	                backgroundColor: '#6a7985'
                        	            }
                        	        }
                        	    },
                        	    legend: {
                        	        data: ['耗时'],
                        	        x: 'right',
               						y: 30
                        	    },
                        	    grid: {
                        	    	x:42,
                        	    	y:55,
                        	    	x2:15,
                        	    	y2:55,
                        	    	left: '0%',
                        	    	right: '0%',
                        	    	bottom: '0%',
                        	    	containLabel: true
                        	    	},
                        	    toolbox: {
                        	    	show: true,
                        	        feature: {
                        	            dataZoom: {
                        	                yAxisIndex: 'none'
                        	            },
                        	            dataView: {readOnly: false},
                        	            magicType: {type: ['line', 'bar']},
                        	            restore: {},
                        	            saveAsImage: {}
                        	        }
                        	    },
                         	    xAxis : [
                        	        {
                        	            type : 'category',
                        	            boundaryGap : false,
                        	            splitLine:{ 
                                            show:false 
                                     },
                        	           data :  xtime,
                        	           axisLabel: {
                                           interval: 4,
                                           rotate: 48,
                                           //倾斜度 -90 至 90 默认为0  
                                           margin: 2,
                                           textStyle: {
                                               color: "#000000"
                                           }
                                       }
                        	        // data:[1, 2, 3, 4, 5, 6, 7]
                        	        }
                        	    ],
                        	    yAxis : [
               				        {
               				        	name: '耗时(秒)',
               				        	type: 'value',
               				        	axisLine: {onZero: false}
                				        }
                        	    ],
                          	    series : [
                          	    	{   name:'耗时',
                                        type:'line',
                                        data: ytime
                                     }
                           	    ]
                 		};
                 		//option.series = series;
                		// 为echarts对象加载数据 
                        myChart.setOption(option); 
                        window.onresize = myChart.resize;
                 	},
                });
                 
            }
        );
    	
     };
    </script>
</head>
<body
	style="margin-top: 120px; margin-left: 10px; margin-right: 10px; margin-bottom: 10px; border-top-width: 0px; border-top-style: solid;">
	<div id="main" style="height: 400px; width: 100%">
		<input id="reportId" name="reportId" value="${reportId}" type="hidden" />
		<input id="reportName" name="reportName" value="${reportName}"
			type="hidden" />
	</div>

	<script src="/dsp_mobile/js/echart/echarts.js"></script>
	<script type="text/javascript">
        
    </script>
</body>
