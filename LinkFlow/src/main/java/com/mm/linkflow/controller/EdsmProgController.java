package com.mm.linkflow.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringJoiner;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mm.linkflow.dto.DeptDto;
import com.mm.linkflow.dto.EdocDto;
import com.mm.linkflow.dto.EdocFormDto;
import com.mm.linkflow.dto.EdocRefDto;
import com.mm.linkflow.dto.MemberDto;
import com.mm.linkflow.dto.PageInfoDto;
import com.mm.linkflow.service.service.EdsmProgService;
import com.mm.linkflow.util.FileUtil;
import com.mm.linkflow.util.PagingUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/edsm/prog")
@Controller
@RequiredArgsConstructor
public class EdsmProgController {
	private final EdsmProgService edsmProgService;
	private final PagingUtil pagingUtil;
	private final FileUtil fileUtil;
	
	
	/** 진행중인 문서 목록 조회 (전체)
	 * 
	 * @param currentPage
	 * @param session
	 * @param memberDto
	 * @param mv
	 * @return mv
	 * 
	 * @author 김지우
	 */
	
	@GetMapping("/listAll.prog")
	public ModelAndView selectListAll(@RequestParam(value="page", defaultValue="1") int currentPage, HttpSession session, MemberDto memberDto, ModelAndView mv) {
		MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
		
		int listCount = edsmProgService.selectAllListCnt(loginUser.getUserId());
		
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 10, 10);
		
		List<EdocFormDto> list = edsmProgService.selectAllList(pi, loginUser.getUserId());
		
		mv.addObject("pi", pi).addObject("list", list).addObject("listCnt", listCount).setViewName("edsm/prog/listAll");
		
		return mv;
	}
	
	/** 기안
	 * 
	 * @param edocDto
	 * @param uploadFiles
	 * @param session
	 * @param redirectAttributes
	 * @return 진행중문서 목록 페이지로 redirect
	 */
	@PostMapping("/draftingDoc.prog")
	public String insertDoc(String approvalUserId1, String approvalUserId2, String refUserId,  EdocDto edocDto, List<MultipartFile> uploadFiles, HttpSession session, RedirectAttributes redirectAttributes) {
		
		log.debug("approvalUserId1 : {}", approvalUserId1);
		log.debug("approvalUserId2 : {}", approvalUserId2);
		log.debug("userId : {}", refUserId);
		log.debug("edocDto : {}", edocDto);
		MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
		
		edocDto.setRegId(loginUser.getUserId());
		edocDto.setModId(loginUser.getUserId());
		int result = edsmProgService.insertDoc(edocDto);
		
		if(result >0) {
			redirectAttributes.addFlashAttribute("alertMsg","성공");
		}else {
			redirectAttributes.addFlashAttribute("alertMsg","실패");
		}
	

		
		return "redirect:/edsm/prog/listAll.prog";
		
	}
	
	/** 문서 종류에 따른 문서 양식 에디터 내에 조회
	 * 
	 * @param docType
	 * @return edsmProgService.selectEdFrContentList
	 */
	@ResponseBody
	@PostMapping("/edFrContentList.prog")
	public List<EdocFormDto> ajaxEdFrContentList(String docType){
		return edsmProgService.selectEdFrContentList(docType);
	}
	
	
	/** 문서 종류와 문서 종류에 따른 양식 조회, 결재선 설정 모달 내 팀명, 사원 조회 
	 * 
	 * @param mv
	 * @return mv
	 * 
	 * @author 엄희강, 김지우
	 */
	@GetMapping("/apprEnrollForm.prog")
	public ModelAndView apprEnrollForm(ModelAndView mv) {
		
		// 문서 종류 조회
		List<EdocFormDto> list = edsmProgService.selectFormList();
		
		// 결재선 설정 모달 조회
		List<DeptDto> apprList = edsmProgService.selectApprLine();
	
		
		mv.addObject("list", list).addObject("apprList", apprList).setViewName("edsm/prog/apprEnrollForm");
		
		return mv;
	}
	
	@GetMapping("/modifyForm.prog")
	public String apprModifyForm() {
		return "/edsm/prog/modifyForm";
	}

	@GetMapping("/detail.prog")
	public String detail() {
		return "/edsm/prog/detail";
	}

//	@GetMapping("/listAll.prog")
//	public String listAll() {
//		return "/edsm/prog/listAll";
//	}

	@GetMapping("/listCheck.prog")
	public String listCheck() {
		return "/edsm/prog/listCheck";
	}

	@GetMapping("/listPlan.prog")
	public String listPlan() {
		return "/edsm/prog/listPlan";
	}

	@GetMapping("/listProg.prog")
	public String listProg() {
		return "/edsm/prog/listProg";
	}

	@GetMapping("/listWait.prog")
	public String listWait() {
		return "/edsm/prog/listWait";
	}

}
