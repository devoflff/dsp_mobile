<%@ page language="java" contentType="text/html; charset=UTF-8"  isELIgnored="false"  pageEncoding="UTF-8"%>
<html>
<head>
<%@include file="./public/metaSet.jsp"%>
<%@include file="./public/head.jsp"%>
<%@include file="./public/script.jsp"%>
<title>鹏华数据服务平台</title>
<script src="/dsp/js/common/cloud.js" type="text/javascript"></script>
<script src="/dsp/js/auth/login.js?m=20180117" type="text/javascript"></script>
</head>
<body onload="pageOnLoad()"	style="background-color: #1c77ac; background-image: url(images/light.png); background-repeat: no-repeat; background-position: center top; overflow: hidden;">
	<form action="/dsp/auth/login.do" method="post" id="login"> 
		<div class="loginbody">
            <div class='logintitle'>鹏&nbsp;&nbsp;&nbsp;华&nbsp;&nbsp;&nbsp;数&nbsp;&nbsp;&nbsp;据&nbsp;&nbsp;&nbsp;服&nbsp;&nbsp;&nbsp;务&nbsp;&nbsp;&nbsp;平&nbsp;&nbsp;&nbsp;台</div>
			<div class="loginbox">
				<input id="errorMsg" name="errorMsg" type="hidden" value="${errorMsg}"></input>
				<ul>
					<li><input name="userId" id="userId" type="text" class="loginuser"></input></li>
					<li><input name="passwd" type="password" id="password" class="loginpwd"></input></li>
					<li><input name="login" type="button" class="loginbtn" value="登录" onclick="formSubmit()"/></li>
				</ul>
			</div>
		</div>
	</form>

</body>
</html>
