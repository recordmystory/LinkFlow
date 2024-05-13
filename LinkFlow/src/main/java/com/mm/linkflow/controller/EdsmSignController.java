package com.mm.linkflow.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;

@RequestMapping("/edsm/sign")
@Controller
@RequiredArgsConstructor
public class EdsmSignController {
	
	@GetMapping("/setting.sign")
	public String listAll() {
		return "/edsm/sign/setting";
	}
	
}
