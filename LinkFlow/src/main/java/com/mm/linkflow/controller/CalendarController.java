package com.mm.linkflow.controller;

import java.util.List;

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

	
	//calendarMain  
	@GetMapping("/calMain.page")
	public String calendarMain() {
		return "calendar/calendarMain";
	}
	
	//schWasteList
	@GetMapping("/wasteList.page")
	public String schWasteList() {
		return "calendar/schWasteList";
	}
	
	//캘린더 메인 - 일정 등록
	@ResponseBody
	@PostMapping(value="/regist.do", produces="text/html; charset=utf-8")//
	public String insertSch(ScheduleDto schedule, HttpSession session) {  
		String userId = ((MemberDto)session.getAttribute("loginUser")).getUserId();
		schedule.setModId(userId);
		log.debug(userId);
		log.debug("schImport:{}",schedule.getSchImport());
		log.debug("notifyYn:{}",schedule.getNotifyYn());

		
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
	        return "success"; 
	    } else {
	        return "fail"; 
	    }
	}
  
	//캘린더 메인 - 일정 전체조회
	/*
	    @ResponseBody
	    @RequestMapping("/schList.do")
	    public Map<String, List<ScheduleDto>> selectScheduleList(@RequestParam("schCalSubCodes") List<String> schCalSubCodes) {
		   Map<String, List<ScheduleDto>> result = new HashMap<>();

	        for (String schCalSubCode : schCalSubCodes) {
	            List<ScheduleDto> events = calendarService.selectSchList(schCalSubCode);
	            result.put(schCalSubCode, events);
	            for (ScheduleDto event : events) {
	            	//색조회
	            	log.debug("Event Title: {}, Color: {}", event.getSchTitle(), event.getCalColor());
	            }
	        }

	        return result;
	    }
	    */
	//캘린더 메인 - 일정 전체 조회
	@ResponseBody
    @RequestMapping("/schList.do")
    public List<ScheduleDto> selectScheduleList(String schCalSubCodes) {
        return calendarService.selectSchList(schCalSubCodes);
    }
	   
	//휴지통 - 일정 상세
	   @GetMapping("/schSelect.do")
	   public String detailSch(String schNo, Model model) {
	       ScheduleDto schedule = calendarService.detailSch(schNo);
	       model.addAttribute("schedule", schedule);
	       return "calendar/schWasteList";
	   }
	   
	//캘린더 메인 - 일정 수정
	   @ResponseBody
	   @PostMapping(value="/updateSch.do", produces="application/json")
	   public String updateSch(@RequestBody ScheduleDto schedule) {
	       int resultSch = calendarService.updateSch(schedule);
	       
			/*
			 * Map<String, Object> map = new HashMap<>(); map.put("calNo",
			 * schedule.getCalNo()); map.put("schCalSubCode", schedule.getSchCalSubCode());
			 * 
			 * int resultCalNo = calendarService.updateSchCalSubCode(map);
			 */
	       log.debug("updateResult: {}", resultSch);
	       log.debug("address: {}", schedule.getAddress());
	       log.debug("schNo: {}", schedule.getAddress());

	       if (resultSch == 1) {
	           return "success"; 
	       } else {
	           return "fail"; 
	       }
	   }

	   
	   //캘린더 메인 - 삭제(상태변경)
	   @ResponseBody
	   @GetMapping(value="/deleteSch.do")
	   public String deleteSch(@RequestParam String schNo) {
			return calendarService.deleteSch(schNo) == 1 ? "success" : "fail";	
	   }
}
	  

