package com.mm.linkflow.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mm.linkflow.dto.BoardCategoryDto;
import com.mm.linkflow.dto.BoardDto;
import com.mm.linkflow.dto.MemberDto;
import com.mm.linkflow.dto.PageInfoDto;
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
	public ModelAndView list(
						HttpSession session,
						@RequestParam(value="type", defaultValue="CATEGORY-8")String boardType,
						@RequestParam(value="page", defaultValue="1")int currentPage,
						ModelAndView mv) {
		
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		
		List<BoardCategoryDto> categoryList = boardService.selectBoardType(loginUser);
		
		
		int listCount = boardService.selectBoardListCount(boardType);
		PageInfoDto pi = paingUtil.getPageInfoDto(listCount, currentPage, 5, 10);
		List<BoardDto> boardList = boardService.selectBoardList(pi, boardType);
		
		String boardName = "사내공지";
		String normalYN = "COMPANY";
		for(int i=0; i<categoryList.size(); i++) {
			if(categoryList.get(i).getBoardCategory().equals(boardType)) {
				boardName = categoryList.get(i).getCategoryName() + " 게시판";
				normalYN = categoryList.get(i).getCategoryType();
			}
		}
		
		Map<String, String> map = new HashMap<>();
		map.put("boardName", boardName);
		map.put("normalYN", normalYN);
		
		mv.addObject("pi", pi)
		  .addObject("boardList", boardList)
		  .addObject("categoryList", categoryList)
		  .addObject("map", map)
		  .setViewName("board/list");
		return mv;
	}

}
