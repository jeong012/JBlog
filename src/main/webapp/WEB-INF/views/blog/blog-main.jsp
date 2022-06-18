<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%
	pageContext.setAttribute("newLine", "\n");
%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>JBlog</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/jblog.css">
	<script type="text/javascript" src="${pageContext.request.contextPath }/resources/assets/js/jquery/jquery-1.12.4.js"></script>
	<style>
		table{
		    text-align: center;
		}
		#comment table, #comment td{
		    border: 1px solid #ddd;
		}
		#comment table{
		    border-collapse: collapse;
		    width: 100%;
		}
		td, input, button{
		    padding: 5px;
		}
		button {
			width: 65px;
		}
		.block{
			margin: 10px;
			border:1px solid black;
		}	
	</style>
	
	<script>
		$(document).ready(function(){
			// 댓글 추가
			$("#btnSave").on("click", function(){
				if($("[name=cmtContent]").val() === ""){
					alert("댓글 내용을 입력하세요.");
				} else{
					var params = {
						userNo : "${authUser.userNo}",
						cmtContent : $("[name=cmtContent]").val(),
						postNo : "${postNo}"
					}
					
					$.ajax({
						url : "/jblog/${authUser.id}/post/add",
						type : "post",
						data : params,
						dataType : "json",
						success : function(json){
							if(json.result === "success"){
								$("#commentsList").remove();
								
								var data = "<table id=commentsList>";
								for(var i=0; i<json.commentsList.length; i++){
									var comment = json.commentsList[i];
									data = data
										 + "<tr>"
										 + "<td width='120'>" + comment.userName + "</td>"
										 + "<td width='500'>" + comment.cmtContent + "</td>"
										 + "<td width='100'>" + comment.regDate + "</td>";
										 
									if(${authUser.userNo} == comment.userNo){
										data = data + "<td><a href='javascript:deleteComment(" + comment.cmtNo + ");'><font color='red'>X</font></a></td>";
									}
									
									data = data + "</tr>";
								}
								data = data + "</table>";
									
								$("#comment").after(data);
								$("input[type=text][name=cmtContent]").val("");
							}
						},
						error : function(error){
							console.error(error);
						}
					});
				}
			});
		});
		
		function deleteComment(commentNo){
			var params = {
				cmtNo : commentNo,
				postNo : "${postNo}"
			}
			$.ajax({
				url : "/jblog/${authUser.id}/post/delete",
				type : "post",
				data : params,
				dataType : "json",
				success : function(json){
					if(json.result === "success"){
						$("#commentsList").remove();
						
						var data = "<table id=commentsList>";
						for(var i=0; i<json.commentsList.length; i++){
							var comment = json.commentsList[i];
							data = data
								 + "<tr>"
								 + "<td width='120'>" + comment.userName + "</td>"
								 + "<td width='500'>" + comment.cmtContent + "</td>"
								 + "<td width='100'>" + comment.regDate + "</td>";
								 
							if(${authUser.userNo} == comment.userNo){
								data = data + "<td><a href='javascript:deleteComment(" + comment.cmtNo + ");'><font color='red'>X</font></a></td>";
							}
							
							data = data + "</tr>";
						}
						data = data + "</table>";
							
						$("#comment").after(data);
						$("input[type=text][name=cmtContent]").val("");
					}
				},
				error : function(error){
					console.error(error);
				}
			});
		};
		
	</script>
