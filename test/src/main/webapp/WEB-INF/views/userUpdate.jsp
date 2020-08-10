<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.spring.vo.*" %>
<%
 	UserVO vo = (UserVO)session.getAttribute("svo");
	if(vo==null){
		out.print("<script>alert('잘못된 경로 입니다.');location.href='http://localhost:8080'</script>");
	}else{
		if(!vo.getUgrade().equals("admin")){
			out.print("<script>alert('접근 권한이 없습니다.');location.href='http://localhost:8080/adminUser.do'</script>");
		}
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="http://localhost:8080/css/style.css"/>
<link rel="stylesheet" type="text/css" href="http://localhost:8080/js//jquery-ui-1.12.1/jquery-ui.min.css"/>
<script src="http://localhost:8080/js/jquery-3.5.1.min.js"></script>
<script src="http://localhost:8080/js/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script src="http://localhost:8080/js/jquery-ui-1.12.1/datepicker-ko.js"></script>
<script>
	$(document).ready(function(){
		$("#update").click(function(){
			var id =$("input[name='id']").val();
			var ppw =$("input[name='ppw']").val();
			var pw =$("input[name='pw']").val();
			var sel =$("select[name='ugrade']").val();
			var form =$("form[name='update']")
			if(id==""){
				alert("아이디를 입력하세요.");
				return false;
			}else if(sel=="null"){
				alert("사용자 등급을 설정하세요.");
				return false;
			}else{
				form.submit();
			}
		})
		$("#delete").click(function(){
			var id ="${vo.id}";
			var newForm = document.createElement("form");
			newForm.name="delform";
			newForm.method="post";
			newForm.action="userDelete.do";
			var input = document.createElement("input");
			input.setAttribute("type","hidden");
			input.setAttribute("name","id");
			input.setAttribute("value",id);
			newForm.appendChild(input);
			document.body.appendChild(newForm);
			newForm.submit();
			
		});
		$("#cancel").click(function(){
			$(location).attr("href","adminUser.do")
		})
		function maxLengthCheck(object){
		    if (object.value.length > object.maxLength){
		      object.value = object.value.slice(0, object.maxLength);
		    }    
		  }
	})
	$(function(){
		$("#date1").datepicker({
			  changeYear:true,
			  changeMonth:true
		});
	})
</script>
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<div class="updateContent">
		<div>
			<h2>사용자 수정</h2>
		</div>
		<form name="update" action="userUpdateCheck.do" method="post">
			<table>
				<tr>
					<th>ID</th>
					<td>
						<input type="text" name="id" value="${vo.id }" readonly>
						<input type="hidden" name ="rid" value="${vo.id }">
					</td>
				</tr>
				<tr>
					<th>Prev Password</th>
					<td><input type="password" name ="ppw" maxlength="20" oninput="maxLengthCheck"></td>
				</tr>
				<tr>
					<th>New Password</th>
					<td><input type="password" name ="pw" maxlength="20" oninput="maxLengthCheck"></td>
				</tr>
				<tr>
					<th>User Name</th>
					<td><input type="text" name ="uname" value="${vo.uname }" maxlength="20" oninput="maxLengthCheck"></td>
				</tr>
				<tr>
					<th>사용자 등급</th>
					<td>
						<select name="ugrade">
							<option value="null" <c:if test="${vo.ugrade eq 'null'}">selected</c:if>>NULL</option>
							<option value="admin" <c:if test="${vo.ugrade eq 'admin'}">selected</c:if>>관리자</option>
							<option value="A" <c:if test="${vo.ugrade eq 'A'}">selected</c:if>>A</option>
				 			<option value="B" <c:if test="${vo.ugrade eq 'B'}">selected</c:if>>B</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>부서</th>
					<td><input type="text" name="part" value="${vo.part }" maxlength="20" oninput="maxLengthCheck"></td>
				</tr>
				<tr>
					<th>회사</th>
					<td><input type="text" name ="company" value="${vo.company }" maxlength="20" oninput="maxLengthCheck"></td>
				</tr>
				<tr>
					<th>생일</th>
					<td><input type="text" name ="birth" value="${vo.birth }" id="date1" maxlength="20" oninput="maxLengthCheck" readonly></td>
				</tr>
				<tr>
					<th>description</th>
					<td><input type="text" name ="description" value="${vo.description }" maxlength="20" oninput="maxLengthCheck"></td>
				</tr>
				<tr>
					<td colspan="2">
						<button type="button" id="update">수정</button>
						<button type="button" id="delete">삭제</button>
						<button type="button" id="cancel">취소</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>