package com.mm.linkflow.controller;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mm.linkflow.dto.CommonTableDto;
import com.mm.linkflow.dto.DeptDto;
import com.mm.linkflow.dto.MemberDto;
import com.mm.linkflow.service.service.HrService;

import lombok.RequiredArgsConstructor;

@RequestMapping("/hr")
@RequiredArgsConstructor
@Controller
public class HRcontroller {
	
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
}
