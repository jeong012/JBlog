<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JBlog</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/jblog.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/assets/js/jquery/jquery-1.12.4.js"></script>
</head>
<body>

	<div id="container">
		
		<!-- 블로그 해더 -->
		<div id="header">
			<c:choose>
				<c:when test="${empty authUser}">
					<h1><a href="/jblog/${id}">${blogTitle}</a></h1>
				</c:when>
				<c:otherwise>
					<h1><a href="/jblog/${authUser.id}">${blogVo.blogTitle}</a></h1>
				</c:otherwise>
			</c:choose>
			
			<ul>
				<c:choose>
					<c:when test="${empty authUser}">
						<li><a href="/jblog/user/login">로그인</a></li>
					</c:when>
					
					<c:otherwise>
						<li><a href="/jblog/user/logout">로그아웃</a></li>
						<li><a href="/jblog/${authUser.id}/admin/basic">내블로그 관리</a></li>
					</c:otherwise>
				</c:choose>		
			</ul>
		</div>
		
		
		<div id="wrapper">
			<div id="content" class="full-screen">
				<ul class="admin-menu">
					<li class="selected"><a href="/jblog/${authUser.id}/admin/basic">기본설정</a></li>
					<li><a href="/jblog/${authUser.id}/admin/category">카테고리</a></li>
					<li><a href="/jblog/${authUser.id}/admin/write">글작성</a></li>
				</ul>
				
				<form action="/jblog/${authUser.id}/admin/basic/update" method="post" enctype="multipart/form-data">
	 		      	<table class="admin-config">
			      		<tr>
			      			<td class="t">블로그 제목</td>
			      			<td><input type="text" size="40" name="blogTitle" value="${blogVo.blogTitle}"></td>
			      		</tr>
			      		<tr>
			      			<td class="t">로고이미지</td>
			      			<c:if test="${blogVo.logoFile eq 'default'}">
			      				<td><img src="${pageContext.request.contextPath}/resources/assets/images/spring-logo.jpg"></td>
			      			</c:if>
			      			<c:if test="${blogVo.logoFile ne 'default'}">
			      				<td><img src="${pageContext.request.contextPath}/resources/upload/${blogVo.logoFile}"></td>
			      			</c:if>
			      		</tr>      		
			      		<tr>
			      			<td class="t">&nbsp;</td>
			      			<td><input type="file" name="file" multiple></td>      			
			      		</tr>           		
			      		<tr>
			      			<td class="t">&nbsp;</td>
			      			<td class="s"><input type="submit" value="기본설정 변경"></td>      			
			      		</tr>           		
			      	</table>
				</form>
			</div>
		</div>
		
		
		<!-- 푸터-->
		<div id="footer">
			<p>
				<strong>Spring 이야기</strong> is powered by JBlog (c)2018
			</p>
		</div>
	
	</div>
</body>

</html>