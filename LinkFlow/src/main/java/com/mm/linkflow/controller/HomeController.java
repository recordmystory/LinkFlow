package com.mm.linkflow.controller;

import java.io.IOException;
import java.io.PrintWriter;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mm.linkflow.dto.MemberDto;
import com.mm.linkflow.service.service.MemberService;


import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class HomeController {
	private final MemberService mService;
	/**
	 * 테스트로 게시판리스트조회로함 나중에 로그인페이지로 하셈
	 * @return
	 */
	@RequestMapping("/")
	public String mainPage() {
		return "login";
	}
	
	
	@PostMapping("main/mainpage")
	public String login(MemberDto m, HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException {
		
		MemberDto loginUser = mService.loginMember(m);
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			if (loginUser != null) {
				req.getSession().setAttribute("loginUser", loginUser);
				out.println("alert('" + loginUser.getUserName() +"님이 로그인 하였습니다.');");
				out.println("</script>");
				return "mainpage/main";
	        } else {
	        	out.println("alert('로그인 실패하였습니다. 아이디 및 비밀번호를 다시 확인해주세요.');");
	        	out.println("</script>");
	        	return "/login";
	        	
	        }
		
	    }
	
}
