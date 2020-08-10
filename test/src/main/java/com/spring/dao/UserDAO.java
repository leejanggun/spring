package com.spring.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.spring.vo.UserVO;

public class UserDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private static String namespace = "mapper.adminUser";
//	��ü ���� ���	
	public ArrayList<UserVO> getList(){
		List<UserVO> list = sqlSession.selectList(namespace+".getList");
		return (ArrayList<UserVO>)list;
	}
//	���� ��ȸ
	public ArrayList<UserVO> searchList(String ID,String condition,String grade) {
		Map<String,String> map = new HashMap<String,String>();
		List<UserVO> list =null;
		map.put("ID", ID);
		map.put("condition", condition);
		if(grade.equals("all")) {
			list = sqlSession.selectList(namespace+".getSearch"+ID+"Total",map);
		}else {
			map.put("grade", grade);
			list = sqlSession.selectList(namespace+".getSearch"+ID,map);
		}
		return (ArrayList<UserVO>)list;
	}
//	���̵��� ���� ����
	public UserVO searchInfo(String id) {
		UserVO vo = sqlSession.selectOne(namespace+".getSearch",id);
		return vo;
	}
//	��й�ȣ ���� �����
	public int getUpdate(UserVO vo,String rid) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("vo", vo);
		map.put("rid", rid);
		return sqlSession.update(namespace+".getUpdate", map);
	}
//	��й�ȣ ���� �����
	public int getUpdatePw(UserVO vo,String rid) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("vo", vo);
		map.put("rid", rid);
		return sqlSession.update(namespace+".getUpdatePw", map);
	}
//	���̵� �ߺ� �˻�
	public int getIdCount(String id) {
		return sqlSession.selectOne(namespace+".getIdCount", id);
	}
	//����
	public int getDelete(String id) {
		return sqlSession.delete(namespace+".getDelete", id);
	}
	public int getPWUpdate(String id) {
		return sqlSession.delete(namespace+".PWUpdate",id);
	}
}
