package com.mm.linkflow.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mm.linkflow.dto.BoardCategoryDto;
import com.mm.linkflow.dto.MemberDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class BoardDao {
	
	private final SqlSessionTemplate sqlSessionTemplate;

	public List<BoardCategoryDto> selectBoardType(MemberDto loginUser) {
		return sqlSessionTemplate.selectList("boardMapper.selectBoardCategory", loginUser);
	}

}
