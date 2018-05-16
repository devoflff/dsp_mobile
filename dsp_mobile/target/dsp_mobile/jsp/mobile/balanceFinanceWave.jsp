<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <meta charset="utf-8">
    <title>互联网余额理财报表</title>
    <script type="application/javascript" src="/dsp/js/common/jquery-3.2.1.min.js"></script>
    <script type="text/javascript">
    $(function(){
     	openView();
    });
    function openView(){
    	require.config({
            paths: {
                echarts: '/dsp/js/echart'
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
                var effectiveDate=[];
                var paramValue=[];
                var netAssertSum1=[];
                var netAssertSum2=[];
                var netAssertSum3=[];
                var series=[];
                 $.ajax({
                	
                	type : "post",
                	async : false, //同步执行
                	url : " /dsp/mobile/getAssert.do",
                	data : {},
                	dataType : "json",
                	success:function(date){
                		
                		//赋值
                		effectiveDate=date.time;
                		paramValue=date.paramValue;
                		netAssertSum1=date.netAssertSumList1;
                		netAssertSum2=date.netAssertSumList2;
                		netAssertSum3=date.netAssertSumList3;
                		for(var i = 0;i<paramValue.length;i++){
                			if('互联网'==paramValue[i]){
                				series.push({
                     	            name: paramValue[i],
                     	            type: 'line',
                     	            stack: '总量',
                     	            itemStyle: {normal: {areaStyle: {type: 'default'}}},
                     	           //data:[120, 132, 101, 134, 90, 230, 210]
                     	            data:  netAssertSum1
                     	        });
                			}else if('券商'==paramValue[i]){
                				series.push({
                     	            name: paramValue[i],
                     	            type: 'line',
                     	            stack: '总量',
                     	            itemStyle: {normal: {areaStyle: {type: 'default'}}},
                     	           //data:[320, 632, 201, 634, 91, 330, 610]
                     	             data:  netAssertSum2
                     	        });
                			}else{
                				series.push({
                     	            name: paramValue[i],
                     	            type: 'line',
                     	            stack: '总量',
                     	            itemStyle: {normal: {areaStyle: {type: 'default'}}},
                     	           // data:[120, 132, 101, 134, 90, 230, 210]
                     	            data:  netAssertSum3
                     	        });
                			}
                  				
                   	    	
                 	    };
                 		var option={
                				title : {
            				        text: '余额理财保有量统计图',
            				        subtext: '仅供参考',
            					    x: 'center'
            				    },
                				tooltip : {
                        	        trigger: 'axis',
                        	        axisPointer: {
                        	            type: 'cross',
                        	            label: {
                        	                backgroundColor: '#6a7985'
                        	            }
                        	        } /* ,
	            				    formatter: function(params){
	         				    	   var num =params[0].value;
	         				    	   var num1=params[1].value;
	         				    	   var num2=params[2].value;
	         				    	   var pan= (num || 0).toString().replace(/(\d)(?=(?:\d{3})+$)/g, '$1,');
	         				    	   var pan1=(num1 || 0).toString().replace(/(\d)(?=(?:\d{3})+$)/g, '$1,');
	         				    	   var pan2=(num2 || 0).toString().replace(/(\d)(?=(?:\d{3})+$)/g, '$1,');
	          						   var res = params[0].name +  '<br/>'  +  params[0].seriesName + ":" + pan;
	         						  res +=  '<br/>'  +  params[1].seriesName + ":" + pan1;
	         						  res +=  '<br/>'  +  params[2].seriesName + ":" + pan2;
	         						  return res;
	         				       } */
                        	    },
                        	    legend: {
                        	        data:paramValue,
                        	        x: 'center',
               						y: 'bottom'
                        	    },
                        	    toolbox: {
                        	        show : true,
                        	        feature : {
                         	            saveAsImage : {show: true}
                        	        }
                        	    },
                        	    calculable : true,
                        	    xAxis : [
                        	        {
                        	            type : 'category',
                        	            boundaryGap : false,
                        	            splitLine:{ 
                                            show:false 
                                     },
                        	           data :  effectiveDate
                        	        // data:[1, 2, 3, 4, 5, 6, 7]
                        	        }
                        	    ],
                        	    yAxis : [
               				        {
               				        	name: '保有量(万元)',
               				        	type: 'value',
               				        	axisLine: {onZero: false},
                   						axisLabel : {
               				            formatter:function(v){
               				                    return v/10000;
               				                }
               				            }
               				        }
                        	    ],
                          	    series : []
                 		};
                 		option.series = series;
                		 // 为echarts对象加载数据 
                        myChart.setOption(option); 
                	 
                	},
                });
                 
            }
        );
    	
     };
    </script>
</head>
<body>
    <div id="main" style="height:400px">
    </div>
    
    <script src="/dsp/js/echart/echarts.js"></script>
    <script type="text/javascript">
        
    </script>
</body>
