package com.mm.linkflow.controller;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mm.linkflow.dto.BoardCategoryDto;
import com.mm.linkflow.dto.CommonTableDto;
import com.mm.linkflow.dto.DeptDto;
import com.mm.linkflow.dto.MemberDto;
import com.mm.linkflow.service.service.GroupService;
import com.mm.linkflow.service.service.HrService;

import lombok.RequiredArgsConstructor;

@RequestMapping("/hr")
@RequiredArgsConstructor
@Controller
public class HRcontroller {
	private final GroupService gService;
	private final HrService hService;
	private final BCryptPasswordEncoder bcryptPwdEncoder;
	@RequestMapping("/hrPage")
	public String hrPage(Model model) {
		
		List<MemberDto> hrList = hService.selectMemberList();
		
		model.addAttribute("list",hrList);
		return "hr/hrPage";
	}
	
	@ResponseBody
	@GetMapping("/search.do")
	public List<MemberDto> search(String keyword) {
		return hService.searhMemberList(keyword);
	}
	
	@RequestMapping("/hrUpdatePage.go")
	public String hrUpdatePage(Model model) {
		List<DeptDto> dList = hService.selectDeftList();
		List<CommonTableDto> cList = hService.selectCommonTableList();
		
		model.addAttribute("dList",dList);
		model.addAttribute("cList",cList);
		
		return "hr/hrUpdate";
	}
	
	@PostMapping("/insertMember.do")
	public String insertMember(MemberDto m,RedirectAttributes redirectAttributes) {
		 String[] rights = m.getRight();
		    
		    m.setSuperRight("N");
		    m.setHrRight("N");
		    m.setSpRight("N");
		    m.setBoardRight("N");
		    m.setDeptRight("N");

		  
		    if (rights != null) {
		        for (int i = 0; i < rights.length; i++) {
		            switch (rights[i]) {
		                case "1":
		                    m.setSuperRight("Y");
		                    m.setHrRight("Y");
		                    m.setSpRight("Y");
		                    m.setBoardRight("Y");
		                    m.setDeptRight("Y");
		                    break;
		                case "2":
		                    m.setHrRight("Y");
		                    break;
		                case "3":
		                    m.setSpRight("Y");
		                    break;
		                case "4":
		                    m.setBoardRight("Y");
		                    break;
		                case "5":
		                    m.setDeptRight("Y");
		                    break;
		            }
		        }
		    } 
		
		m.setUserPwd(bcryptPwdEncoder.encode(m.getUserPwd()));
		
		int result = hService.insertMember(m);
		if(result > 0) {
			redirectAttributes.addFlashAttribute("alertMsg", "성공적으로 사원 추가가 되었습니다.");
			
		}else {
			redirectAttributes.addFlashAttribute("alertMsg", "사원추가 실패하였습니다.");
			
		}
		return "redirect:/hr/hrPage";
	}
	
	@ResponseBody
	@PostMapping("/checkId")
	public String checkId(String checkId) {
		int result = hService.checkId(checkId);
		
		return result > 0 ? "NNNNN" : "YYYYY" ; 
	}
	
	@RequestMapping("/detailMember")
	public String detailMember(String id,Model model) {
		MemberDto m = hService.selectDatailMember(id);
		List<DeptDto> dList = hService.selectDeftList();
		List<CommonTableDto> cList = hService.selectCommonTableList();
		
		model.addAttribute("dList",dList);
		model.addAttribute("cList",cList);
		model.addAttribute("m",m);
		return "hr/hrDetail";
	}
	
