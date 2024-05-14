package com.mm.linkflow.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;



import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/group")
@RequiredArgsConstructor
public class GroupController {
	@RequestMapping("/group.page")
	public String mypage() {
		return "group/group";
	}
}
