package com.javaex.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.CommentsDao;
import com.javaex.vo.CommentsVo;

@Service
public class CommentsService {

	@Autowired
	private CommentsDao commentsDao;
	
	public int insertComment(CommentsVo commentVo) {
		int isInserted = commentsDao.insertComment(commentVo);
		return isInserted;
	}

	public List<CommentsVo> getComments(int postNo) {
		List<CommentsVo> commentsList = commentsDao.getComments(postNo);
		return commentsList;
	}

	public int deleteComment(int cmtNo) {
		int isDeleted = commentsDao.deleteComment(cmtNo);
		return isDeleted;
	}

}
