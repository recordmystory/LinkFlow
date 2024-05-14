package com.mm.linkflow.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;

@RequestMapping("/edsm/tmpsave")
@Controller
@RequiredArgsConstructor
public class EdsmTmpsaveController {
	
	@GetMapping("/list.tpsv")
	public String listAll() {
		return "/edsm/tmpsave/list";
	}
}
