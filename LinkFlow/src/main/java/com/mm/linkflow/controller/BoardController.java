package com.mm.linkflow.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mm.linkflow.dto.AttachDto;
import com.mm.linkflow.dto.BoardAuthDto;
import com.mm.linkflow.dto.BoardCategoryDto;
import com.mm.linkflow.dto.BoardDto;
import com.mm.linkflow.dto.DeptDto;
import com.mm.linkflow.dto.MemberDto;
import com.mm.linkflow.dto.PageInfoDto;
import com.mm.linkflow.dto.ReplyDto;
import com.mm.linkflow.service.service.AttachService;
import com.mm.linkflow.service.service.BoardService;
import com.mm.linkflow.service.service.HrService;
import com.mm.linkflow.service.service.MemberService;
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
	private final AttachService attachService;
	private final HrService hService;
	private final MemberService memeberService;
	private final PagingUtil pagingUtil;
	private final FileUtil fileUtil;
	
	@GetMapping("/list.do")
	public ModelAndView list(HttpSession session,
							@RequestParam(value="type", defaultValue="CATEGORY-8")String boardType,
							@RequestParam(value="page", defaultValue="1")int currentPage,
							ModelAndView mv) {
		
		List<BoardCategoryDto> categoryList = selectBoardCategory(session);

		int listCount = boardService.selectBoardListCount(boardType);
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 5, 10);
		
		List<BoardDto> noticeList = new ArrayList<>();
		
		if(!boardType.equals("CATEGORY-8")) {			
			noticeList = boardService.selectNoticeBoardList(boardType);
		}
		
		List<BoardDto> boardList = boardService.selectBoardList(pi, boardType);
		
		String boardName = "사내공지";
		String normalYN = "COMPANY";
		for(int i=0; i<categoryList.size(); i++) {
			if(categoryList.get(i).getBoardCategory().equals(boardType)) {
				boardName = categoryList.get(i).getCategoryName() + " 게시판";
				normalYN = categoryList.get(i).getCategoryType();
			}
		}
		
		if(normalYN.equals("NORMAL")) {
			List<BoardAuthDto> normalUserList = boardService.selectNormalUser(boardType);
			mv.addObject("normalUserList", normalUserList);
		}
		
		
		Map<String, String> map = new HashMap<>();
		map.put("boardName", boardName);
		map.put("normalYN", normalYN);
		map.put("currentType", boardType);

		mv.addObject("pi", pi)
		  .addObject("boardList", boardList)
		  .addObject("noticeList", noticeList)
		  .addObject("categoryList", categoryList)
		  .addObject("map", map)
		  .setViewName("board/list");
		return mv;
	}
	
	@GetMapping("/registForm.page") 
	public ModelAndView registForm(HttpSession session, ModelAndView mv) {
		List<BoardCategoryDto> categoryList = selectBoardCategory(session);
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		List<BoardCategoryDto> writeList = boardService.selectWriteCategory(loginUser);
		mv.addObject("categoryList", categoryList)
		  .addObject("writeList", writeList)
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
		log.debug("attachList : {}", attachList);
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
	public String detail(int no, Model model, HttpSession session) { // 게시글 상세 조회용 (내가 작성한 게시글 클릭시 곧바로 호출 | 수정완료 후 곧바로 호출)
		List<BoardCategoryDto> categoryList = selectBoardCategory(session);
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("board", boardService.selectBoard(no));
		return "board/detail";
	}
	
	@GetMapping("/modifyForm.page")
	public String modifyForm(int no, Model model, HttpSession session) {
		List<BoardCategoryDto> categoryList = selectBoardCategory(session);
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		List<BoardCategoryDto> writeList = boardService.selectWriteCategory(loginUser);
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("writeList", writeList);
		model.addAttribute("board", boardService.selectBoard(no));

		return "board/modify";
	}
	
	@PostMapping("/modify.do")
	public String modify(BoardDto board, String[] delFileNo
					   , List<MultipartFile> uploadFiles
					   , HttpSession session
					   , RedirectAttributes redirectAttributes) {
		
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		board.setModId(String.valueOf(loginUser.getUserId()));
		board.setTempSave("02");
		
		List<AttachDto> delFileList = attachService.selectDelFileList(delFileNo);
		
		if(board.getNoticeYN() == null || !board.getNoticeYN().equals("Y")) {
			if(board.getBoardCategory().equals("CATEGORY-8")) {
				board.setNoticeYN("Y");
			}
			else {
				board.setNoticeYN("N");
			}
		}
		
		List<AttachDto> attachList = new ArrayList<>();
		if(uploadFiles != null) {
			attachList = fileUtil.setAttach(uploadFiles, "board", loginUser, board.getBoardNo(), "B");
			board.setAttachList(attachList);
		}

		int result = boardService.updateBoard(board, delFileNo);
		
		if(result > 0) {
			for(AttachDto at : delFileList) {
				new File(at.getFilePath() + "/" + at.getFilesystemName()).delete();
			}
			redirectAttributes.addFlashAttribute("alertMsg", "작성에 성공하였습니다.");
		}else {
			redirectAttributes.addFlashAttribute("alertMsg", " 작성에 실패하였습니다.");
			redirectAttributes.addFlashAttribute("histortyBackYN", "Y");
		}
		
		return "redirect:/board/detail.do?no=" + board.getBoardNo();
	}
	
	@GetMapping("/search.do")
	public ModelAndView search(
					   @RequestParam(value="page", defaultValue="1") int currentPage,
					   @RequestParam(value="type", defaultValue="CATEGORY-8") String boardType,
					   @RequestParam Map<String, String> search,
					   HttpSession session,
					   ModelAndView mv) {
		

		search.put("boardType", boardType);
		int listCount = boardService.selectSearchListCount(search);
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 5, 10);
		
		List<BoardCategoryDto> categoryList = selectBoardCategory(session);
		List<BoardDto> boardList = boardService.selectSearchList(search, pi);
		List<BoardDto> noticeList = new ArrayList<>();
		
		if(!boardType.equals("CATEGORY-8")) {			
			noticeList = boardService.selectNoticeBoardList(boardType);
		}
		
		mv.addObject("pi", pi)
		  .addObject("boardList", boardList)
		  .addObject("noticeList", noticeList)
		  .addObject("categoryList", categoryList)
		  .addObject("search", search)
		  .setViewName("board/list");
		
		return mv;
	}
	
	@ResponseBody
	@PostMapping("/insertTempSave.do")
	public int tempSave(BoardDto board
					   , List<MultipartFile> uploadFiles
					   , HttpSession session
					   , RedirectAttributes redirectAttributes) {
		
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		board.setRegId(String.valueOf(loginUser.getUserId()));
		board.setModId(String.valueOf(loginUser.getUserId()));
		board.setTempSave("01");
		
		if(board.getNoticeYN() == null || !board.getNoticeYN().equals("Y")) {
			if(board.getBoardCategory().equals("CATEGORY-8")) {
				board.setNoticeYN("Y");
			}
			else {
				board.setNoticeYN("N");
			}
		}
		log.debug("noticeYN : {}", board.getNoticeYN());

		 List<AttachDto> attachList = new ArrayList<>(); 
		 if(uploadFiles != null) {
			 attachList = fileUtil.setAttach(uploadFiles, "board", loginUser, 0, "B");
			 board.setAttachList(attachList); 
		 }
		  
		 int result = boardService.insertBoard(board);
		 int boardNo = 0;
		 
		 if(result > 0) {
			 boardNo = boardService.selectCurrnetTempSave();
		 }
		 
		 return boardNo;
	}
	
	@GetMapping("/tempSave.page")
	public String tempSaveForm(Model model, HttpSession session
							, @RequestParam(value="page", defaultValue="1")int currentPage) { // 게시글 상세 조회용 (내가 작성한 게시글 클릭시 곧바로 호출 | 수정완료 후 곧바로 호출)
		
		List<BoardCategoryDto> categoryList = selectBoardCategory(session);
		
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		
		int listCount = boardService.selectTempSaveListCount(loginUser.getUserId());
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 5, 10);
		
		List<BoardDto> tempSaveList = boardService.selectTempSaveList(pi, loginUser.getUserId());
		
		
		model.addAttribute("pi", pi);
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("tempSaveList", tempSaveList);
		return "board/tempSave";
	}
	
	@GetMapping("/tempSaveDetail.page") 
	public String tempSaveDetail(int no, Model model, HttpSession session) {
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		List<BoardCategoryDto> categoryList = selectBoardCategory(session);
		List<BoardCategoryDto> writeList = boardService.selectWriteCategory(loginUser);
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("writeList", writeList);
		model.addAttribute("board", boardService.selectBoard(no));
		return "board/tempSaveRegist";
	}
	
	@ResponseBody
	@PostMapping("/tempSaveUpdate.do")
	public String tempSaveUpdate(BoardDto board, String[] delFileNo
							   , List<MultipartFile> uploadFiles
							   , HttpSession session) {
		
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		board.setModId(String.valueOf(loginUser.getUserId()));
		board.setTempSave("01");
		
		List<AttachDto> delFileList = attachService.selectDelFileList(delFileNo);
		
		if(board.getNoticeYN() == null || !board.getNoticeYN().equals("Y")) {
			if(board.getBoardCategory().equals("CATEGORY-8")) {
				board.setNoticeYN("Y");
			}
			else {
				board.setNoticeYN("N");
			}
		}
		
		List<AttachDto> attachList = new ArrayList<>();
		if(uploadFiles != null) {
			attachList = fileUtil.setAttach(uploadFiles, "board", loginUser, board.getBoardNo(), "B");
			board.setAttachList(attachList);
		}
		int result = boardService.updateBoard(board, delFileNo);
		
		if (result > 0) {
			for(AttachDto at : delFileList) {
				new File(at.getFilePath() + "/" + at.getFilesystemName()).delete();
			}
		}
		return result > 0 ? "SUCCESS" : "FAIL";
	}

	@GetMapping("/delete.do") 
	public String delete(@RequestParam(value = "no")List<Integer> no
				     , @RequestParam(value="type", defaultValue="CATEGORY-8") String boardType
				     , RedirectAttributes redirectAttributes) {

		int result = boardService.deleteBoard(no);

		if(result > 0) {
			redirectAttributes.addFlashAttribute("alertMsg", "삭제에 성공하였습니다.");
		}else {
			redirectAttributes.addFlashAttribute("alertMsg", " 삭제에 실패하였습니다.");
			redirectAttributes.addFlashAttribute("histortyBackYN", "Y");
		}
		
		return "redirect:/board/list.do?page=1&type=" + boardType;
	}
	
	@GetMapping("/remove.do") 
	public String removeList(@RequestParam(value = "no")List<Integer> no
						, HttpServletRequest request
				        , RedirectAttributes redirectAttributes) {

		int result = boardService.removeBoard(no);

		if(result > 0) {
			redirectAttributes.addFlashAttribute("alertMsg", "삭제에 성공하였습니다.");
		}else {
			redirectAttributes.addFlashAttribute("alertMsg", " 삭제에 실패하였습니다.");
			redirectAttributes.addFlashAttribute("histortyBackYN", "Y");
		}
		
		return "redirect:" + request.getHeader("referer");
	}
	
	@GetMapping("/trash.page")
	public String trashForm(Model model, HttpSession session
						  , @RequestParam(value="page", defaultValue="1")int currentPage) { 
		
		List<BoardCategoryDto> categoryList = selectBoardCategory(session);
		
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		
		int listCount = boardService.selectTrashListCount(loginUser.getUserId());
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 5, 10);
		
		List<BoardDto> trashList = boardService.selectTrashList(pi, loginUser.getUserId());
		
		
		model.addAttribute("pi", pi);
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("trashList", trashList);
		return "board/trash";
	}
	
	@GetMapping("/reStore.do") 
	public String reStoreList(@RequestParam(value = "no")List<Integer> no
				        , RedirectAttributes redirectAttributes) {

		int result = boardService.restoreBoard(no);

		if(result > 0) {
			redirectAttributes.addFlashAttribute("alertMsg", "복구에 성공하였습니다.");
		}else {
			redirectAttributes.addFlashAttribute("alertMsg", " 복구에 실패하였습니다.");
			redirectAttributes.addFlashAttribute("histortyBackYN", "Y");
		}
		
		return "redirect:/board/trash.page";
	}
	
	@GetMapping("/createBoard.page")
	public String createBoardForm(Model model, HttpSession session) { 
		
		List<BoardCategoryDto> categoryList = selectBoardCategory(session);
		List<DeptDto> apprList = hService.selectApprLine();
		
		model.addAttribute("apprList", apprList);
		model.addAttribute("categoryList", categoryList);
		return "board/createBoard";
	}
	
	@PostMapping("/createBoard.do")
	public String createBoard(BoardAuthDto newBoardCategory
						  , HttpSession session, String categoryTitle
						  , RedirectAttributes redirectAttributes) {
		
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		
		BoardCategoryDto newCategory = new BoardCategoryDto();
		newCategory.setCategoryName(categoryTitle);
		newCategory.setCategoryType("NORMAL");
		newCategory.setRegId(loginUser.getUserId());
		newCategory.setModId(loginUser.getUserId());
		String categoryName = boardService.createBoardCategory(newCategory);
		
		List<BoardAuthDto> listAuth = newBoardCategory.getAuthList();
		listAuth.add(BoardAuthDto.builder()
								 .userId(loginUser.getUserId())
								 .writeYN("Y")
								 .build());
		
		int result = boardService.setBoardAuth(listAuth, loginUser.getUserId());
		
		if(result > 0) {
			redirectAttributes.addFlashAttribute("alertMsg", "게시판 생성에 성공하였습니다.");
		}else {
			redirectAttributes.addFlashAttribute("alertMsg", " 게시판 생성에 실패하였습니다.");
			redirectAttributes.addFlashAttribute("histortyBackYN", "Y");
		}

		return "redirect:/board/list.do?type=" + categoryName;
	}
	
	@GetMapping("/updateBoard.page")
	public String updateBoardForm(@RequestParam(value="type", defaultValue="CATEGORY-8") String boardType
								 ,Model model, HttpSession session) { 
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		List<BoardCategoryDto> categoryList = selectBoardCategory(session);
		List<DeptDto> apprList = hService.selectApprLine();
		MemberDto categoryMaster = memeberService.selectCategoryMaster(boardType);
		
		List<BoardAuthDto> normalUserList = boardService.selectNormalUser(boardType);
		
		String boardName ="";
		for(int i=0; i<categoryList.size(); i++) {
			if(categoryList.get(i).getBoardCategory().equals(boardType)) {
				boardName = categoryList.get(i).getCategoryName();
			}
		}
		
		Iterator<BoardAuthDto> iterator = normalUserList.iterator();
        while (iterator.hasNext()) {
        	BoardAuthDto data = iterator.next();
            if (data.getUserId().equals(categoryMaster.getUserId()) || 
        		data.getUserId().equals(loginUser.getUserId())) {
                iterator.remove();
            }
        }
        
		model.addAttribute("apprList", apprList);
		model.addAttribute("boardName", boardName);
		model.addAttribute("boardType", boardType);
		model.addAttribute("masterCount", categoryMaster.getUserId().equals(loginUser.getUserId()) ? 1 : 2);
		model.addAttribute("normalUserList", normalUserList);
		model.addAttribute("categoryMaster", categoryMaster);
		model.addAttribute("categoryList", categoryList);
		
		return "board/updateBoard";
	}
	
	@PostMapping("/updateBoard.do")
	public String updateBoard(@RequestParam(value="type", defaultValue="CATEGORY-8") String boardType
						  , BoardAuthDto newBoardCategory
						  , HttpSession session, String categoryTitle
						  , RedirectAttributes redirectAttributes) {
		
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		
		List<BoardAuthDto> listAuth = newBoardCategory.getAuthList();
		
		int result1 = boardService.resetBoardUser(boardType);
		Map<String, String> map = new HashMap<>();
		map.put("categoryTitle", categoryTitle);
		map.put("boardType", boardType);
		int result2 = boardService.updateCategoryTitle(map);
		int result3 = 0;
		if( !listAuth.isEmpty() && result2 > 0) {
			result3 = boardService.reallocationBoardAuth(listAuth, loginUser.getUserId());
		}
		
		if(result3 == listAuth.size()) {
			redirectAttributes.addFlashAttribute("alertMsg", "게시판 수정에 성공하였습니다.");
		}else {
			redirectAttributes.addFlashAttribute("alertMsg", " 게시판 수정에 실패하였습니다.");
			redirectAttributes.addFlashAttribute("histortyBackYN", "Y");
		}
		
		return "redirect:/board/list.do?type=" + boardType;
	}
	
	@GetMapping("deleteCategory.do")
	public String deleteCategory(@RequestParam(value="type", defaultValue="CATEGORY-8") String boardType
							 , RedirectAttributes redirectAttributes) {
		
		int result = boardService.deleteCategory(boardType);
		
		if(result > 0 ) {
			redirectAttributes.addFlashAttribute("alertMsg", "게시판 삭제에 성공하였습니다.");
		}else {
			redirectAttributes.addFlashAttribute("alertMsg", " 게시판 삭제에 실패하였습니다.");
			redirectAttributes.addFlashAttribute("histortyBackYN", "Y");
		}
		return "redirect:/board/list.do?";
	}
	
	@ResponseBody
	@PostMapping("/registReply.do")
	public String ajaxInsertReply(ReplyDto reply, HttpSession session) {
		
		MemberDto loginUser = (MemberDto)session.getAttribute("loginUser");
		reply.setRegId(loginUser.getUserId());
		
		return boardService.insertReply(reply) > 0 ? "SUCCESS" : "FAIL";
	}
	
	@ResponseBody
	@GetMapping(value="/replyList.do", produces="application/json; charset=UTF-8")
	public List<ReplyDto> replyList(int no) {
		return boardService.selectReplyList(no);
	}
	
	@ResponseBody
	@PostMapping("/deleteReply.do")
	public String ajaxDeleteReply(int replyNo) {
		return boardService.deleteReply(replyNo) > 0 ? "SUCCESS" : "FAIL";
	}
		
	@ResponseBody
	@PostMapping("/updateReply.do")
	public String ajaxupdateReply(ReplyDto reply) {
		
		return boardService.updateReply(reply) > 0 ? "SUCCESS" : "FAIL";
	}
	
}
