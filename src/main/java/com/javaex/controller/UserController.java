package com.javaex.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.javaex.service.UserService;
import com.javaex.vo.UserVo;

@Controller
@RequestMapping(value="/jblog/user")
public class UserController {

	@Autowired
	private UserService userService;
	
	/*회원가입폼 출력*/
	@RequestMapping(value="/join", method=RequestMethod.GET)
	public String joinForm() {
		return "user/joinForm";
	}
		
	// 회원가입
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String join(@ModelAttribute UserVo userVo) {
		userService.join(userVo);
		return "user/joinSuccess";
	}
	
	/*로그인폼 출력*/
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String loginForm() {
		return "user/loginForm";
	}
	
	/*로그인*/
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String login(@ModelAttribute UserVo userVo, HttpSession session) {
		UserVo authUser = userService.login(userVo);
	
		//세션처리
		if(authUser != null) { //성공시
			session.setAttribute("authUser", authUser);
			return "redirect:/";
		}else { //실패시
			return "redirect:/jblog/user/login?result=fail";
		}
		
	}
	
	/*로그아웃*/
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public String logout(HttpSession session) {
		session.removeAttribute("authUser");
		session.invalidate();
		return "redirect:/";
	}
	
}
