package com.mm.linkflow.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mm.linkflow.dto.MemberDto;
import com.mm.linkflow.dto.ProjectDto;
import com.mm.linkflow.service.service.ProjectService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/project")
public class ProjectController {
	private final ProjectService proService;

	// 프로젝트 목록 조회
	@GetMapping("/list.pj")
	public String listProject(HttpSession session) {
		
		session.setAttribute("list", proService.listProject());
		return "project/list";
	}
	
	// 프로젝트 등록 폼
	@GetMapping("/addForm.pj")
	public String addProjectForm() {
		return "project/addProjectForm";
	}
	
	// 프로젝트 등록
	@PostMapping("/add.pj")
	public String addProject(HttpSession session, ProjectDto pro) {
		
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		pro.setRegId(loginUser.getUserId());
		pro.setModId(loginUser.getUserId());
		proService.addProject(pro);
		
		return "redirect:/project/list.pj";
	}
	
}
