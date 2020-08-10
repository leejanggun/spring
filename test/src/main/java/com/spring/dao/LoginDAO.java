package com.spring.dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.vo.UserVO;

@Repository
public class LoginDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	private static String namespace = "mapper.login";
	
	public UserVO getLogin(String id,String pw) {
		Map<String,String> map = new HashMap<String,String>();
		map.put("id", id);
		map.put("pw", pw);
		return sqlSession.selectOne(namespace+".login", map);
	}
	
	public int getUpdate(String id) {
		return sqlSession.update(namespace+".loginUpdate", id);
	}
	
	public String getLoginAjax(String id) {
		return sqlSession.selectOne(namespace+".loginAjax",id);
	}
}
