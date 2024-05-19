package com.mm.linkflow.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
	    @RequestMapping("/schList.do")
	    public Map<String, List<ScheduleDto>> selectScheduleList(@RequestParam("schCalSubCodes") List<String> schCalSubCodes) {
		   Map<String, List<ScheduleDto>> result = new HashMap<>();

	        for (String schCalSubCode : schCalSubCodes) {
	            List<ScheduleDto> events = calendarService.selectSchList(schCalSubCode);
	            result.put(schCalSubCode, events);
	            for (ScheduleDto event : events) {
	            	//색상확인중
	                log.debug("Event Title: {}, Color: {}", event.getSchTitle(), event.getCalColor());
	            }
	        }

	        return result;
	    }
	   
	 //일정 상세 조회(특정 캘린더) x
	   @GetMapping("/schSelect.do")
	   public String detailSch(String schNo, Model model) {
	       ScheduleDto schedule = calendarService.detailSch(schNo);
	       model.addAttribute("schedule", schedule);
	       return "calendar/calendarMain";
	   }
	   
	 //일정 수정
	   @ResponseBody
	   @PostMapping(value="/updateSch.do", produces="application/json")
	   public String updateSch(@RequestBody ScheduleDto schedule) {
	       int result = calendarService.updateSch(schedule);
	       if (result == 1) {
	           return "success"; // 성공
	       } else {
	           return "fail"; // 실패
	       }
	   }

	   
}
	
	  

