package com.mm.linkflow.service.service;

import java.util.List;
import java.util.Map;

import com.mm.linkflow.dto.EdocDto;
import com.mm.linkflow.dto.PageInfoDto;

public interface EdsmDocboxService {
	
	// 문서함 목록 조회 및 페이징
	int selectDocboxListCnt(String userId);

	List<EdocDto> selectDocboxList(PageInfoDto pi, String userId);
	
	// 검색 및 페이징
	int selectSearchListCnt(Map<String, String> search);

	List<EdocDto> selectSearchList(Map<String, String> search, PageInfoDto pi);

	EdocDto selectEdocDetail(String edNo);
	
}
