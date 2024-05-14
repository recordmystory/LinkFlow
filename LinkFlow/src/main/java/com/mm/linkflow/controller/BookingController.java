package com.mm.linkflow.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;

@RequestMapping("/booking")
@Controller
@RequiredArgsConstructor
public class BookingController {

	@GetMapping("/room.bk")
	public String bkRoomPage() {
		return "booking/bookingRoom";
	}
	
	@GetMapping("/supplies.bk")
	public String bkSuppliesPage() {
		return "booking/bookingSupplies";
	}
	
	@GetMapping("/mylist.bk")
	public String myBookingPage() {
		return "booking/myBookingList";
	}
	
}
