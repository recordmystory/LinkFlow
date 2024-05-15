package com.mm.linkflow.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mm.linkflow.dto.EdocFormDto;
import com.mm.linkflow.dto.MemberDto;
import com.mm.linkflow.service.service.EdsmCrTempService;
import com.mm.linkflow.util.PagingUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/edsm/crtemp")
@Controller
@RequiredArgsConstructor
@Slf4j
public class EdsmCrtempController {
	private final EdsmCrTempService edsmCrTempService;
	private final PagingUtil pagingUtil;
	// private final FileUtil fileUtil;
	
	@GetMapping("/list.crtp")
	public String list() {
		return "/edsm/crtemp/list";
	}
	
	@GetMapping("/enrollForm.crtp")
	public String EnrollForm() {
		return "/edsm/crtemp/enrollForm";
	}
	
	@GetMapping("/detail.crtp")
	public String detail() {
		return "/edsm/crtemp/detail";
	}
	
	@PostMapping("/registTemplate.crtp")
	public String insertForm(EdocFormDto edsmForm, HttpSession session, RedirectAttributes redirectAttributes, HttpServletResponse response) {
		MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
		edsmForm.setRegId(loginUser.getUserId());
		edsmForm.setModId(loginUser.getUserId());
		
		log.debug("edsmForm : {}", edsmForm);
		
		int result = edsmCrTempService.insertForm(edsmForm);
		
		if(result > 0) {
			redirectAttributes.addFlashAttribute("alertMsg", "양식 생성이 완료되었습니다.");
		} else {
			redirectAttributes.addFlashAttribute("alertMsg", "게시판 글 작성에 실패했습니다.");
			
			try {
				PrintWriter out = response.getWriter();
				out.println("history.back();");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return "redirect:/edsm/crtemp/list.crtp";
	}
}
