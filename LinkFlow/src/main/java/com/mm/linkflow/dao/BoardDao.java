package com.mm.linkflow.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mm.linkflow.dto.BoardCategoryDto;
import com.mm.linkflow.dto.BoardDto;
import com.mm.linkflow.dto.MemberDto;
import com.mm.linkflow.dto.PageInfoDto;

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
	
}
