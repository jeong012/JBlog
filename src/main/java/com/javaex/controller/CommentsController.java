package com.javaex.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.javaex.service.CommentsService;
import com.javaex.vo.CommentsVo;


@Controller
@RequestMapping("/jblog")
public class CommentsController {

	@Autowired
	private CommentsService commentsService;
	
	@ResponseBody
	@RequestMapping(value="/{id}/post/{flag}", method=RequestMethod.POST)
	public HashMap<String, Object> addPost(ModelAndView mav, CommentsVo commentVo, HttpServletRequest request, @PathVariable String flag) {
		
		int isInserted = 0;
		int isDeleted = 0;
		if(flag.equals("add")) {
			isInserted = commentsService.insertComment(commentVo);
		}else { // delete
			isDeleted = commentsService.deleteComment(commentVo.getCmtNo());
		}
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int postNo = Integer.parseInt(request.getParameter("postNo"));
		List<CommentsVo> commentsList = commentsService.getComments(postNo);
		if(isInserted == 1 || isDeleted == 1) {
			map.put("result", "success");
			map.put("commentsList", commentsList);
		} else {
			map.put("result", "fail");
		}
		
		return map;
	}
	
	
}
