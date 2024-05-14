package com.mm.linkflow.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;

@RequestMapping("/edsm/prog")
@Controller
@RequiredArgsConstructor
public class EdsmProgController {
	
	@GetMapping("/apprEnrollForm.prog")
	public String apprEnrollForm() {
		return "/edsm/prog/apprEnrollForm";
	}
	
	@GetMapping("/listAll.prog")
	public String listAll() {
		return "/edsm/prog/listAll";
	}
	
	@GetMapping("/listWait.prog")
	public String listWait() {
		return "/edsm/prog/listWait";
	}
	
	@GetMapping("/listPlan.prog")
	public String listPlan() {
		return "/edsm/prog/listPlan";
	}
	
	@GetMapping("/listProg.prog")
	public String listProg() {
		return "/edsm/prog/listProg";
	}
	
	@GetMapping("/listCheck.prog")
	public String listCheck() {
		return "/edsm/prog/listCheck";
	}
}
