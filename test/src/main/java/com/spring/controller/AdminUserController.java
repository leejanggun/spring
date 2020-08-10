package com.spring.controller;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.spring.dao.EnrollDAO;
import com.spring.dao.UserDAO;
import com.spring.security.SecurityUtil;
import com.spring.vo.UserVO;

@Controller
public class AdminUserController {
	
	@Autowired
	private EnrollDAO enrollDao;
	@Autowired
	private UserDAO userDao;
	@Autowired
	private SecurityUtil securityUtil;

//	초기화면 출력
	@RequestMapping(value="/adminUser.do",method=RequestMethod.GET)
	public ModelAndView getTest() {
		ModelAndView mv = new ModelAndView("adminUser");
		mv.addObject("list", userDao.getList());
		return mv;
	}
	
//	조회 화면
	@RequestMapping(value="/searchUser.do",method=RequestMethod.GET)
	@ResponseBody
	public String getSearch(String ID,String condition,String grade,HttpServletResponse response) throws Exception{
		ArrayList<UserVO> list = userDao.searchList(ID, condition,grade);
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
		
		return new Gson().toJson(jdata);
	}
// 사용자 등록 화면
	@RequestMapping(value="/userEnroll.do",method =RequestMethod.GET)
	public ModelAndView getUserEnroll() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("userEnroll");
		return mv;
	}
//	사용자 등록
	@RequestMapping(value="/enrollCheck.do",method =RequestMethod.POST)
	@ResponseBody
	public ModelAndView getEnrollCheck(UserVO vo,HttpServletResponse response) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		vo.setPw(securityUtil.encryptSHA256(vo.getPw()));
		
		if(enrollDao.getCheck(vo)!=0) {
			out.write("<script>alert('이미 등록 되어있는 아이디 입니다.');history.back()</script>");
			out.flush();
		}else {
			if(userDao.getIdCount(vo.getId())==0) {
				int result =enrollDao.getEnroll(vo);
				if(result==1) {
					out.println("<script>alert('성공.');location.href='http://localhost:8080/adminUser.do'</script>");
					out.flush();
				}else {
					out.write("<script>alert('이미 등록 되어있는 아이디 입니다.');history.back()</script>");
					out.flush();
				}
			}else {
				out.println("<script>alert('db 오류.');history.back()</script>");
				out.flush();
			}
		}
		return mv;
	}
//	업데이트 화면
	@RequestMapping(value="/userUpdate.do",method=RequestMethod.GET)
	public ModelAndView getUpdate(String id) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("vo", userDao.searchInfo(id));
		return mv;
	}
// 	업데이트
	@RequestMapping(value="/userUpdateCheck.do",method=RequestMethod.POST)
	@ResponseBody
	public ModelAndView getUpdateCheck(UserVO vo,String rid,String ppw,HttpServletResponse response)throws Exception {
		ModelAndView mv = new ModelAndView();
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		UserVO uvo =userDao.searchInfo(rid);
		
		String pwd=vo.getPw().trim();
		vo.setPw(securityUtil.encryptSHA256(vo.getPw()));
		ppw=securityUtil.encryptSHA256(ppw);
		String pw= uvo.getPw().trim();
		String id = uvo.getId().trim();
		String id2 = vo.getId().trim();
		
			if(pwd==""||pwd.equals("")) {
				int result =userDao.getUpdatePw(vo, rid);
				if(result==1) {
					out.println("<script>alert('성공.');location.href='http://localhost:8080/adminUser.do'</script>");
					out.flush();
				}else {
					out.println("<script>alert('db오류 입니다.');history.back()</script>");
					out.flush();
				}
				
			}else {
				if(pw.equals(ppw.trim())||pw==ppw.trim()) {
					int result= userDao.getUpdate(vo,rid);
					if(result==1) {
						userDao.getPWUpdate(id2);
						out.println("<script>alert('성공.');location.href='http://localhost:8080/adminUser.do'</script>");
						out.flush();
					}else {
						out.println("<script>alert('db오류 입니다.');history.back()</script>");
						out.flush();
					}
				}else {
					out.println("<script>alert('패스워드가 다릅니다.');history.back()</script>");
					out.flush();
				}
			}
		return mv;
	}
	//삭제
	@RequestMapping(value="userDelete.do",method=RequestMethod.POST)
	public String getDelete(String id) {
		userDao.getDelete(id);
		return "redirect:http://localhost:8080/adminUser.do";
	}
}
