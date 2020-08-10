package com.spring.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.vo.UserVO;

@Repository
public class EnrollDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	private static String namespace = "mapper.enroll";
	
	public int getEnroll(UserVO vo) {
		return sqlSession.insert(namespace+".enroll", vo);
	}
	
	public int getCheck(UserVO vo) {
		return sqlSession.selectOne(namespace+".getCheck", vo.getId());
	}
}
