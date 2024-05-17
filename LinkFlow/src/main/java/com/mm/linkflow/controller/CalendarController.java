package com.mm.linkflow.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mm.linkflow.dto.MemberDto;
import com.mm.linkflow.dto.ScheduleDto;
import com.mm.linkflow.service.service.CalendarService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/calendar")
@RequiredArgsConstructor
public class CalendarController {
	
	private final CalendarService calendarService;

	
	//calendarMain 띄우기   
	@GetMapping("/calMain.page")
	public String calendarMain() {
		return "calendar/calendarMain";
	}
	
	//schWasteList 띄우기
	@GetMapping("/wasteList.page")
	public String schWasteList() {
		return "calendar/schWasteList";
	}
	
	//calMain - 일정 등록 
	@ResponseBody
	@PostMapping(value="/regist.do", produces="text/html; charset=utf-8")//
	public String insertSch(ScheduleDto schedule, HttpSession session) {  
		String userId = ((MemberDto)session.getAttribute("loginUser")).getUserId();
		schedule.setModId(userId);
		log.debug(userId);
		/*
		 * String schCalSubCode = schedule.getCalSubCode();
		 * 
		 * Map<String, String> selectCalNo = new HashMap<>();
		 * selectCalNo.put("schCalSubCode", schCalSubCode); selectCalNo.put("userId",
		 * userId);
		 * 
		 * calendarService.getSelectCalNo(selectCalNo);
		 */
		
	    int result = calendarService.insertSch(schedule);
	    if (result == 1) {  
	        return "success"; // 성공  
	    } else {
	        return "fail"; // 등록 실패
	    }
	}
  
	//일정 전체 조회(특정 캘린더)
	@ResponseBody
	@GetMapping(value="/schList.do", produces="application/json")
	public List<ScheduleDto> selectSchList(@RequestParam("schCalSubCode") String[] schCalSubCode) { 

		List<ScheduleDto> result = calendarService.selectSchList(schCalSubCode);
		return result;
	}
	  
}
