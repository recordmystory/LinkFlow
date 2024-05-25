package com.mm.linkflow.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mm.linkflow.dto.BoardCategoryDto;
import com.mm.linkflow.dto.MemberDto;
import com.mm.linkflow.dto.PageInfoDto;
import com.mm.linkflow.dto.ReceiveMailDto;
import com.mm.linkflow.dto.SendMailDto;
import com.mm.linkflow.service.service.AttachService;
import com.mm.linkflow.service.service.MailService;
import com.mm.linkflow.util.FileUtil;
import com.mm.linkflow.util.PagingUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/mail")
@RequiredArgsConstructor
@Controller
public class MailController {
	
	private final MailService mailService;
	private final AttachService attachService;
	private final PagingUtil pagingUtil;
	private final FileUtil fileUtil;
	
	private Map<String, Integer> selectSidebarCount(MemberDto loginUser) {
		
		Map<String, Integer> map = new HashMap<>();
		
		int nonReadCount = mailService.selectNonReadCount(loginUser);
		int trashCount = mailService.selectTrashCount(loginUser);
		
		map.put("readCount", nonReadCount);
		map.put("trashCount", trashCount);
		
		return map;
	}
	
	@GetMapping("/receiveList.do")
	public ModelAndView recevieList(HttpSession session,
							@RequestParam(value="page", defaultValue="1")int currentPage,
							ModelAndView mv) {
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		int listCount = mailService.selectReceiveListCount(loginUser);
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 5, 10);
		
		List<ReceiveMailDto> receiveMailList = mailService.selectReceiveList(pi, loginUser);
		
		Map<String, Integer> countMap = selectSidebarCount(loginUser);
		
		mv.addObject("pi", pi)
		  .addObject("countMap",countMap)
		  .addObject("receiveMailList", receiveMailList)
		  .setViewName("mail/receiveList");
		return mv;
	}
	
	@GetMapping("/sendList.do")
	public ModelAndView sendList(HttpSession session,
							@RequestParam(value="page", defaultValue="1")int currentPage,
							ModelAndView mv) {
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		int listCount = mailService.selectSendListCount(loginUser);
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 5, 10);
		
		List<SendMailDto> sendMailList = mailService.selectSendList(pi, loginUser);
		
		Map<String, Integer> countMap = selectSidebarCount(loginUser);
		
		mv.addObject("pi", pi)
		  .addObject("countMap",countMap)
		  .addObject("sendMailList", sendMailList)
		  .setViewName("mail/sendList");
		
		return mv;
	}
	
	@GetMapping("/detail.do") 
	public String detail(int no, Model model, HttpSession session) { // 게시글 상세 조회용 (내가 작성한 게시글 클릭시 곧바로 호출 | 수정완료 후 곧바로 호출)
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		Map<String, Integer> countMap = selectSidebarCount(loginUser);
		model.addAttribute("countMap", countMap);
		model.addAttribute("mail", mailService.selectMail(no));
		return "mail/detail";
	}
	
	@GetMapping("/readMail.do")
	public String updateMailRead(int no) {
		mailService.updateMailRead(no);	
		return "redirect:/mail/detail.do?no=" + no;
	}
}
