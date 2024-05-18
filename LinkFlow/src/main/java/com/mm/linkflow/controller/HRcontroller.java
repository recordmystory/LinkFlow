package com.mm.linkflow.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
}
