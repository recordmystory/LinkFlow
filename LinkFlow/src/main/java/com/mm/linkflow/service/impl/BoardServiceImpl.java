package com.mm.linkflow.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;

import com.mm.linkflow.dao.AttachDao;
import com.mm.linkflow.dao.BoardDao;
import com.mm.linkflow.dto.AttachDto;
import com.mm.linkflow.dto.BoardAuthDto;
import com.mm.linkflow.dto.BoardCategoryDto;
import com.mm.linkflow.dto.BoardDto;
import com.mm.linkflow.dto.MemberDto;
import com.mm.linkflow.dto.PageInfoDto;
import com.mm.linkflow.dto.ReplyDto;
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
	
	@Override
	public int selectTrashListCount(String userId) {
		return boardDao.selectTrashListCount(userId);
	}

	@Override
	public List<BoardDto> selectNoticeBoardList(String boardType) {
		return boardDao.selectNoticeBoardList(boardType);
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
		
		int result1 = boardDao.insertBoard(board);
		
		int result2 = 1;
		List<AttachDto> attachList = board.getAttachList();
		log.debug("attachList : {}", attachList);
		ObjectUtils.isEmpty(attachList);
		if(!ObjectUtils.isEmpty(attachList)) {
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

	@Override
	public int updateBoard(BoardDto board, String[] delFileNo) {
		
		int result1 = boardDao.updateBoard(board);
		int result2 = delFileNo == null ? 1
										: attachDao.deleteAttach(delFileNo);
		
		List<AttachDto> list = board.getAttachList();
		int result3 = 0;
		if(list != null) {
			for(AttachDto at : list) {
				result3 += attachDao.insertAttach(at);
			}
		}else {
			list = new ArrayList<>();
		}
		
		return result1 == 1
				&& result2 > 0
					&& result3 == list.size() 
						? 1 : -1 ;
	}

	@Override
	public int selectSearchListCount(Map<String, String> search) {
		return boardDao.selectSearchListCount(search);
	}

	@Override
	public List<BoardDto> selectSearchList(Map<String, String> search, PageInfoDto pi) {
		return boardDao.selectSearchList(search, pi);
	}

	@Override
	public List<BoardDto> selectTempSaveList(PageInfoDto pi, String userId) {
		return boardDao.selectTempSaveList(pi, userId);
	}

	@Override
	public int deleteBoard(List<Integer> no) {
		return boardDao.deleteBoard(no);
	}

	@Override
	public int selectCurrnetTempSave() {
		return boardDao.selectCurrnetTempSave();
	}

	@Override
	public int selectTempSaveListCount(String userId) {
		return boardDao.selectTempSaveListCount(userId);
	}

	@Override
	public int removeBoard(List<Integer> no) {
		int result2 = 1;
		int result3 = 1;
		for(int index : no) {
			List<String> delFileNo = attachDao.selectDelBoardFileNo(index);
			
			if(!ObjectUtils.isEmpty(delFileNo)) {
				result2 = 0;
				
				String[] delFileNoArray = new String[delFileNo.size()];
				delFileNo.toArray(delFileNoArray);
				
				for(int i=0; i<delFileNoArray.length; i++) {
					log.debug("delFileNoArray[{}] : {}", i, delFileNoArray[i]);
				}
				
				result2 = attachDao.deleteAttach(delFileNoArray);	
				
				List<AttachDto> delFileList = attachDao.selectDelFileList(delFileNoArray);
				for(AttachDto at : delFileList) {
					new File(at.getFilePath() + "/" + at.getFilesystemName()).delete();
				}
			}
			
			result3 += boardDao.removeReply(index);
		}
		int result1 = boardDao.removeBoard(no);
		return result1;
	}

	@Override
	public List<BoardDto> selectTrashList(PageInfoDto pi, String userId) {
		return boardDao.selectTrashList(pi, userId);
	}

	@Override
	public int restoreBoard(List<Integer> no) {
		return boardDao.restoreBoard(no);
	}

	@Override
	public String createBoardCategory(BoardCategoryDto newCategory) {
		
		int result1 = boardDao.createBoardCategory(newCategory);
		String selectBoardCategory = "";
		if (result1 > 0) {
			selectBoardCategory = boardDao.selectCurrentBoardCategory();
		}
		
		return selectBoardCategory;
	}

	@Override
	public int setBoardAuth(List<BoardAuthDto> listAuth, String userId) {
		int result = 0;
		for(BoardAuthDto at : listAuth) {
			at.setRegId(userId);
			at.setModId(userId);
			if(at.getWriteYN() == null) {
				at.setWriteYN("N");
			}
			result += boardDao.setBoardAuth(at);
		}
		return result;
	}

	@Override
	public List<BoardAuthDto> selectNormalUser(String boardType) {
		return boardDao.selectNormalUser(boardType);
	}

	@Override
	public List<BoardCategoryDto> selectWriteCategory(MemberDto loginUser) {
		return boardDao.selectWriteCategory(loginUser);
	}

	@Override
	public int resetBoardUser(String boardType) {
		return boardDao.resetBoardUser(boardType);
	}

	@Override
	public int reallocationBoardAuth(List<BoardAuthDto> listAuth, String userId) {
		int result = 0;
		for(BoardAuthDto at : listAuth) {
			at.setRegId(userId);
			at.setModId(userId);
			if(at.getWriteYN() == null) {
				at.setWriteYN("N");
			}
			result += boardDao.setBoardAuth(at);
		}
		return result;
	}

	@Override
	public int updateCategoryTitle(Map<String, String> map) {
		return boardDao.updateCategoryTitle(map);
	}

	@Override
	public int deleteCategory(String boardType) {
		return boardDao.deleteCategory(boardType);
	}

	@Override
	public int insertReply(ReplyDto reply) {
		return boardDao.insertReply(reply);
	}

	@Override
	public List<ReplyDto> selectReplyList(int no) {
		return boardDao.selectReplyList(no);
	}

	@Override
	public int deleteReply(int replyNo) {
		return boardDao.deleteReply(replyNo);
	}

	@Override
	public int updateReply(ReplyDto reply) {
		return boardDao.updateReply(reply);
	}

}
