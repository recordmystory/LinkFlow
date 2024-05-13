package com.mm.linkflow.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;

@RequestMapping("/edsm/crtemp")
@Controller
@RequiredArgsConstructor
public class EdsmCrtempController {
	
	@GetMapping("/list.crtp")
	public String list() {
		return "/edsm/crtemp/list";
	}
	
	@GetMapping("/enrollForm.crtp")
	public String EnrollForm() {
		return "/edsm/crtemp/enrollForm";
	}
}
