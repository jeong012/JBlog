package com.javaex.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.javaex.service.BlogService;
import com.javaex.service.CateService;
import com.javaex.service.CommentsService;
import com.javaex.service.PostService;
import com.javaex.vo.BlogVo;
import com.javaex.vo.CateVo;
import com.javaex.vo.CommentsVo;
import com.javaex.vo.PostVo;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/jblog")
@Log4j
public class BlogController {

	@Autowired
	private BlogService blogService;
	
	@Autowired
	private CateService cateService;
	
	@Autowired
	private PostService postService;

	@Autowired
	private CommentsService commentsService;
	
	/*블로그 메인폼 출력*/
	@RequestMapping("/{id}")
	public ModelAndView mainManagement(ModelAndView mav, HttpSession session,  @PathVariable String id) {
		 
		BlogVo blogVo = blogService.getBlog(id);
		String blogTitle = blogVo.getBlogTitle();
		List<CateVo> cateList = cateService.getCate(id);
		List<PostVo> postList = postService.readpost(cateList.get(0).getCateNo());
		
		PostVo postVo = new PostVo();
		List<CommentsVo> commentsList = new ArrayList<>();
		if(postList.size() > 0 ) {
			postVo = postService.postselect(postList.get(0).getPostNo());
			commentsList = commentsService.getComments(postList.get(0).getPostNo());
		}
		
		mav.addObject("postVo", postVo);
		mav.addObject("postNo", postVo.getPostNo());
		mav.addObject("postList", postList);
		mav.addObject("cateList", cateList);
		mav.addObject("cateNo", cateList.get(0).getCateNo());
		mav.addObject("blogVo", blogVo);
		mav.addObject("blogTitle", blogTitle);
		mav.addObject("id", id);
		mav.addObject("commentsList", commentsList);
		mav.setViewName("/blog/blog-main");
		
		return mav;
	}
		
	@RequestMapping("/{id}/{cateNo}")
	public ModelAndView cateNumber(ModelAndView mav, HttpSession session, @PathVariable int cateNo, @PathVariable String id) {
		
		BlogVo blogVo = blogService.getBlog(id);
		String blogTitle = blogVo.getBlogTitle();
		List<CateVo> cateList = cateService.getCate(id);
		List<PostVo> postList = postService.readpost(cateNo);
		
		PostVo postVo = new PostVo();
		List<CommentsVo> commentsList = new ArrayList<>();
		if(postList.size() > 0 ) {
			postVo = postService.postselect(postList.get(0).getPostNo());
			commentsList = commentsService.getComments(postList.get(0).getPostNo());
		}
		
		mav.addObject("cateNo", cateNo);
		mav.addObject("postVo", postVo);
		mav.addObject("postNo", postVo.getPostNo());
		mav.addObject("postList", postList);
		mav.addObject("cateList", cateList);
		mav.addObject("blogVo", blogVo);
		mav.addObject("blogTitle", blogTitle);
		mav.addObject("id", id);
		mav.addObject("commentsList", commentsList);
		mav.setViewName("/blog/blog-main");
		
		return mav;
	}
	
	@RequestMapping("/{id}/{cateNo}/{postNo}")
	public ModelAndView postName(ModelAndView mav, @PathVariable int cateNo, @PathVariable int postNo, @PathVariable String id) {
		BlogVo blogVo = blogService.getBlog(id);
		String blogTitle = blogVo.getBlogTitle();
		List<CateVo> cateList = cateService.getCate(id);
		List<PostVo> postList = postService.readpost(cateNo);
		PostVo postVo = new PostVo();
		
		postVo = postService.postselect(postNo);
		List<CommentsVo> commentsList = commentsService.getComments(postVo.getPostNo());
		
		mav.addObject("postVo", postVo);
		mav.addObject("postNo", postNo);
		mav.addObject("postList", postList);
		mav.addObject("cateList", cateList);
		mav.addObject("blogVo", blogVo);
		mav.addObject("blogTitle", blogTitle);
		mav.addObject("id", id);
		mav.addObject("commentsList", commentsList);
		mav.setViewName("/blog/blog-main");

		return mav;
	}
	
	/*블로그 관리 기본설정폼 출력*/
	@RequestMapping("/{id}/admin/basic")
	public ModelAndView basicManagement(ModelAndView mav, @PathVariable String id) {
		
		BlogVo blogVo = blogService.getBlog(id);
		mav.addObject("blogVo", blogVo);
		mav.setViewName("/blog/admin/blog-admin-basic");
		
		return mav;
	}
	
