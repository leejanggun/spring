<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.spring.vo.*" %>
<%
	UserVO vo = (UserVO)session.getAttribute("svo");
	if(vo==null){
		System.out.println("!");
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
		$("#enroll").click(function(){
			$(location).attr("href","factoryEnroll.do");
		})
		$("#search").click(function(){
			var using=$("input[name='using']:checked").val()
			$.ajax({
				url:"factorySearch.do?using="+using,
				success:function(result){
					$("#table > tbody").empty();
					 var tag ="";
					var jdata = JSON.parse(result);
					for(var i in jdata.list){
						tag+="<tbody>";
						tag+="<td><a href='factoryUpdate.do?fcode="+jdata.list[i].fcode+"'>"+jdata.list[i].fcode+"</a></td>";
						tag+="<td>"+jdata.list[i].fname+"</td>";
						tag+="<td>"+jdata.list[i].erpcode+"</td>";
						tag+="<td>"+jdata.list[i].division+"</td>";
						tag+="<td>"+jdata.list[i].rdate+"</td>";
						tag+="<tbody>";
					}
					$("#table").append(tag);
				}
			})
		})
		$("#delete").click(function(){
			
		})
	})

</script>

</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<div class="content">
		<div>
			<h2>공장 관리</h2>
			<aside class="path">
				<span>Home>기준정보>공장관리</span>
			</aside>
		</div>
		<div class="find">
			<span>사용 유무</span>
			<input type="radio" name ="using" checked="checked" value="1">Y
			<input type="radio" name="using" value="0">N
				<button type="button" id ="search">조회</button>
				<button type="button" id="enroll">등록</button>
				<button>액셀</button>
		</div>
		<div class="info">
			<table id="table">
				<thead>
					<tr>
						<th>공장코드</th>
						<th>공장명</th>
						<th>ERP CODE</th>
						<th>공장 구분</th>
						<th>등록일</th>
					</tr>
				</thead>
				<c:forEach items="${list }"	var="vo">
					<tbody>
						<tr>
							<td><a href="factoryUpdate.do?fcode=${vo.fcode }">${vo.fcode }</a></td>
							<td>${vo.fname }</td>
							<td>${vo.erpcode }</td>
							<td>${vo.division }</td>
							<td>${vo.rdate }</td>
						</tr>
					</tbody>
				</c:forEach>
			</table>
		</div>
	</div>
</body>
</html>