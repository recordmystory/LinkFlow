package com.mm.linkflow.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.mm.linkflow.dao.BoardDao;
import com.mm.linkflow.dto.BoardCategoryDto;
import com.mm.linkflow.dto.BoardDto;
import com.mm.linkflow.dto.MemberDto;
import com.mm.linkflow.dto.PageInfoDto;
import com.mm.linkflow.service.service.BoardService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class BoardServiceImpl implements BoardService {

	private final BoardDao boardDao;
	
	@Override
	public List<BoardCategoryDto> selectBoardType(MemberDto loginUser) {
		return boardDao.selectBoardType(loginUser);
	}

	@Override
	public int selectBoardListCount(String boardType) {
		return boardDao.selectBoardListCount(boardType);
	}

	@Override
	public List<BoardDto> selectBoardList(PageInfoDto pi, String boardType) {
		return boardDao.selectBoardList(pi, boardType);
	}

	// 공지사항 조회용 - 황민우
	@Override
	public List<BoardDto> selectNewNoticeList() {
		return boardDao.selectNewNoticeList();
	}

}
