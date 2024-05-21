package com.mm.linkflow.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mm.linkflow.dto.AttachDto;
import com.mm.linkflow.dto.DeptDto;
import com.mm.linkflow.dto.EdocDto;
import com.mm.linkflow.dto.EdocFormDto;
import com.mm.linkflow.dto.EdocHistDto;
import com.mm.linkflow.dto.MemberDto;
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
	
	
	/** 기안
	 * 
	 * @param edocDto
	 * @param uploadFiles
	 * @param session
	 * @param redirectAttributes
	 * @return 진행중문서 목록 페이지로 redirect
	 */
	@PostMapping("/draftingDoc.prog")
	public String insertDoc(EdocDto edocDto, List<MultipartFile> uploadFiles, HttpSession session, RedirectAttributes redirectAttributes) {
		log.debug("edocDto : {}", edocDto);
		
		MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
		edocDto.setRegId(loginUser.getUserId());
		edocDto.setModId(loginUser.getUserId());
		
		// 결재이력 (결재자)
		// 결재작성문서
		// 참조자
		// 첨부파일
		
		// ** 휴가신청서일 경우 연차 insert
		
		
		
		return "redirect:/edsm/prog/listAll.prog";
		
	}
	

//	@ResponseBody
//	@PostMapping("/apprLine.prog")
//	public String ajaxApprLine(EdocHistDto edocHistDto){
//		int result = edsmProgService.insertApprLine(edocHistDto);
//		
//		return result > 0 ? "SUCCESS" : "FAIL";
//	}
	
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
	
//	@GetMapping("/apprEnrollForm.prog")
//	public String apprEnrollForm() {
//		return "/edsm/prog/apprEnrollForm";
//	}

	@GetMapping("/modifyForm.prog")
	public String apprModifyForm() {
		return "/edsm/prog/modifyForm";
	}

	@GetMapping("/detail.prog")
	public String detail() {
		return "/edsm/prog/detail";
	}

	@GetMapping("/listAll.prog")
	public String listAll() {
		return "/edsm/prog/listAll";
	}

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
