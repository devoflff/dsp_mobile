$(function() {
	// 获取菜单内容并初始化
	$.ajax({
		url : '/dsp/auth/toIndex.do',
		dataType : 'json',
		success : function(value) {
			var _menu =value;
			var menulist = '';
			$.each(_menu.menus, function(i, n) {
				if(n.resourceUrl=="#"){
					menulist +='<div class="panel panel-danger leftMenu">'
				 		 +'<div class="panel-heading"'+ ' id="collapseListGroupHeading'+i+'"'
				 		 +' data-toggle="collapse" data-target="#collapseListGroup'+i+'" '+'role="tab"  >'
				 		 +'<h4 class="panel-title">'
				 		 +n.resourceName+'<span class="glyphicon glyphicon-list right"></span>'
				 		 +'</h4></div>'
						 +'<div id="collapseListGroup'+i+'" ';
				if(i==0){
					menulist+=' class="panel-collapse collapse in"'
				}else{
					menulist+=' class="panel-collapse collapse"'
				}		
				menulist+=' role="tabpanel" aria-labelledby="collapseListGroupHeading'+i+'">'
						 +'<ul class="list-group" >';
				}else{
					menulist +='<div class="panel panel-danger leftMenu">'
				 		 +'<div class="panel-heading"'+ ' id="collapseListGroupHeading'+i+'">'
 				 		 +'<h4 class="panel-title" onclick="menuClick(\''+n.resourceUrl+'\')">'
				 		 +n.resourceName+'<span class="glyphicon glyphicon-list right"></span>'
				 		 +'</h4></div>'
						 +'<div id="collapseListGroup'+i+'" >';
				}
 				$.each(n.menus, function(j, o) {
 					if(o.resourceId=='m100002'){
						menulist+= '<li class="list-group-item">'
							 +'<a href="'+o.resourceUrl+'" target="iframe1" class="list-group-item">'+o.resourceName+'</a>'
							 +'</li>';
					}else if('#'==o.resourceUrl){
						menulist+='<li class="list-group-item">' 
							      +'<div  data-toggle="collapse" id="collapseListGroupHeadingSec'+o.resourceId+'" data-target="#collapseListSecGroup'+o.resourceId+'" role="tabSec" >'
						          +'<a  href="javascript:void(0);" target="iframe1" class="list-group-item">'+o.resourceName+'</a> <div>' 
						          +'</li>'
						          +'<div id="collapseListSecGroup'+o.resourceId+'" ';
						if(j==0  ){
							menulist+=' class="panel-collapse collapse in"'
						
						}else{
							menulist+=' class="panel-collapse collapse"'
						}
						menulist+=' role="tabSecond" aria-labelledby="collapseListGroupHeadingSec'+o.resourceId+'">' ;
						$.each(o.menus, function(l, m){
							menulist += '<li class="list-group-item">'
								+'<a href="'+m.resourceUrl+'?resourceId='+m.resourceId+'" target="iframe1" class="list-group-item">'+ '&nbsp&nbsp;&nbsp;&nbsp;&nbsp'+m.resourceName+'</a>'
								+'</li>';
						});
						menulist+='</div>'
  					}else{
						menulist += '<li class="list-group-item">'
							+'<a href="'+o.resourceUrl+'?resourceId='+o.resourceId+'" target="iframe1" class="list-group-item">'+o.resourceName+'</a>'
							+'</li>';
 					}
				})
				menulist += '</ul></div></div>';
			});
			$('#menuDiv').append(menulist)
		}
	});
});
 
function menuClick(url){
 	window.open( url,"iframe1","");
};
/*$(document).ready(function() {
 //这是给div的一个初始页面
 $("#myManu").load('/dsp/user/pageList.do');

 });*/

/*var menuClick = function(url) {
 alert(url)
 $("#myManu").load(url);
 };*/