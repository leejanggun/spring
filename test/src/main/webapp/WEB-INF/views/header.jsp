<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.spring.vo.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <script src="http://localhost:8080/js/jquery-3.5.1.min.js"></script>
 --><script>
	$(document).ready(function(){
		$("#logout").click(function(){
			alert("로그아웃 되었습니다.");
			$(location).attr("href","http://localhost:8080/logout.do");
		});
	})
</script>
<link rel="stylesheet" type="text/css" href="http://localhost:8080/css/style.css"/>
</head>
<body>
	<header>
		<div class="login">
			HOME
				<ul>
					<li id="logout">logout</li>
					<li>My info</li>
				</ul>
		</div>
		<div class="menu">
			<ul>
				<li>계획</li>
				<li>현황</li>
				<li>실적</li>
				<li>검사데이터</li>
				<li>라벨 발행 이력</li>
				<li id="factory" class="dropdown">
					<button class="dropbtn">기준 정보</button>
			      <div class="dropdown-content">
			        <a href="adminUser.do">사용자 관리</a>
			        <a href="factory.do">공장 관리</a>
			      </div>
				</li>
				<li>INTERFACE</li>
			</ul>
		</div>
	</header>
</body>
</html>