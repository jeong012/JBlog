<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JBlog</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/jblog.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/assets/js/jquery/jquery-1.12.4.js"></script>
<script>
$(document).ready(function() {
	// 아이디체크  url : "api/emailCheck.jsp", "/mysite/user",
	$("#btn-checkid").on("click", function() {

		// json 형식으로 데이터 set
		var params = {
			id : $("[name=id]").val()
		}

		$.ajax({
					url : "/api/user/idcheck",
					type : "post",
					data : params,
					dataType : "json",
					success : function(isExist) {
						console.log(isExist);
						if (isExist == false) {
							$("#checkid-msg").text("사용할 수 있는 아이디 입니다.")
							$("#checkid-msg").css("color", "green")
						} else {
							$("#checkid-msg").text("다른 아이디로 가입해 주세요.")
							$("#checkid-msg").css("color", "red")
						}
					},
					error : function(XHR, status, error) {
						console.error(status + " : " + error);
					}
		});
	});

});
</script>
</head>
<body>
	<div class="center-content">
		
		<!-- 메인해더 -->
	 	<a href="/jblog/">
			<img class="logo" src="${pageContext.request.contextPath}/resources/assets/images/logo.jpg">
		</a>
		<ul class="menu">
			<!-- 로그인 전 메뉴 -->
			<c:if test="${empty authUser}">
				<li><a href="/jblog/user/login">로그인</a></li>
				<li><a href="/jblog/user/join">회원가입</a></li>
			</c:if>
 		</ul>
		
		<form class="join-form" id="join-form" method="post" action="join">
			<label class="block-label" for="name">이름</label>
			<input type="text" name="userName"  value="" />
			
			<label class="block-label" for="id">아이디</label>
			<input type="text" name="id"  value="" />
			
			<input id="btn-checkid" type="button" value="id 중복체크">
			<p id="checkid-msg" class="form-error">
			&nbsp;
			</p>
			
			<label class="block-label" for="password">패스워드</label>
			<input type="password" name="password"  value="" />

			<fieldset>
				<legend>약관동의</legend>
				<input id="agree-prov" type="checkbox" name="agreeProv" value="y">
				<label class="l-float">서비스 약관에 동의합니다.</label>
			</fieldset>

			<input type="submit" value="가입하기">

		</form>
	</div>

</body>
</html>