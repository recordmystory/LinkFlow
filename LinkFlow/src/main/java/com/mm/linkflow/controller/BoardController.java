package com.mm.linkflow.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mm.linkflow.dto.BoardCategoryDto;
import com.mm.linkflow.dto.MemberDto;
import com.mm.linkflow.service.service.BoardService;
import com.mm.linkflow.util.PagingUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/board")
@RequiredArgsConstructor
@Controller
public class BoardController {
	
	private final BoardService boardService;
	private final PagingUtil paingUtil;
	
	@GetMapping("/list.do")
	public String list() {
		
		return "board/list";
	}
	
	@PostMapping("/selectBoardType.do")
	public List<BoardCategoryDto> selectBoardType(HttpSession session) {
		
		log.debug("실행하냐");
		
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		
		List<BoardCategoryDto> list = boardService.selectBoardType(loginUser);
		
		log.debug("list : {}", list);
		
		return null;
	}
}
