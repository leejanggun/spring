<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="http://localhost:8080/css/style.css"/>
<script src="http://localhost:8080/js/jquery-3.5.1.min.js"></script>
<script>
	$(document).ready(function(){
		$("#login").click(function(){
			var id=$("input[name='id']").val();
			var pw=$("input[name='pw']").val();
			if(id==""){
				alert("ID를 입력하세요");
				return false;
			}else if(pw==""){
				alert("PW를 입력하세요");
				return false;
			}else{
				$.ajax({
					url:"loginCheckAjax.do",
					method:"post",
					data:{id:id,pw:pw},
					success:function(result){
						if(result=="success"){
							$(location).attr("href","adminUser.do");
						}else if(result=="id"){
							alert("존재하지 않는 아이디 입니다.");
							$("input[name='id']").focus();
						}else if(result=="pw"){
							alert("비밀번호가 다릅니다.");
							$("input[name='pw	']").focus();
						}
					}
				})
			}
		})
	})
</script>
</head>
<body>
	<div class="loginForm">
		<h2>K F A</h2>
		<form action="loginCheck.do" method="post" name="form">
			<div><span>ID</span><input type="text" name="id" placeholder="ID"></div>
			<div><span>PW</span><input type="password" name ="pw" placeholder="PASSWORD"></div>
			<div><button type ="button" id= "login">로그인</button></div>
		</form>
	</div>
</body>
</html>