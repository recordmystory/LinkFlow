package com.mm.linkflow.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mm.linkflow.dto.BoardAuthDto;
import com.mm.linkflow.dto.BoardCategoryDto;
import com.mm.linkflow.dto.BoardDto;
import com.mm.linkflow.dto.MemberDto;
import com.mm.linkflow.dto.PageInfoDto;
import com.mm.linkflow.dto.ReplyDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class BoardDao {
	
	private final SqlSessionTemplate sqlSession;

	public List<BoardCategoryDto> selectBoardType(MemberDto loginUser) {
		return sqlSession.selectList("boardMapper.selectBoardCategory", loginUser);
	}

	public int selectBoardListCount(String boardType) {
		return sqlSession.selectOne("boardMapper.selectBoardListCount", boardType);
	}
	
	public List<BoardDto> selectNoticeBoardList(String boardType) {
		return sqlSession.selectList("boardMapper.selectNoticeBoardList", boardType);
	}

	public List<BoardDto> selectBoardList(PageInfoDto pi, String boardType) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1) * limit;
		
		RowBounds rowBounds= new RowBounds( offset, limit );
		
		return sqlSession.selectList("boardMapper.selectBoardList", boardType, rowBounds);
	}
	
	public List<BoardDto> selectNewNoticeList() {
		
		RowBounds rowBounds= new RowBounds( 0, 5 );
		
		return sqlSession.selectList("boardMapper.selectBoardList", "CATEGORY-8", rowBounds);
	}

	public int insertBoard(BoardDto board) {
		return sqlSession.insert("boardMapper.insertBoard", board);
	}

	public int updateIncreaseCount(int no) {
		return sqlSession.update("boardMapper.updateIncreaseCount", no);
	}

	public BoardDto selectBoard(int no) {
		return sqlSession.selectOne("boardMapper.selectBoard", no);
	}

	public int updateBoard(BoardDto board) {
		return sqlSession.update("boardMapper.updateBoard", board);
	}

	public int selectSearchListCount(Map<String, String> search) {
		return sqlSession.selectOne("boardMapper.selectSearchListCount", search);
	}

	public List<BoardDto> selectSearchList(Map<String, String> search, PageInfoDto pi) {
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1) * limit;
		
		RowBounds rowBounds= new RowBounds( offset, limit );
		
		return sqlSession.selectList("boardMapper.selectSearchList", search, rowBounds);
	}

	public List<BoardDto> selectTempSaveList(PageInfoDto pi, String userId) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1) * limit;
		
		RowBounds rowBounds= new RowBounds( offset, limit );
		
		return sqlSession.selectList("boardMapper.selectTempSaveList", userId, rowBounds);
	}

	public int deleteBoard(List<Integer> no) {
		return sqlSession.update("boardMapper.deleteBoard", no);
	}

	public int selectCurrnetTempSave() {
		return sqlSession.selectOne("boardMapper.selectCurrnetTempSave");
	}

	public int selectTempSaveListCount(String userId) {
		return sqlSession.selectOne("boardMapper.selectTempSaveListCount", userId);
	}

	public int removeBoard(List<Integer> no) {
		return sqlSession.delete("boardMapper.removeBoardList", no);
	}

	public int selectTrashListCount(String userId) {
		return sqlSession.selectOne("boardMapper.selectTrashListCount", userId);
	}

	public List<BoardDto> selectTrashList(PageInfoDto pi, String userId) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1) * limit;
		
		RowBounds rowBounds= new RowBounds( offset, limit );
		
		return sqlSession.selectList("boardMapper.selectTrashList", userId, rowBounds);
	}

	public int restoreBoard(List<Integer> no) {
		return sqlSession.update("boardMapper.restoreBoard", no);
	}

	public int createBoardCategory(BoardCategoryDto newCategory) {
		return sqlSession.insert("boardMapper.createBoardCategory", newCategory);
	}

	public String selectCurrentBoardCategory() {
		return sqlSession.selectOne("boardMapper.selectCurrentBoardCategory");
	}

	public int setBoardAuth(BoardAuthDto at) {
		return sqlSession.insert("boardMapper.setBoardAuth", at);
	}

	public List<BoardAuthDto> selectNormalUser(String boardType) {
		return sqlSession.selectList("boardMapper.selectNormalUser", boardType);
	}

	public List<BoardCategoryDto> selectWriteCategory(MemberDto loginUser) {
		return sqlSession.selectList("boardMapper.selectWriteCategory", loginUser);
	}

	public int resetBoardUser(String boardType) {
		return sqlSession.delete("boardMapper.resetBoardUser", boardType);
	}

	public int updateCategoryTitle(Map<String, String> map) {
		return sqlSession.update("boardMapper.updateCategoryTitle", map);
	}

	public int deleteCategory(String boardType) {
		return sqlSession.update("boardMapper.deleteCategory", boardType);
	}

	public int insertReply(ReplyDto reply) {
		return sqlSession.insert("boardMapper.insertReply", reply);
	}

	public List<ReplyDto> selectReplyList(int no) {
		return sqlSession.selectList("boardMapper.selectReplyList", no);
	}

	public int deleteReply(int replyNo) {
		return sqlSession.update("boardMapper.deleteReply", replyNo);
	}

	public int updateReply(ReplyDto reply) {
		return sqlSession.update("boardMapper.updateReply", reply);
	}

	public int removeReply(int index) {
		return sqlSession.delete("boardMapper.removeReply", index);
	}
}
