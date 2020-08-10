package com.spring.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.vo.FactoryVO;

@Repository
public class FactoryDAO {
	
	@Autowired 
	private SqlSessionTemplate sqlSession;
	
	private static String namespace = "mapper.factory";
	//��ü ����Ʈ
	public ArrayList<FactoryVO> getList(){
		List<FactoryVO> list =sqlSession.selectList(namespace+".getList");
		return (ArrayList<FactoryVO>)list;
	}
	//���� ���� ���
	public ArrayList<FactoryVO> getSearch(String using){
		List<FactoryVO> list = sqlSession.selectList(namespace+".getSearch",Integer.parseInt(using));
		return (ArrayList<FactoryVO>)list;
	}
	
	//���� ���� ���
	public FactoryVO getSearchInfo(String fname) {
		FactoryVO vo = sqlSession.selectOne(namespace+".getSearchInfo",fname);
		return vo;
	}
	//���� ���
	public int getEnroll(FactoryVO vo) {
		return sqlSession.insert(namespace+".getEnroll", vo);
	}
	//���� ���� ����
	public int getUpdate(FactoryVO vo) {
		return sqlSession.update(namespace+".getUpdate",vo);
	}
	//���� �ڵ� ��ȿ�� �˻�
	public int getNameCount(String code) {
		return sqlSession.selectOne(namespace+".getCodeCount",code);
	}
	public int getDelete(String name) {
		return sqlSession.delete(namespace+".getDelete", name);
	}

}
