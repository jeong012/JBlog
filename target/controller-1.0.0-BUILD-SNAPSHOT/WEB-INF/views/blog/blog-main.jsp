<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%> 


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
			<h1><a href="/jblog/${authUser.id}">${authUser.userName} 님의 블로그 입니다.</a></h1>
			<ul>
				<!-- 로그인 전 메뉴 -->
				<c:if test="${empty authUser}">
					<li><a href="/jblog/user/login">로그인</a></li>
				</c:if>
				
				<!-- 로그인 후 메뉴 -->
				<c:if test="${not empty authUser}">
					<li><a href="/jblog/user/logout">로그아웃</a></li>
					<li><a href="/jblog/${authUser.id}/admin/basic">내블로그 관리</a></li>
				</c:if>		
			</ul>
		</div>
		
		<div id="wrapper">
			<div id="content">
				<div class="blog-content">
					<h4>등록된 글이 없습니다</h4>
					<!--<p>
						새로운 조합을 이룬 어벤져스, <br>
 						역대 최강 빌런 타노스에 맞서 세계의 운명이 걸린<br> 
 						인피니티 스톤을 향한 무한 대결이 펼쳐진다! <br>
  						<br>
						4월, 마블의 클라이맥스를 목격하라!<br>
					</p>
					-->
					
					<!-- 등록된 글이 없는경우 -->
					<!-- 
					<h4>등록된 글이 없습니다.</h4>
					<p>
						
					<p>
					 -->
				</div>
				
				<ul class="blog-list">
					<li>
						<a href="">어벤져스: 인피니티 워</a> 
						<span>18/05/04</span>
					</li>
					<li>
						<a href="">챔피언</a> 
						<span>18/05/04</span>
					</li>
					<li>
						<a href="">그날, 바다</a> 
						<span>18/05/04</span>
					</li>
					<li>
						<a href="">원더스트럭</a> 
						<span>18/05/04</span>
					</li>
					<li>
						<a href="">렛 더 선샤인 인</a> 
						<span>18/05/04</span>
					</li>
				</ul>
			</div>
		</div>

		<div id="extra">
			<div class="blog-logo">
				<img src="${pageContext.request.contextPath}/resources/assets/images/spring-logo.jpg">				
			</div>
		</div>

		<div id="navigation">
			<h2>카테고리</h2>
			<ul>
				<li><a href="">영화</a></li>
				<li><a href="">음악</a></li>
				<li><a href="">미분류</a></li>
			</ul>
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