package com.mm.linkflow.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mm.linkflow.dto.MemberDto;
import com.mm.linkflow.dto.PageInfoDto;
import com.mm.linkflow.dto.ProjectDto;
import com.mm.linkflow.service.service.ProjectService;
import com.mm.linkflow.util.PagingUtil;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/project")
public class ProjectController {
	private final ProjectService proService;
	private final PagingUtil pagingUtil;
	
	// 프로젝트 목록 조회
	@GetMapping("/list.pj")
	public String listProject(HttpSession session, @RequestParam(value="page", defaultValue="1")int currentPage) {
		
		int listCount = proService.selectProjectCount();
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 5, 10);
		session.setAttribute("list", proService.listProject(pi));
		session.setAttribute("pi", pi);
		return "project/list";
	}
	
	// 프로젝트 목록 검색
	@ResponseBody
	@PostMapping("/search.pj")
	public Map<String, Object> searchListProject(String startDate, String endDate, String category, String keyword
			                    , @RequestParam(value="page", defaultValue="1")int currentPage
			                    , HttpSession session) {
		Map<String, String> search = new HashMap<>();
		
		search.put("startDate", startDate);
		search.put("endDate", endDate);
		search.put("category", category);
		search.put("keyword", keyword);
		
		int listCount = proService.selectProjectCount();
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 5, 10);
		List<ProjectDto> list = new ArrayList<>();
		list = proService.searchListProject(search, pi);
		
		Map<String, Object> response = new HashMap<>();
	    response.put("pi", pi);
	    response.put("list", list);
	    
	    return response;
		
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