	@PostMapping("/updateInfoMember.do")
	public String udateInfoMember (MemberDto m,RedirectAttributes redirectAttributes) {
		String[] rights = m.getRight();
	    
	    m.setSuperRight("N");
	    m.setHrRight("N");
	    m.setSpRight("N");
	    m.setBoardRight("N");
	    m.setDeptRight("N");

	  
	    if (rights != null) {
	        for (int i = 0; i < rights.length; i++) {
	            switch (rights[i]) {
	                case "1":
	                	 m.setSuperRight("Y");
	                     m.setHrRight("Y");
	                     m.setSpRight("Y");
	                     m.setBoardRight("Y");
	                     m.setDeptRight("Y");
	                    break;
	                case "2":
	                    m.setHrRight("Y");
	                    break;
	                case "3":
	                    m.setSpRight("Y");
	                    break;
	                case "4":
	                    m.setBoardRight("Y");
	                    break;
	                case "5":
	                    m.setDeptRight("Y");
	                    break;
	            }
	        }
	    } 
	
	    
	
	int result = hService.updateInfoMember(m);
	if(result > 0) {
		redirectAttributes.addFlashAttribute("alertMsg", "성공적으로 사원 변경이 완료되었습니다.");
		
	}else {
		redirectAttributes.addFlashAttribute("alertMsg", "사원 정보 변경 실패하였습니다.");
		
	}
	return "redirect:/hr/hrPage";
	}
	
	@ResponseBody
	@PostMapping("/changePassword")
	public String changePassword(MemberDto m) {
		String userPwd = bcryptPwdEncoder.encode("linkflow123@");
		m.setUserPwd(userPwd);
		
		int result = hService.resetPasswoard(m);
		
		return result > 0 ? "YYYYY" : "NNNNN";
		
		
	}
	
	@ResponseBody
	@PostMapping("/goRetire")
	public String goRetire(MemberDto m) {

		int result = hService.goRetire(m);
		
		return result > 0 ? "YYYYY" : "NNNNN";
		
		
	}
	
	@ResponseBody
	@PostMapping("/goJoinPathy")
	public String goJoinPathy(MemberDto m) {

		int result = hService.goJoinPathy(m);
		
		return result > 0 ? "YYYYY" : "NNNNN";
		
		
	}
	
	@RequestMapping("/deptUpdate.do")
	public String deptUpdate(Model model) {
		List<MemberDto> group =  gService.groupList();
		
		model.addAttribute("g",group);
		
		
		
		return "hr/deptUpdate";
	}
	
	@PostMapping("/deptinsert.do")
	public String updateDept(DeptDto d, Model model,RedirectAttributes redirectAttributes) {
	
		BoardCategoryDto bd = new BoardCategoryDto();
		bd.setCategoryName(d.getDeptTitle());
		bd.setDeptCode(d.getDeptCode());
		bd.setCategoryType("DEPT");
		bd.setRegId(d.getRegId());
		bd.setModId(d.getModId());
		
		int result1 = hService.insertDept(d);
		int result = hService.insertCategory(bd);
		if(result * result1 > 0) {
			redirectAttributes.addFlashAttribute("alertMsg", "성공적으로 부서 등록이 완료되었습니다.");
			
		}else {
			redirectAttributes.addFlashAttribute("alertMsg", "부서 등록에 실패하였습니다.");
			
		}
		
		
		return "redirect:/hr/deptUpdate.do";
	}
	
	@ResponseBody
	@PostMapping("/UpdateDept")
	public String UpdateDept(DeptDto d, HttpSession session,RedirectAttributes redirectAttributes) {
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		
		BoardCategoryDto bd = new BoardCategoryDto();
		bd.setCategoryName(d.getDeptTitle());
		bd.setDeptCode(d.getDeptCode());
		bd.setCategoryType("DEPT");
		bd.setModId(loginUser.getUserId());
		
		d.setModId(loginUser.getUserId());
		int result1 = hService.updateDeptTable(d);
		int result = hService.updateDept(bd);
		
		return result * result1 > 0 ? "YYYYY" : "NNNNN";
		
	}
	
	@ResponseBody
	@PostMapping("/deleteDept")
	public String deleteDept(DeptDto d, HttpSession session,RedirectAttributes redirectAttributes) {
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		BoardCategoryDto bd = new BoardCategoryDto();
		bd.setDeptCode(d.getDeptCode());
		bd.setModId(loginUser.getUserId());
		
		d.setModId(loginUser.getUserId());
		
		int result = hService.DeleteDeptTable(d);
		int result1 = hService.deleteDept(bd);
		
		return result * result1 > 0 ? "YYYYY" : "NNNNN";
	}
	
	@ResponseBody
	@PostMapping("/checkCode")
	public String checkCode(String deptCode) {
		int result = hService.checkCode(deptCode);
		
		return result > 0 ? "NNNNN" : "YYYYY" ; 
	}
	
}
