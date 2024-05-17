package com.mm.linkflow.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mm.linkflow.service.service.AttemdamceService;

import lombok.RequiredArgsConstructor;

@RequestMapping("/Attemdamce")
@RequiredArgsConstructor
@Controller
public class AttemdamceController {
	
	private final AttemdamceService attService;
	
	@ResponseBody
	@PostMapping("/checkOut.do")
	public String checkOutAtt(String userId) {
		return attService.checkOutAtt(userId) > 0 ? "success" : "fail";
	}
	
	@ResponseBody
	@PostMapping("/selectCheckOut.do")
	public String selectCheckOut(String userId) {
		return attService.selectCheckOut(userId) > 0 ? "success" : "fail";
	}
	
	@ResponseBody
	@PostMapping("selectCheckOutTime.do")
	public String selectCheckOutTime(String userId) {
		return attService.selectCheckOutTime(userId);
	}
}
