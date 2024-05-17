package com.mm.linkflow.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mm.linkflow.dto.MemberDto;
import com.mm.linkflow.service.service.GroupService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/group")
@RequiredArgsConstructor
public class GroupController {
	
	private final GroupService gService;
	@RequestMapping("/group.page")
	public String groupPage(Model model) {
		List<MemberDto> group =  gService.groupList();
		
		/* List<String> totalMember = */
		
		
		model.addAttribute("g",group);
		/* model.addAttribute("total",total); */
		
		return "group/group";
	}
	
	@ResponseBody
	@PostMapping("/groupPageInfo")
	public MemberDto groupPageInfo(String userId) {
		return gService.groupinfoMember(userId);
	}
}
