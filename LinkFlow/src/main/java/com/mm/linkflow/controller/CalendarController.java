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
import org.springframework.web.servlet.ModelAndView;

import com.mm.linkflow.dto.DeptDto;
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

    // calendarMain
    @GetMapping("/calMain.page")
    public ModelAndView calendarMain(ModelAndView mv) {
        // 공유 일정 조직도 조회
        List<DeptDto> apprList = calendarService.selecteMemberList();
        mv.addObject("apprList", apprList).setViewName("calendar/calendarMain");
        return mv;
    }

    // schWasteList
    @GetMapping("/wasteList.page")
    public String schWasteList() {
        return "calendar/schWasteList";
    }

    // 캘린더 메인 - 일정 등록, 공유일정 등록
    @ResponseBody
    @PostMapping(value = "/regist.do", produces = "text/html; charset=utf-8")
    public String insertSch(ScheduleDto schedule, @RequestParam("shareIds") List<String> shareIds, HttpSession session) {
        String userId = ((MemberDto) session.getAttribute("loginUser")).getUserId();
        schedule.setModId(userId);
        int result = calendarService.insertSch(schedule, userId, shareIds);
        String resultStr = "";
        if ((shareIds != null && shareIds.size() == result) || (shareIds == null && result > 0)) {
            resultStr = "success";
        } else {
            resultStr = "fail";
        }
        return resultStr;
    }

    // 캘린더 메인 - 일정 전체 조회, 공유일정 조회
    @ResponseBody
    @RequestMapping("/schList.do")
    public List<ScheduleDto> selectScheduleList(String schCalSubCode, HttpSession session) {
        String userId = ((MemberDto) session.getAttribute("loginUser")).getUserId();
        Map<String, Object> sch = new HashMap<>();
        sch.put("userId", userId);
        sch.put("schCalSubCode", schCalSubCode);
        
        return calendarService.selectSchList(sch);

    }    

    // 캘린더 메인 - 일정 수정, 공유일정 수정
    @ResponseBody
    @PostMapping("/updateSch.do")
    public String updateSchedule(@RequestBody ScheduleDto data, HttpSession session) {
        List<String> shareIds = data.getShareIds();
        String userId = ((MemberDto) session.getAttribute("loginUser")).getUserId();
        data.setModId(userId);
        
        int result = calendarService.updateSchedule(data, userId, shareIds);
        if ((shareIds != null && shareIds.size() == result) || (shareIds == null && result > 0)) {
            return "success";
        } else {
            return "fail";
        }
    }

    // 캘린더 메인 - 삭제(상태변경), 공유일정 삭제
    @ResponseBody
    @GetMapping(value = "/deleteSch.do")
    public String deleteSch(@RequestParam String schNo) {
        int result = calendarService.deleteSch(schNo);
        if (result > 0) {
            return "success";
        } else {
            return "fail";
        }
    }

    // 휴지통****************************

    // 휴지통 - 일정 전체 조회
    @ResponseBody
    @RequestMapping("/schWasteList.do")
    public List<ScheduleDto> selectSchWasteList(String schCalSubCode, HttpSession session) {
        String userId = ((MemberDto) session.getAttribute("loginUser")).getUserId();
        return calendarService.selectSchWasteList(schCalSubCode, userId);
    }

    // 휴지통 - 일정 상세
    @ResponseBody
    @GetMapping("/schSelect.do")
    public ScheduleDto detailSch(String schNo, Model model) {
        ScheduleDto schedule = calendarService.detailSch(schNo);
        model.addAttribute("schedule", schedule);
        return schedule;
    }

    // 휴지통 - 일정복구(상태변경), 공유일정 복구
    @ResponseBody
    @GetMapping(value = "/wasteSchRestore.do")
    public String wasteSchRestore(@RequestParam String schNo) {
        int result = calendarService.wasteSchRestore(schNo);
        if (result > 0) {
            return "success";
        } else {
            return "fail";
        }
    }

    // 휴지통 - 일정삭제, 공유일정 삭제
    @ResponseBody
    @GetMapping(value = "/wasteSchRemoval.do")
    public String wasteSchRemoval(@RequestParam String schNo) {
        int result = calendarService.wasteSchRemoval(schNo);
        if (result > 0) {
            return "success";
        } else {
            return "fail";
        }
    }
}