package com.mm.linkflow.service.service;

import java.util.List;
import java.util.Map;

import com.mm.linkflow.dto.BoardAuthDto;
import com.mm.linkflow.dto.BoardCategoryDto;
import com.mm.linkflow.dto.BoardDto;
import com.mm.linkflow.dto.MemberDto;
import com.mm.linkflow.dto.PageInfoDto;

public interface BoardService {
	
	// 권한별 게시판 카테고리 조회
	List<BoardCategoryDto> selectBoardType(MemberDto loginUser);

	// 게시글갯수 조회
	int selectBoardListCount(String boardType);

	// 페이징별 게시글리스트 조회
	List<BoardDto> selectBoardList(PageInfoDto pi, String boardType);
	
	// 공지사항 조회용 - 황민우
	List<BoardDto> selectNewNoticeList();
	
	// 게시글 작성
	int insertBoard(BoardDto board);
	
	// 조회수 증가
	int updateIncreaseCount(int no);

	BoardDto selectBoard(int no);

	int updateBoard(BoardDto board, String[] delFileNo);

	List<BoardDto> selectNoticeBoardList(String boardType);

	int selectSearchListCount(Map<String, String> search);

	List<BoardDto> selectSearchList(Map<String, String> search, PageInfoDto pi);

	List<BoardDto> selectTempSaveList(PageInfoDto pi, String userId);

	int deleteBoard(List<Integer> no);

	int selectCurrnetTempSave();

	int selectTempSaveListCount(String userId);

	int removeBoard(List<Integer> no);

	int selectTrashListCount(String userId);

	List<BoardDto> selectTrashList(PageInfoDto pi, String userId);

	int restoreBoard(List<Integer> no);

	String createBoardCategory(BoardCategoryDto newCategory);

	int setBoardAuth(List<BoardAuthDto> listAuth, String userId);

	List<BoardAuthDto> selectNormalUser(String boardType);

	List<BoardCategoryDto> selectWriteCategory(MemberDto loginUser);

	int resetBoardUser(String boardType);

	int reallocationBoardAuth(List<BoardAuthDto> listAuth, String userId);

	int updateCategoryTitle(Map<String, String> map);

	int deleteCategory(String boardType);

}
