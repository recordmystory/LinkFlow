package com.mm.linkflow.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mm.linkflow.dto.AttachDto;
import com.mm.linkflow.dto.BoardCategoryDto;
import com.mm.linkflow.dto.BoardDto;
import com.mm.linkflow.dto.MemberDto;
import com.mm.linkflow.dto.PageInfoDto;
import com.mm.linkflow.service.service.BoardService;
import com.mm.linkflow.util.FileUtil;
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
	private final FileUtil fileUtil;
	
	@GetMapping("/list.do")
	public ModelAndView list(HttpSession session,
							@RequestParam(value="type", defaultValue="CATEGORY-8")String boardType,
							@RequestParam(value="page", defaultValue="1")int currentPage,
							ModelAndView mv) {
		
		List<BoardCategoryDto> categoryList = selectBoardCategory(session);

		int listCount = boardService.selectBoardListCount(boardType);
		PageInfoDto pi = paingUtil.getPageInfoDto(listCount, currentPage, 5, 10);
		List<BoardDto> boardList = boardService.selectBoardList(pi, boardType);
		
		String boardName = "사내공지";
		String normalYN = "COMPANY";
		String currentType ="CATEGORY-8";
		for(int i=0; i<categoryList.size(); i++) {
			if(categoryList.get(i).getBoardCategory().equals(boardType)) {
				boardName = categoryList.get(i).getCategoryName() + " 게시판";
				normalYN = categoryList.get(i).getCategoryType();
				currentType= categoryList.get(i).getBoardCategory();
			}
		}
		
		Map<String, String> map = new HashMap<>();
		map.put("boardName", boardName);
		map.put("normalYN", normalYN);
		map.put("currentType", currentType);
		
		mv.addObject("pi", pi)
		  .addObject("boardList", boardList)
		  .addObject("categoryList", categoryList)
		  .addObject("map", map)
		  .setViewName("board/list");
		return mv;
	}
	
	@GetMapping("/registForm.page") 
	public ModelAndView registForm(HttpSession session, ModelAndView mv) {
		List<BoardCategoryDto> categoryList = selectBoardCategory(session);
		mv.addObject("categoryList", categoryList)
		  .setViewName("board/registForm");
		return mv;
	}
	
	private List<BoardCategoryDto> selectBoardCategory(HttpSession session){
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		return boardService.selectBoardType(loginUser);
	}
	
	@PostMapping("/regist.do")
	public String regist(BoardDto board
					   , List<MultipartFile> uploadFiles
					   , HttpSession session
					   , RedirectAttributes redirectAttributes) {
		
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		board.setRegId(String.valueOf(loginUser.getUserId()));
		board.setModId(String.valueOf(loginUser.getUserId()));
		board.setTempSave("02");
		
		if(board.getNoticeYN() == null) {
			if(board.getBoardCategory().equals("CATEGORY-8")) {
				board.setNoticeYN("Y");
			}
			else {
				board.setNoticeYN("N");
			}
		}
		

		List<AttachDto> attachList = new ArrayList<>();
		if(uploadFiles != null) {
			attachList = fileUtil.setAttach(uploadFiles, "board", loginUser, 0, "B");
			board.setAttachList(attachList);
		}

		int result = boardService.insertBoard(board);
		
		if(attachList.isEmpty() && result == 1 || !attachList.isEmpty() && result == attachList.size()) {
			redirectAttributes.addFlashAttribute("alertMsg", "게시글 작성에 성공하였습니다.");
		}else {
			redirectAttributes.addFlashAttribute("alertMsg", " 게시글 작성에 실패하였습니다.");
			redirectAttributes.addFlashAttribute("histortyBackYN", "Y");
		}
		
		return "redirect:/board/list.do?type=" + board.getBoardCategory();
	}
	
	@GetMapping("/increase.do")
	public String increase(int no) {
		boardService.updateIncreaseCount(no);	
		return "redirect:/board/detail.do?no=" + no;
	}
	
	@GetMapping("/detail.do") // /board/detail.do?no=글번호
	public String detail(int no, String type ,Model model) { // 게시글 상세 조회용 (내가 작성한 게시글 클릭시 곧바로 호출 | 수정완료 후 곧바로 호출)
		model.addAttribute("board", boardService.selectBoard(no));
		return "board/detail";
	}
}
