package com.javaex.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.CateVo;

@Repository
public class CateDao {

	@Autowired
	private SqlSession sqlSession;

	public List<CateVo> selectCateVo(String cateId) {
		return sqlSession.selectList("CategoryXml.getCategory", cateId);
	}

	public int insertCate(CateVo cateVo) {
		int isInserted = sqlSession.insert("CategoryXml.insert", cateVo);
		return isInserted;
	}

	public int deleteCate(int cateNo) {
		int isDeleted = sqlSession.insert("CategoryXml.delete", cateNo);
		return isDeleted;
	}
	
}
