package com.mm.linkflow.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.mm.linkflow.dao.AttachDao;
import com.mm.linkflow.dao.BoardDao;
import com.mm.linkflow.dto.AttachDto;
import com.mm.linkflow.dto.BoardCategoryDto;
import com.mm.linkflow.dto.BoardDto;
import com.mm.linkflow.dto.MemberDto;
import com.mm.linkflow.dto.PageInfoDto;
import com.mm.linkflow.service.service.BoardService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class BoardServiceImpl implements BoardService {

	private final BoardDao boardDao;
	private final AttachDao attachDao;
	
	// 권한별 카테고리 조회
	@Override
	public List<BoardCategoryDto> selectBoardType(MemberDto loginUser) {
		return boardDao.selectBoardType(loginUser);
	}
	
	// 게시판 리스트갯수 조회
	@Override
	public int selectBoardListCount(String boardType) {
		return boardDao.selectBoardListCount(boardType);
	}

	// 페이징별 게시판 조회
	@Override
	public List<BoardDto> selectBoardList(PageInfoDto pi, String boardType) {
		return boardDao.selectBoardList(pi, boardType);
	}

	// 공지사항 조회용 - 황민우
	@Override
	public List<BoardDto> selectNewNoticeList() {
		return boardDao.selectNewNoticeList();
	}

	// 게시글작성
	@Override
	public int insertBoard(BoardDto board) {
		// board insert
		int result1 = boardDao.insertBoard(board);
		
		int result2 = 1;
		List<AttachDto> attachList = board.getAttachList();
		log.debug("list : {}", attachList);
		if(!attachList.isEmpty()) {
			result2 = 0;
			for(AttachDto at : attachList) {
				result2 += attachDao.insertAttach(at);
			}
		}
		return result1 * result2;
	}

	@Override
	public int updateIncreaseCount(int no) {
		return boardDao.updateIncreaseCount(no);
	}

	@Override
	public BoardDto selectBoard(int no) {
		return boardDao.selectBoard(no);
	}

}
