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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mm.linkflow.dto.DailyDto;
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
	public ModelAndView listProject(ModelAndView mv, HttpSession session,  @RequestParam(value="page", defaultValue="1")int currentPage) {
			
//			MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
//			String userId = loginUser.getUserId();
//			session.setAttribute("result", proService.projectPmCount(userId));

			int listCount = proService.selectProjectCount();
			PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 5, 10);
			List<ProjectDto> list = new ArrayList<>();
			list = proService.listProject(pi);
			mv.addObject("list", list)
			  .addObject("pi", pi)
		 	  .setViewName("project/listProject");
			
		return mv;
	}
	
	// 프로젝트 목록 검색
	
	@PostMapping("/search.pj")
	public ModelAndView searchListProject(String startDate, String endDate, String category, String keyword
			                    , @RequestParam(value="page", defaultValue="1")int currentPage
			                    , ModelAndView mv) {
		Map<String, String> search = new HashMap<>();
		
		search.put("startDate", startDate);
		search.put("endDate", endDate);
		search.put("category", category);
		search.put("keyword", keyword);
		
		int listCount = proService.searchProjectCount(search);
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 5, 10);
		List<ProjectDto> list = new ArrayList<>();
		list = proService.searchListProject(search, pi);
		
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
	
	// 파견인원 등록
	@PostMapping("addMember.dis")
	public String addDispatch(DispatchDto dis, HttpSession session) throws UnsupportedEncodingException {
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		dis.setRegId(loginUser.getUserId());
		dis.setModId(loginUser.getUserId());
		proService.addDispatch(dis);
		int no = dis.getProNo();
		String title = URLEncoder.encode(loginUser.getDeptName(), StandardCharsets.UTF_8.toString());
		
		return "redirect:/project/detail.pj?no=" + no + "&title=" + title;
	}
	
	// 파견인원 등록 체크
	@ResponseBody
	@PostMapping("checkMember.dis")
	public String checkDispatch(DispatchDto dis) {
		return proService.checkDispatch(dis) > 0 ? "YES" : "NO";
	}
	
	// 파견인원 수정
	@PostMapping("modify.dis")
	public String modifyDispatch(DispatchDto dis, HttpSession session) throws UnsupportedEncodingException {
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		dis.setModId(loginUser.getUserId());
		proService.modifyDispatch(dis);
		int no = dis.getProNo();
		String title = URLEncoder.encode(loginUser.getDeptName(), StandardCharsets.UTF_8.toString());
		return "redirect:/project/detail.pj?no=" + no + "&title=" + title;
	}
	
	// 파견인원 삭제
	@ResponseBody
	@PostMapping("delete.dis")
	public String deleteDispatch(DispatchDto dis, HttpSession session){
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		dis.setModId(loginUser.getUserId());
		return proService.deleteDispatch(dis) > 0 ? "SUCCESS" : "FAIL";
	}
	
	// 프로젝트 수정 양식
	@GetMapping("modifyForm.pj")
	public ModelAndView modifyProjectForm(int no, ModelAndView mv) {
		int proNo = no;
		mv.addObject("pro", proService.selectDetailProject(proNo))
		  .setViewName("project/modifyProjectForm");
		
		return mv;
	}
	
	// 프로젝트 수정
	@PostMapping("modify.pj")
	public String modifyProject(ProjectDto pro, HttpSession session) throws UnsupportedEncodingException {
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		pro.setModId(loginUser.getUserId());
		proService.modifyProject(pro);
		int no = pro.getProNo();
		String title = URLEncoder.encode(loginUser.getDeptName(), StandardCharsets.UTF_8.toString());
		
		return "redirect:/project/detail.pj?no=" + no + "&title=" + title;
	}
	
	// 프로젝트 삭제
	@GetMapping("delete.pj")
	public String deleteProject(int no) {
		proService.deleteProject(no);
		proService.deleteProjectDispatch(no);
		
		return "redirect:/project/list.pj";
	}
	
	// 프로젝트 인원 조회
	@GetMapping("list.dis")
	public ModelAndView listDispatch(ModelAndView mv, @RequestParam(value="page", defaultValue="1")int currentPage) {
		
		int listCount = proService.listDispatchCount();
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 5, 10);
		List<DispatchDto> list = new ArrayList<>();
		
		list = proService.listDispatch(pi);
		
		mv.addObject("list", list)
		  .addObject("pi", pi)
		  .setViewName("project/listDispatch");
		
		return mv;
		
	}
	
	// 파견인원 검색 조회
	@PostMapping("search.dis")
	public ModelAndView searchDispatchList(String startDate, String endDate, String category, String keyword
			                    		 , @RequestParam(value="page", defaultValue="1")int currentPage
			                    		 , ModelAndView mv) {
		Map<String, String> search = new HashMap<>();
		
		search.put("startDate", startDate);
		search.put("endDate", endDate);
		search.put("category", category);
		search.put("keyword", keyword);
		
		int listCount = proService.searchDispatchCount(search);
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 5, 10);
		List<DispatchDto> list = new ArrayList<>();
		list = proService.searchDispatchList(search, pi);
		
		mv.addObject("pi", pi)
		  .addObject("list", list)
		  .addObject("search", search)
		  .setViewName("project/listDispatch");
	    
	    return mv;
	}
	
	// 본인 프로젝트 조회
	@ResponseBody
	@GetMapping("myList.dis")
	public Map<String, Object> myDispatchList(String userId, @RequestParam(value="page", defaultValue="1")int currentPage){
		
		Map<String, Object> map = new HashMap<>();
		int listCount = proService.myDispatchCount(userId);
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 5, 10);
		List<DispatchDto> list = new ArrayList<>();
		list = proService.myDispatchList(userId, pi);
		map.put("list", list);
		map.put("pi", pi);
		
		return map;
		
	}
	
	// 본인 일일작업 조회
	@GetMapping("list.dai")
	public ModelAndView dailyList(ModelAndView mv, HttpSession session, @RequestParam(value="page", defaultValue="1")int currentPage) {
		
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		String userId = loginUser.getUserId();
		int listCount = proService.dailyCount(userId);
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 5, 10);
		List<DailyDto> list = new ArrayList<>();
		list = proService.dailyList(userId, pi);
		mv.addObject("list", list)
		  .addObject("pi", pi)
		  .setViewName("project/listDaily");
		
		
		return mv;
	}
	
	// 일일작업 등록폼
	@GetMapping("addForm.dai")
	public ModelAndView dailyAddForm(ModelAndView mv, HttpSession session) {
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		String userId = loginUser.getUserId();
		List<DispatchDto> list = new ArrayList<>();
		list = proService.dailyProjectList(userId);
		mv.addObject("list", list)
		  .setViewName("project/addDailyForm");
		return mv;
	}
	
	// 일일작업 등록
	@PostMapping("add.dai")
	public String addDaily(DailyDto dai, HttpSession session, RedirectAttributes ra) {
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		dai.setRegId(loginUser.getUserId());
		dai.setModId(loginUser.getUserId());
		int result = proService.dailyCheck(dai);
		if(result > 0) {
			ra.addFlashAttribute("alertMsg", "이미 당일 등록한 일일작업이 존재하는 프로젝트입니다.");
			return "redirect:/project/addForm.dai";
		}else {
			proService.addDaily(dai);
			return "redirect:/project/list.dai";
		}
	}
	
	// 일일작업 조회
	@GetMapping("detail.dai")
	public ModelAndView detailDaily(int no, ModelAndView mv) {
		
		mv.addObject("daily", proService.detailDaily(no))
		  .setViewName("project/detailDaily");
		
		return mv;
	}
	
	// 일일작업 수정 폼
	@GetMapping("modifyForm.dai")
	public ModelAndView modifyFormDaily(int no, ModelAndView mv) {
		
		mv.addObject("dai", proService.detailDaily(no))
		  .setViewName("project/modifyDailyForm");
		
		return mv;
	}
	
	// 일일작업 수정
	@PostMapping("modify.dai")
	public String modifyDaily(DailyDto dai) {
		proService.modifyDaily(dai);
		
		return "redirect:/project/detail.dai?no=" + dai.getDaiNo();
	}
	
	// 일일작업 삭제
	@GetMapping("delete.dai")
	public String deleteDaily(int no) {
		proService.deleteDaily(no);
		
		return "redirect:/project/list.dai";
	}
	
	// 일일작업 검색 조회
	@PostMapping("search.dai")
	public ModelAndView searchDaily(ModelAndView mv, String keyword, String startDate, String endDate, String userId
			                      , @RequestParam(value="page", defaultValue="1")int currentPage) {
		Map<String, String> search = new HashMap<>();
		
		search.put("keyword", keyword);
		search.put("startDate", startDate);
		search.put("endDate", endDate);
		search.put("userId", userId);
		
		int listCount = proService.searchDailyCount(search);
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 5, 10);
		List<DailyDto> list = new ArrayList<>();
		list = proService.searchDaily(search, pi);
		
		System.out.println(list);
		
		mv.addObject("list", list)
		  .addObject("pi", pi)
		  .addObject("search", search)
		  .setViewName("project/listDaily");
		
		return mv;
	}
	
	// 직원별 일일작업 조회
	@GetMapping("listLead.dai")
	public ModelAndView listDailyLead(ModelAndView mv, @RequestParam(value="page", defaultValue="1")int currentPage, String deptCode
			                        , HttpSession session) {
		
		Map<String, String> map = new HashMap<>();
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		String userId = loginUser.getUserId();
		int listCount = proService.listDailyLeadCount(map);
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 5, 10);
		map.put("deptCode", deptCode);
		map.put("userId", userId);
		List<DailyDto> list = new ArrayList<>();
		list = proService.listDailyLead(pi, map);
		
		mv.addObject("list", list)
		  .addObject("pi", pi)
		  .setViewName("project/listDailyLead");
		
		return mv;
	}
	
	// 일일작업 피드백 폼
	@GetMapping("ansModifyForm.dai")
	public ModelAndView ansModifyForm(int no, ModelAndView mv) {
		DailyDto dai = proService.detailDaily(no);
		
		mv.addObject("dai", dai)
		  .setViewName("project/modifyDailyAnsForm");
		
		return mv;
	}
	
	// 일일작업 조회(팀장)
	@GetMapping("detailLead.dai")
	public ModelAndView detailDailyLead(int no, ModelAndView mv) {
		
		mv.addObject("daily", proService.detailDaily(no))
		  .setViewName("project/detailDailyLead");
		
		return mv;
	}
	
	// 직원별 일일작업 삭제
	@GetMapping("deleteLead.dai")
	public String deleteDailyLead(int no, HttpSession session) {
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		String deptCode = loginUser.getDeptCode();
		proService.deleteDaily(no);
		
		return "redirect:/project/listLead.dai?deptCode=" + deptCode;
	}
	
	// 직원별 일일작업 검색
	@PostMapping("/searchLead.dai")
	public ModelAndView searchDailyLead(String startDate, String endDate, String category, String keyword
			                    , @RequestParam(value="page", defaultValue="1")int currentPage
			                    , ModelAndView mv, String deptCode
			                    , HttpSession session) {
		Map<String, String> search = new HashMap<>();
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		String userId = loginUser.getUserId();
		
		search.put("startDate", startDate);
		search.put("endDate", endDate);
		search.put("category", category);
		search.put("keyword", keyword);
		search.put("deptCode", deptCode);
		search.put("userId", userId);
		
		int listCount = proService.searchDailyLeadCount(search);
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 5, 10);
		List<DailyDto> list = new ArrayList<>();
		list = proService.searchDailyLead(search, pi);
		
		mv.addObject("pi", pi)
		  .addObject("list", list)
		  .addObject("search", search)
		  .setViewName("project/listDailyLead");
	    
	    return mv;
		
	}
	
	// 직원별 일일작업 피드백
	@PostMapping("modifyLead.dai")
	public String modifyDailyLead(DailyDto dai) {
		proService.modifyDailyLead(dai);
		
		return "redirect:/project/detailLead.dai?no=" + dai.getDaiNo();
	}
	
	
}
