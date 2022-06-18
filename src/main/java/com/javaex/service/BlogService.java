package com.javaex.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.BlogDao;
import com.javaex.vo.BlogVo;

@Service
public class BlogService {
	
	@Autowired
	private BlogDao blogDao;

	public BlogVo getBlog(String blogId) {
		BlogVo blogVo = blogDao.selectBlogVo(blogId);
		return blogVo;
	}

	public int updateBlog(BlogVo blogVo) {
		int isUpdated;
		isUpdated = blogDao.updateBlog(blogVo);
		return isUpdated;
	}

}
