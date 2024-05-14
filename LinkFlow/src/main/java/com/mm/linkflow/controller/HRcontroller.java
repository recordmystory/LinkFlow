package com.mm.linkflow.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;



import lombok.RequiredArgsConstructor;

@RequestMapping("/hr")
@RequiredArgsConstructor
@Controller
public class HRcontroller {
	
	@RequestMapping("/hrPage")
	public String hrPage() {
		return "hr/hrPage";
	}
}
