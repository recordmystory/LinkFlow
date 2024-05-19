package com.mm.linkflow.controller;

import java.util.List;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
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
		
		m.setUserPwd(bcryptPwdEncoder.encode("linkflow123@") );
		int result = hService.insertMember(m);
		if(result > 0) {
			redirectAttributes.addFlashAttribute("alertMsg", "성공적으로 사원 추가가 되었습니다.");
			
		}else {
			redirectAttributes.addFlashAttribute("alertMsg", "사원추가 실패하였습니다.");
			redirectAttributes.addFlashAttribute("historyBackYN", "Y");
		}
		return "hr/hrPage";
	}
}
