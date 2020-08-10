<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.spring.vo.*" %>
<%
	UserVO vo = (UserVO)session.getAttribute("svo");
	if(vo==null){
		out.print("<script>alert('잘못된 경로 입니다.');location.href='http://localhost:8080'</script>");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="http://localhost:8080/css/style.css"/>
<link rel="stylesheet" type="text/css" href="http://localhost:8080/js//jquery-ui-1.12.1/jquery-ui.min.css"/>
<script src="http://localhost:8080/js/jquery-3.5.1.min.js"></script>
<script src="http://localhost:8080/js/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script src="http://localhost:8080/js/jquery-ui-1.12.1/datepicker-ko.js"></script>
<script>
	$(document).ready(function(){
		$("#enroll").click(function(){
			var id =$("input[name='id']").val();
			var pw =$("input[name='pw']").val();
			var sel =$("select[name='ugrade']").val();
			var form =$("form[name='enroll']");
			if(id==""){
				alert("아이디를 입력하세요.");
				return false;
			}else if(pw==""){
				alert("비밀번호를 입력하세요.");
				return false;
			}else if(sel=="null"){
				alert("사용자 등급을 설정하세요.");
				return false;
			}else{
				form.submit();
			}
			
		})
		$("#cancel").click(function(){
			$(location).attr("href","adminUser.do")
		})
		function maxLengthCheck(object){
		    if (object.value.length > object.maxLength){
		      object.value = object.value.slice(0, object.maxLength);
		    }    
		  }
		$(function(){
			$("#date1").datepicker({
				changeYear:true,
				changeMonth:true
			});
		})

	})
</script>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>

	<div class="enrollContent">
		<div>
			<h2>사용자 등록</h2>
		</div>
		<form name="enroll" action="enrollCheck.do" method="post">
			<table>
				<tr>
					<th>ID</th>
					<td><input type="text" name="id" maxlength="20" oninput="maxLengthCheck"></td>
				</tr>
				<tr>
					<th>New Password</th>
					<td><input type="password" name ="pw" maxlength="20" oninput="maxLengthCheck"></td>
				</tr>
				<tr>
					<th>User Name</th>
					<td><input type="text" name ="uname" maxlength="20" oninput="maxLengthCheck"></td>
				</tr>
				<tr>
					<th>사용자 등급</th>
					<td>
						<select name="ugrade">
							<option value="null">NULL</option>
							<option value="admin">관리자</option>
							<option value="A">A</option>
							<option value="B">B</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>부서</th>
					<td><input type="text" name="part" maxlength="20" oninput="maxLengthCheck"></td>
				</tr>
				<tr>
					<th>회사</th>
					<td><input type="text" name ="company" maxlength="20" oninput="maxLengthCheck"></td>
				</tr>
				<tr>
					<th>생일</th>
					<td><input type="text" name ="birth" id="date1" maxlength="20" oninput="maxLengthCheck" readonly></td>
				</tr>
				<tr>
					<th>description</th>
					<td><input type="text" name ="description" maxlength="20" oninput="maxLengthCheck"></td>
				</tr>
				<tr>
					<td colspan="2">
						<button type="button" id="enroll">등록</button>
						<button type="button" id="cancel">취소</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>