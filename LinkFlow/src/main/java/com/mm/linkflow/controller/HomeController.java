package com.mm.linkflow.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mm.linkflow.dto.BoardDto;
import com.mm.linkflow.dto.MemberDto;
import com.mm.linkflow.service.service.AttemdamceService;
import com.mm.linkflow.service.service.BoardService;
import com.mm.linkflow.service.service.MemberService;
import com.mm.linkflow.util.MonthUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Controller
public class HomeController {
	private final AttemdamceService attService;
	private final MemberService mService;
	private final BoardService boardService;
	private final BCryptPasswordEncoder bcryptPwdEncoder;
	private final MonthUtil monthUtil;
	/**
	 * 테스트로 게시판리스트조회로함 나중에 로그인페이지로 하셈
	 * @return
	 */
	@RequestMapping("/")
	public String mainPage() {
		return "login";
	}
	
	@RequestMapping("/main")
	public String mainfoward(HttpServletRequest req) {
		List<BoardDto> list = boardService.selectNewNoticeList();
		int male = mService.selectMale();
		int female = mService.selectFemale();
		req.getSession().setAttribute("oneMonth", monthUtil.monthReturn(0));
		req.getSession().setAttribute("oneMonthMember", mService.selectAllMember(monthUtil.monthReturn(0)));
		req.getSession().setAttribute("oneMonthHire", mService.selectHireMember(monthUtil.monthReturn(0)));
		req.getSession().setAttribute("oneMonthRetire", mService.selectRetireMember(monthUtil.monthReturn(0)));
		
		req.getSession().setAttribute("twoMonth", monthUtil.monthReturn(2));
		req.getSession().setAttribute("twoMonthMember", mService.selectAllMember(monthUtil.monthReturn(2)));
		req.getSession().setAttribute("twoMonthHire", mService.selectHireMember(monthUtil.monthReturn(2)));
		req.getSession().setAttribute("twoMonthRetire", mService.selectRetireMember(monthUtil.monthReturn(2)));
		
		req.getSession().setAttribute("threeMonth", monthUtil.monthReturn(3));
		req.getSession().setAttribute("threeMonthMember", mService.selectAllMember(monthUtil.monthReturn(3)));
		req.getSession().setAttribute("threeMonthHire", mService.selectHireMember(monthUtil.monthReturn(3)));
		req.getSession().setAttribute("threeMonthRetire", mService.selectRetireMember(monthUtil.monthReturn(3)));
		
		req.getSession().setAttribute("fourMonth", monthUtil.monthReturn(4));
		req.getSession().setAttribute("fourMonthMember", mService.selectAllMember(monthUtil.monthReturn(4)));
		req.getSession().setAttribute("fourMonthHire", mService.selectHireMember(monthUtil.monthReturn(4)));
		req.getSession().setAttribute("fourMonthRetire", mService.selectRetireMember(monthUtil.monthReturn(4)));
		
		req.getSession().setAttribute("fiveMonth", monthUtil.monthReturn(5));
		req.getSession().setAttribute("fiveMonthMember", mService.selectAllMember(monthUtil.monthReturn(5)));
		req.getSession().setAttribute("fiveMonthHire", mService.selectHireMember(monthUtil.monthReturn(5)));
		req.getSession().setAttribute("fiveMonthRetire", mService.selectRetireMember(monthUtil.monthReturn(5)));
		
		req.getSession().setAttribute("sixMonth", monthUtil.monthReturn(6));
		req.getSession().setAttribute("sixMonthMember", mService.selectAllMember(monthUtil.monthReturn(6)));
		req.getSession().setAttribute("sixMonthHire", mService.selectHireMember(monthUtil.monthReturn(6)));
		req.getSession().setAttribute("sixMonthRetire", mService.selectRetireMember(monthUtil.monthReturn(6)));
	
		req.getSession().setAttribute("list", list);
		req.getSession().setAttribute("male", male);
		req.getSession().setAttribute("female", female);
		return "mainpage/main";
	}
	
	
	@PostMapping("/main/mainpage")
	public void login(MemberDto m, HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException {
		
			MemberDto loginUser = mService.loginMember(m);
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			if (loginUser != null && bcryptPwdEncoder.matches(m.getUserPwd(), loginUser.getUserPwd())) {
				int checkIn = attService.selectCheckIn(loginUser.getUserId());
				if(checkIn == 0) {
					attService.checkInAtt(loginUser.getUserId());
				}
				req.getSession().setAttribute("loginUser", loginUser);
				out.println("alert('" + loginUser.getUserName() +"님이 로그인 하였습니다.');");
				out.println("location.href= '" + req.getContextPath() + "/main';");
	        } else {
	        	out.println("alert('로그인 실패하였습니다. 아이디 및 비밀번호를 다시 확인해주세요.');");
	        	out.println("history.back();");
	        	
	        }
			out.println("</script>");
	}
	
	
}
