package com.mm.linkflow.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
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
import org.springframework.web.servlet.ModelAndView;

import com.mm.linkflow.dto.DispatchDto;
import com.mm.linkflow.dto.MemberDto;
import com.mm.linkflow.dto.PageInfoDto;
import com.mm.linkflow.dto.ProjectDto;
import com.mm.linkflow.service.service.MemberService;
import com.mm.linkflow.service.service.ProjectService;
import com.mm.linkflow.util.PagingUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Controller
@RequestMapping("/project")
public class ProjectController {
	private final ProjectService proService;
	private final PagingUtil pagingUtil;
	private final MemberService memService;
	
	// 프로젝트 목록 조회
	@GetMapping("/list.pj")
	public ModelAndView listProject(ModelAndView mv, @RequestParam(value="page", defaultValue="1")int currentPage
			                      , String id, String posi) {
//		if(posi.equals("팀장")) {
			int listCount = proService.selectProjectCount();
			PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 5, 10);
			mv.addObject("list", proService.listProject(pi))
			.addObject("pi", pi)
			.setViewName("project/listProject");
			
//		}else {
//			int listCount = 
//		}
		
		return mv;
	}
	
	// 프로젝트 목록 검색
	
	@PostMapping("/search.pj")
	public ModelAndView searchListProject(String startDate, String endDate, String category, String keyword
			                    , @RequestParam(value="page", defaultValue="1")int currentPage
			                    , ModelAndView mv) {
		Map<String, String> search = new HashMap<>();
		
		System.out.println(startDate);
		System.out.println(endDate);
		
		search.put("startDate", startDate);
		search.put("endDate", endDate);
		search.put("category", category);
		search.put("keyword", keyword);
		
		int listCount = proService.searchProjectCount(search);
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 5, 10);
		List<ProjectDto> list = new ArrayList<>();
		list = proService.searchListProject(search, pi);
		log.debug("pi : {}", pi);
		
		mv.addObject("pi", pi)
		  .addObject("list", list)
		  .addObject("search", search)
		  .setViewName("project/listProject");
	    
	    return mv;
		
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
	
	// 프로젝트 상세 조회
	@GetMapping("detail.pj")
	public ModelAndView detailProject(int no, String title, ModelAndView mv) {
		
		mv.addObject("pro", proService.selectDetailProject(no))
		  .addObject("dis", proService.selectProjectDispatch(no))
		  .addObject("teamMem", memService.selectTeamMember(title))
		  .setViewName("project/detailProject");
		
		return mv;
	}
	
	// 프로젝트 투입인원 등록
	@PostMapping("addmember.dis")
	public String addDispatch(DispatchDto dis, HttpSession session) throws UnsupportedEncodingException {
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		dis.setRegId(loginUser.getUserId());
		dis.setModId(loginUser.getUserId());
		proService.addDispatch(dis);
		int no = dis.getProNo();
		String title = URLEncoder.encode(loginUser.getDeptName(), StandardCharsets.UTF_8.toString());
		
		return "redirect:/project/detail.pj?no=" + no + "&title=" + title;
	}
	
	// 프로젝트 투입인원 체크
	@ResponseBody
	@PostMapping("checkMember.dis")
	public String checkDispatch(DispatchDto dis) {
		return proService.checkDispatch(dis) > 0 ? "YES" : "NO";
	}
}