</head>
<body>

	<div id="container">

		<!-- 블로그 해더 -->
		<div id="header">
			<c:choose>
				<c:when test="${authUser.id ne id}">
					<h1><a href="/jblog/${id}">${blogTitle}</a></h1>
				</c:when>
				
				<c:otherwise>
					<h1><a href="/jblog/${authUser.id}">${blogTitle}</a></h1>
				</c:otherwise>
			</c:choose>
			
			<ul>
				<c:choose>
					<c:when test="${empty authUser}">
						<li><a href="/jblog/user/login">로그인</a></li>
					</c:when>
					
					<c:otherwise>
						<li><a href="/jblog/user/logout">로그아웃</a></li>
						<c:if test="${authUser.id eq id }">
							<li><a href="/jblog/${authUser.id}/admin/basic">내블로그 관리</a></li>
						</c:if>
					</c:otherwise>
				</c:choose>		
			</ul>
		</div>
		
		<div id="wrapper">
			<div id="content">
				<div class="blog-content">
					<c:choose>
						<c:when test="${empty postList}">
							<h4>등록된 글이 없습니다.</h4>
						</c:when>
						<c:otherwise>
							<h1>${postVo.postTitle}</h1>
							<br>
							${fn:replace(postVo.postContent, newLine, "<br>")}
						</c:otherwise>
					</c:choose>
				</div>
				
				<div class="blog-content">
					<table id="comment">
						<c:if test="${not empty authUser and not empty postList}">
							<tr>
							    <td width="120">${authUser.userName}</td>
							    <td width="500"><input type="text" name="cmtContent" size="60"></input></td>
							    <td width="100" colspan="2"><button id="btnSave">저장</button></td>
							</tr>
						</c:if>
				    </table>
				    
				    <table id="commentsList">
				    	<c:forEach items="${commentsList}" var="commentVo">
							<tr>
								<td width="120">${commentVo.userName}</td>
							    <td width="500">${commentVo.cmtContent}</td>
							    <td width="100">${commentVo.regDate}</td>
							   	<c:if test="${authUser.userNo eq commentVo.userNo}">
							    	<td><a href="javascript:deleteComment(${commentVo.cmtNo});"><font color="red">X</font></a></td>
							    </c:if>
							</tr>
						</c:forEach>
					</table>
				</div>
				
				
				<c:if test="${not empty postList}">
					<div class="block">
				</c:if>
					<ul class="blog-list">
					<c:forEach items="${postList}" var = "postVo">
						<li>
							<c:choose>
								<c:when test="${authUser.id ne id}">
									<c:choose>
										<c:when test="${postVo.postNo eq postNo}">
											<a href="/jblog/${id}/${cateNo}/${postVo.postNo}"><font color="black">${postVo.postTitle}</font></a>
										</c:when>
										
										<c:otherwise>
											<a href="/jblog/${id}/${cateNo}/${postVo.postNo}">${postVo.postTitle}</a>
										</c:otherwise>
									</c:choose>
								</c:when>

								<c:otherwise>
									<c:choose>
										<c:when test="${postVo.postNo eq postNo}">
											<a href="/jblog/${authUser.id}/${cateNo}/${postVo.postNo}"><font color="black">${postVo.postTitle}</font></a>
										</c:when>
										
										<c:otherwise>
											<a href="/jblog/${authUser.id}/${cateNo}/${postVo.postNo}">${postVo.postTitle}</a>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
							<span>${postVo.regDate}</span>
						</li>
						</c:forEach>
					</ul>
				<c:if test="${not empty postList}">
					</div>
				</c:if>
			</div>
		</div>

		<div id="extra">
			<div class="blog-logo">
				<c:if test="${blogVo.logoFile eq 'default'}">
      				<img src="${pageContext.request.contextPath}/resources/assets/images/spring-logo.jpg">
      			</c:if>
      			<c:if test="${blogVo.logoFile ne 'default'}">
      				<img src="${pageContext.request.contextPath}/resources/upload/${blogVo.logoFile}">
      			</c:if>				
			</div>
		</div>

		<div id="navigation">
			<h2>카테고리</h2>
			<c:forEach items="${cateList}" var = "cateVo">
				<ul>
					<li>
						<c:choose>
							<c:when test="${authUser.id ne id}">
								<c:choose>
									<c:when test="${cateVo.cateNo eq cateNo}">
										<a href="/jblog/${id}/${cateVo.cateNo}"><strong>${cateVo.cateName}</strong></a>
									</c:when>
									<c:otherwise>
										<a href="/jblog/${id}/${cateVo.cateNo}">${cateVo.cateName}</a>
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${cateVo.cateNo eq cateNo}">
										<a href="/jblog/${authUser.id}/${cateVo.cateNo}"><strong>${cateVo.cateName}</strong></a>
									</c:when>
									<c:otherwise>
										<a href="/jblog/${authUser.id}/${cateVo.cateNo}">${cateVo.cateName}</a>
									</c:otherwise>
								</c:choose>
								
							</c:otherwise>
						</c:choose>
					</li>
				</ul>
			</c:forEach>
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