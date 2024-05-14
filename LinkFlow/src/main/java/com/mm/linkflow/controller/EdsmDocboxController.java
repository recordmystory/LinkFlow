package com.mm.linkflow.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;

@RequestMapping("/edsm/docbox")
@Controller
@RequiredArgsConstructor
public class EdsmDocboxController {
	
	@GetMapping("/listAll.docbox")
	public String listAll() {
		return "/edsm/docbox/listAll";
	}
	
	@GetMapping("/listAppr.docbox")
	public String listAppr() {
		return "/edsm/docbox/listAppr";
	}
	
	@GetMapping("/listDraft.docbox")
	public String listDraft() {
		return "/edsm/docbox/listDraft";
	}
	
	@GetMapping("/listRef.docbox")
	public String listRef() {
		return "/edsm/docbox/listRef";
	}
	
	@GetMapping("/listReject.docbox")
	public String listReject() {
		return "/edsm/docbox/listReject";
	}
}
