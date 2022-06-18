package com.javaex.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.PostVo;

@Repository
public class PostDao {

	@Autowired
	private SqlSession sqlSession;

	public int insertPost(PostVo postVo) {
		return sqlSession.insert("PostXml.insert", postVo);
	}
	
	public List<PostVo> selectPost(List<PostVo> postVo) {
		return sqlSession.selectList("PostXml.select", postVo);
	}
	
	public List<PostVo> readPost(int cateNo) {
		List<PostVo> isRead = sqlSession.selectList("PostXml.read", cateNo);
		return isRead;
	}
	
	public PostVo postselect(int postNo) {
		PostVo selectPostList = sqlSession.selectOne("PostXml.postselect", postNo);
		return selectPostList;
	}

}
