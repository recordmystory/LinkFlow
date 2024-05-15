package com.mm.linkflow.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mm.linkflow.dto.EdocFormDto;
import com.mm.linkflow.dto.MemberDto;
import com.mm.linkflow.dto.PageInfoDto;
import com.mm.linkflow.service.service.EdsmCrTempService;
import com.mm.linkflow.util.PagingUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 * @author sdl13
 *
 */
@RequestMapping("/edsm/crtemp")
@Controller
@RequiredArgsConstructor
@Slf4j
public class EdsmCrtempController {
	private final EdsmCrTempService edsmCrTempService;
	private final PagingUtil pagingUtil;
	// private final FileUtil fileUtil;
	
	@GetMapping("/enrollForm.crtp")
	public String EnrollForm() {
		return "/edsm/crtemp/enrollForm";
	}
	
	@GetMapping("/detail.crtp")
	public String detail() {
		return "/edsm/crtemp/detail";
	}
	
	/** 양식 목록 조회 및 페이징
	 * (한 페이지당 10개씩 나오도록 페이징)
	 * 
	 * @param currentPage
	 * @param mv
	 * @return mv
	 * 
	 * @author 김지우
	 */
	
	@GetMapping("/list.crtp")
	public ModelAndView list(@RequestParam(value="page", defaultValue="1") int currentPage, ModelAndView mv) {
		int listCount = edsmCrTempService.selectCrTempListCnt();
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 10, 10);
		List<EdocFormDto> list = edsmCrTempService.selectCrTempList(pi);
		
		mv.addObject("pi", pi).addObject("list", list).setViewName("edsm/crtemp/list");
		
		return mv;
	}
	
	/** 양식 셍성 (등록)
	 * 
	 * @param edsmForm
	 * @param session
	 * @param redirectAttributes
	 * @param response
	 * @return redirect:/edsm/crtemp/list.crtp 양식 목록 페이지로 이동
	 * 
	 * @author 김지우
	 */
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
