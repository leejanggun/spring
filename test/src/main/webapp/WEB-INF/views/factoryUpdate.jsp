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
			out.print("<script>alert('접근 권한이 없습니다.');location.href='http://localhost:8080/factory.do'</script>");
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="http://localhost:8080/css/style.css"/>
<script src="http://localhost:8080/js/jquery-3.5.1.min.js"></script>
<script>
	$(document).ready(function(){
		$("#update").click(function(){
			var code =$("input[name='fcode']").val();
			var name =$("input[name='fname']").val();
			var using =$("select[name='using']").val();
			var form =$("form[name='fupdate']")
			if(code==""){
				alert("공장 코드를 입력하세요.");
				return false;
			}else if(name==""){
				alert("공장 이름을 입력하세요.");
				return false;
			}else if(using==""){
				alert("공장 사용 여부를 설정하세요.");
				return false;
			}else{
				form.submit();
			}
		})
		$("#delete").click(function(){
			var fcode ="${vo.fcode}";
			var newForm = document.createElement("form");
			newForm.name="delform";
			newForm.method="post";
			newForm.action="deleteFactory.do";
			var input = document.createElement("input");
			input.setAttribute("type","hidden");
			input.setAttribute("name","fcode");
			input.setAttribute("value",fcode);
			newForm.appendChild(input);
			document.body.appendChild(newForm);
			newForm.submit();
		});
		$("#cancel").click(function(){
			$(location).attr("href","factory.do")
		})
		function maxLengthCheck(object){
		    if (object.value.length > object.maxLength){
		      object.value = object.value.slice(0, object.maxLength);
		    }    
		  }
		
	})
</script>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>

	<div class="updateContent">
	<div>
		<h2>공장 수정</h2>
	</div>
	<form name="fupdate" action="factoryUpdateCheck.do" method="post">
		<table>
			<tr>
				<th>공장 코드</th>
				<td>
					<input type="text" name="fcode" value="${vo.fcode }" readonly>
					<input type= "hidden" name="rfname" value="${vo.fname }">
				</td>
			</tr>
			<tr>
				<th>공장명</th>
				<td><input type="text" name ="fname" value="${vo.fname }" maxlength="20" oninput="maxLengthCheck"></td>
			</tr>
			<tr>
				<th>ERP Code</th>
				<td><input type="text" name ="erpcode" value="${vo.erpcode }" maxlength="20" oninput="maxLengthCheck"></td>
			</tr>
			<tr>
				<th>공장 구분</th>
				<td><input type="text" name ="division" value="${vo.division }" maxlength="20" oninput="maxLengthCheck"></td>
			</tr>
			<tr>
				<th>사용 유무</th>
				<td>
					<input type="radio" name="using" value="1" <c:if test="${vo.using eq '1'}">checked</c:if>>YES
					<input type="radio" name="using" value="0" <c:if test="${vo.using eq '0'}">checked</c:if>>NO
				</td>
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