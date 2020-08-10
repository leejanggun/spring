<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.util.*" %>
<%@ page import ="com.spring.vo.*" %>
<%@ page import ="com.google.gson.*" %>
<%@ page import ="com.spring.dao.*" %>
<%
	/* String ID = (String)request.getAttribute("ID");
	String condition = (String)request.getAttribute("condition");
	UserDAO dao = new UserDAO();
	ArrayList<UserVO> list = dao.searchList(ID, condition);
	JsonArray jarr = new JsonArray();
	for(UserVO vo : list) {
		JsonObject jobj = new JsonObject();
		jobj.addProperty("id", vo.getId());
		jobj.addProperty("pw", vo.getPw());
		jobj.addProperty("uname", vo.getUname());
		jobj.addProperty("ugrade", vo.getUgrade());
		jobj.addProperty("lastlogin", vo.getLastlogin());
		jobj.addProperty("lastpw", vo.getLastpw());
		jobj.addProperty("adminconfirm", vo.getAdminconfirm());
		jobj.addProperty("part", vo.getPart());
		jobj.addProperty("company", vo.getCompany());
		jobj.addProperty("birth", vo.getBirth());
		jobj.addProperty("description", vo.getDescription());
		jarr.add(jobj);
	}
	JsonObject jdata = new JsonObject();
	jdata.add("list", jarr);
	out.write(new Gson().toJson(jdata)); */
%>