package com.mm.linkflow.service.service;

import java.util.List;

import com.mm.linkflow.dto.BoardCategoryDto;
import com.mm.linkflow.dto.BoardDto;
import com.mm.linkflow.dto.MemberDto;
import com.mm.linkflow.dto.PageInfoDto;

public interface BoardService {
	
	List<BoardCategoryDto> selectBoardType(MemberDto loginUser);

	int selectBoardListCount(String boardType);

	List<BoardDto> selectBoardList(PageInfoDto pi, String boardType);
	
	// 공지사항 조회용 - 황민우
	List<BoardDto> selectNewNoticeList();
}
