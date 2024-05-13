package com.mm.linkflow.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;

@RequestMapping("/booking")
@Controller
@RequiredArgsConstructor
public class BookingController {

	@GetMapping("/bk.room")
	public String bookingPage() {
		return "booking/bookingRoom.jsp";
	}
	
}
