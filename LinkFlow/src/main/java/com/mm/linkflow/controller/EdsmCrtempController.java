package com.mm.linkflow.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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

@RequestMapping("/edsm/crtemp")
@Controller
@RequiredArgsConstructor
@Slf4j
public class EdsmCrtempController {
	private final EdsmCrTempService edsmCrTempService;
	private final PagingUtil pagingUtil;
	
	/** 양식 등록 페이지로 이동
	 * 
	 * @return /edsm/crtemp/enrollForm
	 * 
	 * @author 김지우
	 */
	@GetMapping("/enrollForm.crtp")
	public String EnrollForm() {
		return "/edsm/crtemp/enrollForm";
	}
	
	/** 양식 삭제 
	 * @param edFrCode
	 * @param redirectAttributes
	 * @return redirect:/edsm/crtemp/list.crtp 목록 조회 페이지로 이동
	 * 
	 * @author 김지우
	 */
	@PostMapping("/remove.crtp")
	public String remove(String edFrCode, RedirectAttributes redirectAttributes) {
		int result = edsmCrTempService.deleteCrTemp(edFrCode);
		
		if(result > 0) {
			redirectAttributes.addFlashAttribute("alertMsg", "양식 삭제가 완료되었습니다.");
		} else {
			redirectAttributes.addFlashAttribute("alertMsg", "양식 삭제에 실패했습니다.");
			redirectAttributes.addFlashAttribute("historyBackYN", "Y");
		}
		
		return "redirect:/edsm/crtemp/list.crtp";
		
		
	}
	/** 양식 수정 
	 * 
	 * @param edsmForm
	 * @param redirectAttributes
	 * @return redirect:/edsm/crtemp/detail.crtp?no=수정할 글 번호
	 * 
	 * @author 김지우
	 */
	@PostMapping("/modify.crtp")
	public String modify(EdocFormDto edsmForm, RedirectAttributes redirectAttributes) {
		int result = edsmCrTempService.updateCrTemp(edsmForm);
		
		if(result > 0) {
			redirectAttributes.addFlashAttribute("alertMsg", "양식 수정이 완료되었습니다.");
		} else {
			redirectAttributes.addFlashAttribute("alertMsg", "양식 수정에 실패했습니다.");
			redirectAttributes.addFlashAttribute("historyBackYN", "Y");
		}
		
		return "redirect:/edsm/crtemp/detail.crtp?no=" + edsmForm.getEdFrCode();
		
		
	}
	
	@PostMapping("/modifyForm.crtp")
	public String modifyForm(String edFrCode, Model model) {
//		log.debug("edsmForm : {}", edFrCode);
		model.addAttribute("crtp", edsmCrTempService.selectCrTemp(edFrCode));
		
		return "edsm/crtemp/modifyForm";
		
	}
	
	/** 양식 상세 조회
	 * @param no
	 * @param model
	 * @return /edsm/crtemp/detail
	 * 
	 * @author 김지우
	 */
	@GetMapping("/detail.crtp")
	public String detail(String no, Model model) {
		model.addAttribute("crtp", edsmCrTempService.selectCrTemp(no));
		
		return "/edsm/crtemp/detail";
	}
	
	/** 양식명으로 검색
	 * 
	 * @param currentPage
	 * @param search
	 * @param mv
	 * @return mv
	 * 
	 * @author 김지우
	 */
	@GetMapping("/search.crtp")
	public ModelAndView search(@RequestParam(value="page", defaultValue="1") int currentPage, @RequestParam Map<String, String> search, ModelAndView mv) {
		log.debug("search : {}", search);
		
		int listCount = edsmCrTempService.selectSearchListCnt(search);
		
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 10, 10);
		List<EdocFormDto> list = edsmCrTempService.selectSearchList(search, pi);
		
		mv.addObject("pi", pi).addObject("list", list).addObject("search", search).setViewName("edsm/crtemp/list");
		
		return mv;
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
