package com.javaex.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.PostDao;
import com.javaex.vo.PostVo;

@Service
public class PostService {

	
	@Autowired
	private PostDao postDao;
	
	public void insertPost(PostVo postVo) {
		postDao.insertPost(postVo);
	}

	public List<PostVo> getPost(List<PostVo> postVo) {
		List<PostVo> PostList = postDao.selectPost(postVo);
		return PostList;
	}
	
	public List<PostVo> readpost(int cateNo) {
		List<PostVo> isRead = postDao.readPost(cateNo);
		return isRead;
	}
	
	public PostVo postselect(int postNo) {
		PostVo selectPostList = postDao.postselect(postNo);
		return selectPostList;
	}

}
