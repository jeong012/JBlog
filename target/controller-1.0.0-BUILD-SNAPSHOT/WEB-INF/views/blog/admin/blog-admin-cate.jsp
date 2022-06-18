<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>JBlog</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/jblog.css">
		<script type="text/javascript" src="${pageContext.request.contextPath }/resources/assets/js/jquery/jquery-1.12.4.js"></script>
		<script src="http://code.jquery.com/jquery-latest.js"></script>
		<script>
			$(document).ready(function() {
				// 카테고리 추가
				$("#btnAddCate").on("click", function(){
					
					if($("[name=name]").val() == ""){
						alert("카테고리명을 입력하세요.");
					} else{
						// json 형식으로 데이터 set
	 					var params = {
							name : $("[name=name]").val(),
							desc : $("[name=desc]").val()
						}
						
						$.ajax({
							url : "/jblog/${authUser.id}/admin/category",
							type : "post",
							data : params,
							dataType : "json",
							success : function(json) {
								if(json.result == 'success'){
									$("#cateList").remove();
									
									console.log(json.cateList);
									
									var data = "<tbody id=cateList>";
									for(var i=0; i<json.cateList.length; i++){
										var cate = json.cateList[i];
										data = data 
											 + "<tr>"
											 + "	<td>" + cate.rowNum +"</td>"
											 + "	<td>" + cate.cateName + "</td>"
											 + "	<td>" + cate.postCount + "</td>" 	
											 + "	<td>" + cate.description + "</td>"
											 + "	<td> <img src='${pageContext.request.contextPath}/resources/assets/images/delete.jpg' "
											 + "		  	  onclick='deleteCate(" + cate.cateNo + ", " + cate.postCount + ")'></td>" 
											 + "</tr>";
									}
									data = data + "</tbody>";
									
									$("#cateHead").after(data);
									$("input[type=text][name=name]").val("");
									$("input[type=text][name=desc]").val("");
								}
							},
							error : function(error) {
								console.error(error);
						    }
						});
					}
				});
			});
			
			function deleteCate(cateNo, postCount) {	
				if(postCount > 0){
					alert("삭제할 수 없습니다.");
				}else{
					var params = {
						cateNo : cateNo
					}
					
					$.ajax({
						url : "/jblog/${authUser.id}/remove/category",
						type : "post",
						data : params,
						dataType : "json",
						success : function(json) {
							if(json.result == "success"){
								$("#cateList").remove();
								
								console.log(json.cateList);
								
								var data = "<tbody id=cateList>";
								for(var i=0; i<json.cateList.length; i++){
									var cate = json.cateList[i];
									data = data 
										 + "<tr>"
										 + "	<td>" + cate.rowNum +"</td>"
										 + "	<td>" + cate.cateName + "</td>"
										 + "	<td>" + cate.postCount + "</td>" 	
										 + "	<td>" + cate.description + "</td>"
										 + "	<td> <img src='${pageContext.request.contextPath}/resources/assets/images/delete.jpg' "
										 + "		  	  onclick='deleteCate(" + cate.cateNo + ", " + cate.postCount + ")'></td>" 
										 + "</tr>";
								}
								data = data + "</tbody>";
								
								$("#cateHead").after(data);
							} else{
								alert("삭제 실패");
							}
						},
						error : function(error) {
							console.error(error);
					    }
					});
				}
			}
			
		</script>
		
	</head>
	<body>
	
		<div id="container">
			
			<!-- 블로그 해더 -->
			<div id="header">
				<h1><a href="/jblog/${authUser.id}">${blogTitle}</a></h1>
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
				<div id="content" class="full-screen">
					<ul class="admin-menu">
						<li><a href="/jblog/${authUser.id}/admin/basic">기본설정</a></li>
						<li class="selected"><a href="/jblog/${authUser.id}/admin/category">카테고리</a></li>
						<li><a href="/jblog/${authUser.id}/admin/write">글작성</a></li>
					</ul>
					
			      	<table class="admin-cat" id="admin-cat">
			      		<thead id="cateHead">
				      		<tr>
				      			<th>번호</th>
				      			<th>카테고리명</th>
				      			<th>포스트 수</th>
				      			<th>설명</th>
				      			<th>삭제</th>      			
				      		</tr>
			      		</thead>
			      		<tbody id=cateList>
			      			<c:forEach items="${cateList}" var="cateVo">
				      			<tr>
									<td>${cateVo.rowNum}</td>
									<td>${cateVo.cateName}</td>
									<td>${cateVo.postCount}</td>
									<td>${cateVo.description}</td>
									<td><img src='${pageContext.request.contextPath}/resources/assets/images/delete.jpg' onclick="deleteCate(${cateVo.cateNo}, ${cateVo.postCount})"></td>
								</tr>
			      			</c:forEach>
						</tbody>
					</table>
	      	
	      			<h4 class="n-c">새로운 카테고리 추가</h4>
			      	<table id="admin-cat-add" >
			      		<tr>
			      			<td class="t">카테고리명</td>
			      			<td><input type="text" name="name" value=""></td>
			      		</tr>
			      		<tr>
			      			<td class="t">설명</td>
			      			<td><input type="text" name="desc"></td>
			      		</tr>
			      		<tr>
			      			<td class="s">&nbsp;</td>
			      			<td><input id="btnAddCate" type="submit" value="카테고리 추가"></td>
			      		</tr>      		      		
			      	</table> 
			      	
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