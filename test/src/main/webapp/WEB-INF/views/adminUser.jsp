<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<script src="http://localhost:8080/js/jquery-3.5.1.min.js"></script>
<script>
	$(document).ready(function(){
		$("#search").click(function(){
			 var ID= $("#condition option:selected").val();
			 var grade= $("#grade option:selected").val();
			var condition = $("input[name='info']").val();
			$.ajax({
				url:"searchUser.do?ID="+ID+"&condition="+condition+"&grade="+grade,
				success:function(result){
					var tag="";
					$("#table > tbody").empty();
					 jdata = JSON.parse(result);
					for(var i in jdata.list){
						tag+="<tbody>";
						tag+="<td><a href='userUpdate.do?id="+jdata.list[i].id+"'>"+jdata.list[i].id+"</a></td>";
						tag+="<td>"+jdata.list[i].uname+"</td>";
						tag+="<td>"+jdata.list[i].ugrade+"</td>";
						tag+="<td>"+jdata.list[i].lastlogin+"</td>";
						tag+="<td>"+jdata.list[i].lastpw+"</td>";
						tag+="<td>"+jdata.list[i].adminconfirm+"</td>";
						tag+="<td>"+jdata.list[i].part+"</td>";
						tag+="<td>"+jdata.list[i].company+"</td>";
						tag+="<td>"+jdata.list[i].birth+"</td>";
						tag+="<td>"+jdata.list[i].description+"</td>";
						tag+="<tbody>";
					} 
						 $("#table").append(tag)
				}
			})
		})
		$("#enroll").click(function(){
			$(location).attr("href","userEnroll.do");
		})
	})
</script>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<div class="content">
		<div>
			<h2>사용자 관리</h2>
			<aside class="path">
				<span>Home>기준정보>사용자관리</span>
			</aside>
		</div>
		<div class="find">
			<span>검색 조건</span>
			<select id="condition">
				<option value ="ID">ID</option>
				<option value ="UNAME">NAME</option>
			</select>
			<input type="text" name ="info">
			
			<span>사용자 등급</span>
			<select id=grade>
				<option value="all">ALL</option>
				<option value="admin">관리자</option>
				<option value="A">A</option>
				<option value="B">B</option>
			</select>
			<button type="button" id ="search">조회</button>
			<button type="button" id="enroll">등록</button>
		</div>
		<div class="info">
			<table id="table">
				<thead>
					<tr>
						<th>ID</th>
						<th>User Name</th>
						<th>User Grade</th>
						<th>최종 로그인 날짜</th>
						<th>패스워드 변경 날짜</th>
						<th>관리자 확인</th>
						<th>부서</th>
						<th>회사</th>
						<th>생일</th>
						<th>DESCRIPTION</th>
					</tr>
				</thead>
				<c:forEach items="${list }" var="vo">
					<tbody>
						<tr>
							<td><a href="userUpdate.do?id=${vo.id }">${vo.id }</a></td>
							<td>${vo.uname }</td>
							<td>${vo.ugrade }</td>
							<td>${vo.lastlogin }</td>
							<td>${vo.lastpw }</td>
							<td>${vo.adminconfirm }</td>
							<td>${vo.part }</td>
							<td>${vo.company }</td>
							<td>${vo.birth }</td>
							<td>${vo.description }</td>
						<tr>
					</tbody>
				</c:forEach>
			</table>
		</div>
	</div>
</body>
</html>