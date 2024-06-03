package com.mm.linkflow.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mm.linkflow.dto.AlarmDto;
import com.mm.linkflow.dto.MemberDto;
import com.mm.linkflow.service.impl.AlarmServiceImpl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/alarm")
@Controller
@RequiredArgsConstructor
public class AlarmController {

	private final AlarmServiceImpl alarmService;
	
	@ResponseBody
	@GetMapping(value="/ala.list" , produces="application/json; charset=utf-8")
	public List<AlarmDto> selectAlarmList(HttpSession session){
		String userId = ((MemberDto)session.getAttribute("loginUser")).getUserId();
		
		return alarmService.selectAlarmList(userId);
	}
	
	@ResponseBody
	@GetMapping(value="/ala.read" , produces="application/json; charset=utf-8")
	public int readAlarm(int alarmNo){
		
		
		return alarmService.readAlarm(alarmNo);
	}
	
	@ResponseBody
	@GetMapping(value="/ala.del" , produces="application/json; charset=utf-8")
	public int delAlarm(int alarmNo){
		
		
		return alarmService.delAlarm(alarmNo);
	}
	
}
