package com.javaex.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.CommentsVo;

@Repository
public class CommentsDao {

	@Autowired
	private SqlSession sqlSession;

	public int insertComment(CommentsVo commentVo) {
		return sqlSession.insert("CommentsXml.insert", commentVo);
	}

	public List<CommentsVo> getComments(int postNo) {
		return sqlSession.selectList("CommentsXml.getComments", postNo);
		
	}

	public int deleteComment(int cmtNo) {
		return sqlSession.insert("CommentsXml.delete", cmtNo);
	}

}
