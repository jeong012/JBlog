package com.javaex.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.javaex.service.PostService;
import com.javaex.vo.PostVo;


@Controller
@RequestMapping("/jblog")
public class PostController {

	@Autowired
	private PostService postService;
	
	/* 블로그 글 작성*/
	@RequestMapping(value="/{id}/post/write", method=RequestMethod.POST)
	public String addPost(ModelAndView mav, PostVo postVo, HttpServletRequest request) {
		postService.insertPost(postVo);
		
		return "redirect:/jblog/{id}/" + postVo.getCateNo() + "/" + postVo.getPostNo();
	}
	
}
