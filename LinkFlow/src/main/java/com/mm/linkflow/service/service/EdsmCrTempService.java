package com.mm.linkflow.service.service;


import java.util.List;
import java.util.Map;

import com.mm.linkflow.dto.EdocFormDto;
import com.mm.linkflow.dto.PageInfoDto;

public interface EdsmCrTempService {
	// 양식 등록
	int insertForm(EdocFormDto edsmForm);
	
	// 양식 목록 조회 및 페이징
	int selectCrTempListCnt();

	List<EdocFormDto> selectCrTempList(PageInfoDto pi);
	
	// 양식명으로 검색 
	int selectSearchListCnt(Map<String, String> search);
	
	List<EdocFormDto> selectSearchList(Map<String, String> search, PageInfoDto pi);
	
	// 양식 상세 조회
	EdocFormDto selectCrTemp(String no);

	// 양식 수정
	int updateCrTemp(EdocFormDto edsmForm);
}
