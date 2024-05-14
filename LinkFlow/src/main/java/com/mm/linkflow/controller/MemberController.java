package com.mm.linkflow.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mm.linkflow.dto.MemberDto;
import com.mm.linkflow.service.service.MemberService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/member")
@RequiredArgsConstructor
public class MemberController {
	
	//로그아웃
	@RequestMapping("/loginout.me")
	public String signout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	@RequestMapping("/myinfo.page")
	public String mypage() {
		return "member/mypage";
	}
	
	@RequestMapping("myinfoUpdate.page")
	public String mypageUpdate() {
		return "member/mypageUpdate";
	}
	
	@RequestMapping("myAttendance.page")
	public String myAttendance() {
		return "member/myAttendance";
	}
		
}

