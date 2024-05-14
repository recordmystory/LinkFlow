package com.mm.linkflow.service.service;

import java.util.List;

import com.mm.linkflow.dto.BoardCategoryDto;
import com.mm.linkflow.dto.MemberDto;

public interface BoardService {
	
	List<BoardCategoryDto> selectBoardType(MemberDto loginUser);
}
