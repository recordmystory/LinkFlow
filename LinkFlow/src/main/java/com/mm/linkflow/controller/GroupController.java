package com.mm.linkflow.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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
		model.addAttribute("g",group);
		
		return "group/group";
	}
}
