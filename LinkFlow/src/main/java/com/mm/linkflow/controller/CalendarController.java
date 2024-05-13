package com.mm.linkflow.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/calendar")
@RequiredArgsConstructor
public class CalendarController {
	
	@GetMapping("/calMain.page")
	public String calendarMain() {
		return "calendar/calendarMain";
	}
	
	@GetMapping("/wasteList.page")
	public String schWasteList() {
		return "calendar/schWasteList";
	}
}
