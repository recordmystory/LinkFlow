package com.mm.linkflow.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

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
	public ModelAndView mainfoward(ModelAndView mv) {
		
		mv.addObject("list", boardService.selectNewNoticeList())
		  .addObject("male", mService.selectMale())
		  .addObject("female", mService.selectFemale())
		  .addObject("oneMonth", monthUtil.monthReturn(1))
		  .addObject("oneMonthMember", mService.selectAllMember(monthUtil.monthReturn(1)))
		  .addObject("oneMonthHire", mService.selectHireMember(monthUtil.monthReturn(1)))
		  .addObject("oneMonthRetire", mService.selectRetireMember(monthUtil.monthReturn(1)))
		  .addObject("twoMonth", monthUtil.monthReturn(2))
		  .addObject("twoMonthMember", mService.selectAllMember(monthUtil.monthReturn(2)))
		  .addObject("twoMonthHire", mService.selectHireMember(monthUtil.monthReturn(2)))
		  .addObject("twoMonthRetire", mService.selectRetireMember(monthUtil.monthReturn(2)))
		  .addObject("threeMonth", monthUtil.monthReturn(3))
		  .addObject("threeMonthMember", mService.selectAllMember(monthUtil.monthReturn(3)))
		  .addObject("threeMonthHire", mService.selectHireMember(monthUtil.monthReturn(3)))
		  .addObject("threeMonthRetire", mService.selectRetireMember(monthUtil.monthReturn(3)))
		  .addObject("fourMonth", monthUtil.monthReturn(4))
		  .addObject("fourMonthMember", mService.selectAllMember(monthUtil.monthReturn(4)))
		  .addObject("fourMonthHire", mService.selectHireMember(monthUtil.monthReturn(4)))
		  .addObject("fourMonthRetire", mService.selectRetireMember(monthUtil.monthReturn(4)))
		  .addObject("fiveMonth", monthUtil.monthReturn(5))
		  .addObject("fiveMonthMember", mService.selectAllMember(monthUtil.monthReturn(5)))
		  .addObject("fiveMonthHire", mService.selectHireMember(monthUtil.monthReturn(5)))
		  .addObject("fiveMonthRetire", mService.selectRetireMember(monthUtil.monthReturn(5)))
		  .addObject("sixMonth", monthUtil.monthReturn(6))
		  .addObject("sixMonthMember", mService.selectAllMember(monthUtil.monthReturn(6)))
		  .addObject("sixMonthHire", mService.selectHireMember(monthUtil.monthReturn(6)))
		  .addObject("sixMonthRetire", mService.selectRetireMember(monthUtil.monthReturn(6)))
		  .setViewName("mainpage/main");
	
		return mv;
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
