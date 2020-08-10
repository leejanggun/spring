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
	//전체 리스트
	public ArrayList<FactoryVO> getList(){
		List<FactoryVO> list =sqlSession.selectList(namespace+".getList");
		return (ArrayList<FactoryVO>)list;
	}
	//공장 정보 출력
	public ArrayList<FactoryVO> getSearch(String using){
		List<FactoryVO> list = sqlSession.selectList(namespace+".getSearch",Integer.parseInt(using));
		return (ArrayList<FactoryVO>)list;
	}
	
	//공장 정보 출력
	public FactoryVO getSearchInfo(String fname) {
		FactoryVO vo = sqlSession.selectOne(namespace+".getSearchInfo",fname);
		return vo;
	}
	//공장 등록
	public int getEnroll(FactoryVO vo) {
		return sqlSession.insert(namespace+".getEnroll", vo);
	}
	//공장 정보 수정
	public int getUpdate(FactoryVO vo) {
		return sqlSession.update(namespace+".getUpdate",vo);
	}
	//공장 코드 유효성 검사
	public int getNameCount(String code) {
		return sqlSession.selectOne(namespace+".getCodeCount",code);
	}
	public int getDelete(String name) {
		return sqlSession.delete(namespace+".getDelete", name);
	}

}