	/*블로그 관리 기본설정 변경*/
	@RequestMapping(value="/{id}/admin/basic/update", method=RequestMethod.POST)
	public String updateBasicManagement(@ModelAttribute BlogVo blogVo, MultipartFile file, HttpServletRequest request, @PathVariable String id){
		blogVo.setId(id);

		// 업데이트 전 로고 파일 데이터
		BlogVo originVo = blogService.getBlog(id);
		String originLogoFile = originVo.getLogoFile();
		
		String fileName = file.getOriginalFilename();
		if(fileName.equals("")) {
			blogVo.setLogoFile(originLogoFile);
		}else {
			SimpleDateFormat format = new SimpleDateFormat ("yyyyMMddHHmmss");
			Date time = new Date();
			String nowTime = format.format(time);
			
			fileName = nowTime + "_" + id + fileName;
			blogVo.setLogoFile(fileName);
		}
    	
		int isUpdated = blogService.updateBlog(blogVo);
		if(isUpdated == 1) {
			try {
				String path = request.getServletContext().getRealPath("/resources");

				File Folder = new File(path + "/upload");
				if (!Folder.exists()) {
					Folder.mkdir();
		        } 
				
				// 변경된 로고 이미지 저장
				String uploadFolder = path + "/upload";
				File saveFile = new File(uploadFolder, fileName);
				file.transferTo(saveFile);
				
				// 기존의 로고 이미지 삭제
				File originFile = new File(uploadFolder, originLogoFile);
				if(originFile.exists()) {
					originFile.delete();
				}
				
			}catch(Exception e) {
				log.error(e.getMessage());
			}
		}
		
		return "redirect:/jblog/{id}/admin/basic";
	}

	/*블로그 관리 카테고리폼 출력*/
	@RequestMapping("/{id}/admin/category")
	public ModelAndView categoryManagement(ModelAndView mav, @PathVariable String id) {
		// 카테고리 리스트 가져오기
		List<CateVo> cateList = cateService.getCate(id);
		
		// 사용자 블로그 타이틀 가져오기
		BlogVo blogVo = blogService.getBlog(id);
		String blogTitle = blogVo.getBlogTitle();
		
		mav.addObject("cateList", cateList);
		mav.addObject("blogTitle", blogTitle);
		mav.setViewName("/blog/admin/blog-admin-cate");
		
		return mav;
	}

	/*블로그 관리 카테고리 추가*/
	@ResponseBody
	@RequestMapping(value="/{id}/admin/category", method=RequestMethod.POST)
	public HashMap<String, Object> addCategoryManagement(ModelAndView mav, HttpServletRequest request, @PathVariable String id) {
		CateVo cateVo = new CateVo();
		cateVo.setCateName(request.getParameter("name"));
		cateVo.setDescription(request.getParameter("desc"));
		
		cateVo.setId(id);
		
		cateService.insertCate(cateVo);
		
		List<CateVo> cateList = cateService.getCate(id);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("result", "success");
		map.put("cateList", cateList);
		
		return map;
	}

	/*블로그 관리 글작성폼 출력*/
	@RequestMapping("/{id}/admin/write")
	public ModelAndView writeManagement(ModelAndView mav, @PathVariable String id) {
		// 카테고리 리스트 가져오기
		List<CateVo> cateList = cateService.getCate(id);
		
		// 사용자 블로그 타이틀 가져오기
		BlogVo blogVo = blogService.getBlog(id);
		String blogTitle = blogVo.getBlogTitle();
		
		mav.addObject("cateList", cateList);
		mav.addObject("blogTitle", blogTitle);
		mav.setViewName("/blog/admin/blog-admin-write");
		
		return mav;
	}
	
	/*카테고리 삭제*/
	@ResponseBody
	@RequestMapping(value="/{id}/remove/category", method=RequestMethod.POST)
	public HashMap<String, Object> removeCategory(ModelAndView mav, HttpServletRequest request, @PathVariable String id) {
		boolean isDeleted = cateService.deleteCate(Integer.parseInt(request.getParameter("cateNo")));
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		if(isDeleted == true) {
			List<CateVo> cateList = cateService.getCate(id);
			map.put("result", "success");
			map.put("cateList", cateList);
		} else {
			map.put("result", "fail");
		}
		
		return map;
	}

}
