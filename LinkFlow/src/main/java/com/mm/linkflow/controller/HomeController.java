package com.mm.linkflow.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {
	
	/**
	 * 테스트로 게시판리스트조회로함 나중에 로그인페이지로 하셈
	 * @return
	 */
	@RequestMapping(value={"/", "/main.page"})
	public String mainPage() {
		return "/board/list";
	}
}
