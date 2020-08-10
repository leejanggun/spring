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
import com.spring.dao.FactoryDAO;
import com.spring.vo.FactoryVO;

@Controller
public class FactoryController {

	@Autowired
	private FactoryDAO factoryDao;
//공장 초기화면	
	@RequestMapping(value="factory.do",method=RequestMethod.GET)
	public ModelAndView getList() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("factory");
		ArrayList<FactoryVO> list = factoryDao.getList();
		mv.addObject("list", list);
		return mv;
	}
//	공장 자료 수정 화면
	@RequestMapping(value="factoryUpdate.do",method=RequestMethod.GET)
	public ModelAndView getUpdate(String fcode) {
		ModelAndView mv = new ModelAndView("factoryUpdate");
		FactoryVO vo = factoryDao.getSearchInfo(fcode);
		mv.addObject("vo",vo);
		return mv;
	}
//	공장 자료 수정	
	@RequestMapping(value="factoryUpdateCheck.do",method=RequestMethod.POST)
	@ResponseBody
	public ModelAndView getUpdateCheck(FactoryVO vo,String rfname,HttpServletResponse response) throws Exception {
		ModelAndView mv = new ModelAndView();
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		String name= vo.getFname().trim();
		String rname=rfname.trim();
		if(name.equals(rname)||name==rname) {
			int result =factoryDao.getUpdate(vo);
			if(result==1) {
				out.println("<script>alert('성공.');location.href='http://localhost:8080/factory.do'</script>");
				out.flush();
			}else {
				mv.addObject("error", "db");
				out.println("<script>alert('db오류.');history.back()</script>");
				out.flush();
			}
			
		}else {
			if(factoryDao.getNameCount(name)==1) {
				mv.addObject("error", "name");
			}else {
				int result =factoryDao.getUpdate(vo);
				if(result==1) {
					out.println("<script>alert('성공.');location.href='http://localhost:8080/factoryUpdate.do'</script>");
					out.flush();
				}else {
					mv.addObject("error", "db");
					out.println("<script>alert('오류.');history.back()</script>");
					out.flush();
				}
			}
		}
		return mv;
	}
	@RequestMapping(value="/factoryEnroll.do",method=RequestMethod.GET)
	public ModelAndView getEnroll() {
		ModelAndView mv = new ModelAndView("factoryEnroll");
		return mv;
	}
	//아이디 체크
	@RequestMapping(value="factoryEnrollCheck.do",method=RequestMethod.POST)
	@ResponseBody
	public ModelAndView getEnrollCheck(FactoryVO vo,HttpServletResponse response) throws Exception {
		ModelAndView mv = new ModelAndView();
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		if(factoryDao.getNameCount(vo.getFcode())==1) {
			out.println("<script>alert('이미 등록 되어있는 아이디 입니다.');history.back()</script>");
			out.flush();
		}else {
			int result =factoryDao.getEnroll(vo);
			if(result==1) {
				out.println("<script>alert('성공.');location.href='http://localhost:8080/factory.do'</script>");
				out.flush();
			}else {
				mv.addObject("error", "db");
				out.println("<script>alert('이미 등록 되어있는 아이디 입니다.');history.back()</script>");
				out.flush();
			}
		}
		return mv;
	}
	//공장 조회
	@RequestMapping(value="factorySearch.do",method=RequestMethod.GET,produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String getSearch(String using) {
		JsonArray jarr = new JsonArray();
		ArrayList<FactoryVO> list= factoryDao.getSearch(using);
		for(FactoryVO vo: list) {
			JsonObject jobj = new JsonObject();
			jobj.addProperty("fcode", vo.getFcode());
			jobj.addProperty("fname", vo.getFname());
			jobj.addProperty("erpcode", vo.getErpcode());
			jobj.addProperty("division", vo.getDivision());
			jobj.addProperty("rdate	", vo.getRdate());
			jarr.add(jobj);
		}
		JsonObject jdata = new JsonObject();
		jdata.add("list", jarr);
		return new Gson().toJson(jdata);
	}
	//공장 삭제
	@RequestMapping(value="deleteFactory.do",method=RequestMethod.POST)
	public String getDelete(String fcode) {
		factoryDao.getDelete(fcode);
		return "redirect:http://localhost:8080/factory.do";
	}
}
