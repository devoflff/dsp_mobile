$(function(){
    $('.loginbox').css({'position':'absolute','left':($(window).width()-692)/2});
	$(window).resize(function(){   
    $('.loginbox').css({'position':'absolute','left':($(window).width()-692)/2});
    })  ;
	
	$(document).keyup(function(event){
		if(event.keyCode ==13){
			formSubmit();
		}
	});
});

function formSubmit(){
    var id = $("#userId").val();
    var pw = $("#password").val();
    if(id == ""){
    	layer.msg('登录账户名不能为空', {icon: 5});
        return ;
    }
    if(pw == ""){
       layer.msg('登录密码不能为空', {icon: 5});
       return ;
    }
	var form =  $("#login");
    form.submit();
  }

  function pageOnLoad(){
     var logmsg = $("#errorMsg").val();
       if(null !== logmsg && ""!== logmsg  ){
    	   layer.msg(logmsg, {icon: 5});
       }
  }
 