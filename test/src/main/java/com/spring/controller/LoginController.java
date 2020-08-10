package com.spring.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.dao.LoginDAO;
import com.spring.security.SecurityUtil;
import com.spring.vo.UserVO;

@Controller
public class LoginController {

	@Autowired
	private LoginDAO loginDao;
	@Autowired
	private SecurityUtil securityUtil;
	
	@RequestMapping(value="/",method=RequestMethod.GET)
	public String login(String pw) {
		return "login";
	}
	
	@RequestMapping(value="/loginCheck.do",method=RequestMethod.POST)
	public ModelAndView LoginCheck(String id,String pw,HttpServletResponse response,HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView();
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out =response.getWriter();
		pw = securityUtil.encryptSHA256(pw);
		UserVO vo = loginDao.getLogin(id,pw);
		if(vo!=null) {
			loginDao.getUpdate(id);
			session.setAttribute("svo", vo);
			mv.setViewName("redirect:http://localhost:8080/adminUser.do");
		}else {
			out.println("<script>alert('아이디와 비밀번호를 확인해주세요.');history.back();</script>");
			out.flush();
		}
		return mv;
	}
	@RequestMapping(value="/loginCheckAjax.do",method=RequestMethod.POST)
	@ResponseBody
	public String LoginCheckAjax(String id,String pw,HttpSession session) throws Exception {
		String str ="";
		pw = securityUtil.encryptSHA256(pw);
		String upw =loginDao.getLoginAjax(id);
		if(upw!=null) {
			if(upw.equals(pw)) {
				str="success";
				loginDao.getUpdate(id);
				UserVO vo = loginDao.getLogin(id,pw);
				session.setAttribute("svo", vo);
			}else {
				str="pw";
			}
		}else {
			str= "id";
		}
		return str;
	}
	@RequestMapping(value="/logout.do",method=RequestMethod.GET)
	public String logout(HttpServletResponse response,HttpSession session) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out =response.getWriter();
		session.invalidate();
		out.println("<script>location.href='http://localhost:8080'</script>");
		out.flush();
		return null;
	}
}
