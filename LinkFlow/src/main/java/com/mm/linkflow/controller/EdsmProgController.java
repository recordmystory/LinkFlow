package com.mm.linkflow.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
import com.mm.linkflow.dto.EdocHistDto;
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
	
	
	/** 진행중인 문서 상세 : 결재
	 * 
	 * @param edocHistDto
	 * @param session
	 * @param RedirectAttribute
	 * @return 목록 페이지로 redirect
	 * 
	 * @author 김지우
	 */
	@PostMapping("/approval.prog")
	public String updateEdocHist(EdocHistDto edocHistDto, HttpSession session, RedirectAttributes RedirectAttribute) {
		
		MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
		edocHistDto.setUserId(loginUser.getUserId());

		int result = edsmProgService.updateEdocHist(edocHistDto);
		
		int status = 1;
		if(edocHistDto.getEdHistSubCode().equals("01")) {
			// 승인시 tb_edoc_histd의 해당 문서에 ED_HIST_SUB_CODE가 01를 조회해서 3개시 
			int count = edsmProgService.selectEdHistSubCodeCnt(edocHistDto);
			if(count == 3) {
				//반려시 tb_eddoc의 status를 05로 업데이트
				status = 0;
				status = edsmProgService.updateEdocStatusAppr(edocHistDto);
			}
			
		}else if (edocHistDto.getEdHistSubCode().equals("02")){
			//반려시 tb_eddoc의 status를 06로 업데이트
			status = 0;
			status = edsmProgService.updateEdocStatusCxl(edocHistDto);			
		}
		
		log.debug("결재 여부 : {}", edocHistDto);
		
		if(result * status > 0) {
			RedirectAttribute.addFlashAttribute("alertMsg", "결재가 완료되었습니다.");
		} else {
			RedirectAttribute.addFlashAttribute("alertMsg", "결재에 실패했습니다.");			
		}
		
		return "redirect:/edsm/prog/listAll.prog";
	}
	
	@GetMapping("/modifyDelYn.prog")
	public String modifyDelYn(String edNo, RedirectAttributes redirectAttribute) {
		log.debug(edNo);
		
		int result = edsmProgService.modifyDelYn(edNo);
		
		if(result > 0) {
			redirectAttribute.addFlashAttribute("alertMsg", "기안 취소가 완료되었습니다.");
		} else {			
			redirectAttribute.addFlashAttribute("alertMsg", "기안 취소에 실패했습니다.");
		}
		
		return "redirect:/edsm/prog/listAll.prog";
	}
	
	/** 진행중인 문서 상세 조회 - 보안등급 수정
	 * 
	 * @param edocDto
	 * @param redirectAttribute
	 * @return detail 페이지로 redirect
	 * 
	 * @author 김지우
	 */
	@GetMapping("/modifySecCode.prog")
	public String modifySecCode(EdocDto edocDto, RedirectAttributes redirectAttribute) {
		// log.debug("edocDto : {}", edocDto);
		
		int result = edsmProgService.updateSecCode(edocDto);
		
		if(result > 0) {
			redirectAttribute.addFlashAttribute("alertMsg", "보안등급 수정이 완료되었습니다.");
		} else {
			redirectAttribute.addFlashAttribute("alertMsg", "보안등급 수정에 실패했습니다.");			
		}
		return "redirect:/edsm/prog/listAll.prog";
	}

	@GetMapping("/detail.prog")
	public String detail(String edNo, Model model) {
		log.debug("edNo : {}", edNo);
		
		model.addAttribute("edoc", edsmProgService.selectEdocDetail(edNo));
		
		return "/edsm/prog/detail";
	}
	
	/** 진행중인 문서 목록 (전체) 검색
	 * 
	 * @param currentPage
	 * @param search
	 * @param session
	 * @param mv
	 * @return mv
	 */
	@GetMapping("/search.prog")
	public ModelAndView search(@RequestParam(value="page", defaultValue="1") int currentPage,
			   @RequestParam Map<String, String> search, HttpSession session,
			   ModelAndView mv) {
		
		MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
		search.put("userId", loginUser.getUserId());
		// log.debug("search : {}", search);
		
		int listCount = edsmProgService.selectSearchListCnt(search);
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 10, 10);
		List<EdocDto> list = edsmProgService.selectSearchList(search, pi);
		
		mv.addObject("pi", pi)
		  .addObject("list", list)
		  .addObject("search", search)
		  .addObject("listCnt", listCount)
		  .setViewName("edsm/prog/listAll");
		
		return mv;
	}
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
	 * 
	 * @author 엄희강
	 */
	@PostMapping("/draftingDoc.prog")
	public String insertDoc(EdocDto edocDto, List<MultipartFile> uploadFiles,HttpSession session, RedirectAttributes redirectAttributes) {
		
	
	
		MemberDto loginUser = (MemberDto) session.getAttribute("loginUser");
		ArrayList<EdocHistDto> edocHistList = edocDto.getEdocHistList();
		ArrayList<EdocRefDto> EdocRefList = edocDto.getEdocRefList();
		
		
		edocDto.setRegId(loginUser.getUserId());
		edocDto.setModId(loginUser.getUserId());

		
		if(edocHistList != null) {
			int count = 1;
			for(EdocHistDto EdocHistDto : edocHistList) {
				if(count == 1) {
				EdocHistDto.setEdHistOrder(count);
				EdocHistDto.setEdHistSubCode("01");
				EdocHistDto.setModId(loginUser.getUserId());
				EdocHistDto.setRegId(loginUser.getUserId());
				EdocHistDto.setEdFormCode(edocDto.getEdFormCode());
				count++; 
				}else {
				EdocHistDto.setEdHistOrder(count);
				EdocHistDto.setEdHistSubCode(null);
				EdocHistDto.setModId(loginUser.getUserId());
				EdocHistDto.setRegId(loginUser.getUserId());
				EdocHistDto.setEdFormCode(edocDto.getEdFormCode());
				
				count++;
				}
			}
		}
		
		if(EdocRefList != null) {
			for(EdocRefDto EdocRefDto : EdocRefList) {
				EdocRefDto.setModId(loginUser.getUserId());
				EdocRefDto.setRegId(loginUser.getUserId());
				EdocRefDto.setEdFormCode(edocDto.getEdFormCode());
				
			}
		}
		
		int result = edsmProgService.insertDoc(edocDto);
		
		if(result>0) {
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
