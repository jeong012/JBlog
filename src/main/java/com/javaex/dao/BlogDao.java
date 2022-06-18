package com.javaex.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.BlogVo;

@Repository
public class BlogDao {
	@Autowired
	private SqlSession sqlSession;

	public BlogVo selectBlogVo(String blogId) {
		return sqlSession.selectOne("BlogXml.getBlog", blogId);
	}

	public int updateBlog(BlogVo blogVo) {
		return sqlSession.update("BlogXml.updateBlog", blogVo);
	}

	public int insertBlog(BlogVo blogIn) {
		return sqlSession.insert("BlogXml.insertBlog", blogIn);
		
	}

}
