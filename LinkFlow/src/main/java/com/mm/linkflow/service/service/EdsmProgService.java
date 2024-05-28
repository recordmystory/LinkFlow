package com.mm.linkflow.service.service;

import java.util.List;
import java.util.Map;

import com.mm.linkflow.dto.DeptDto;
import com.mm.linkflow.dto.EdocDto;
import com.mm.linkflow.dto.EdocFormDto;
import com.mm.linkflow.dto.EdocHistDto;
import com.mm.linkflow.dto.EdocRefDto;
import com.mm.linkflow.dto.PageInfoDto;

public interface EdsmProgService {
	
	// 문서 종류 (양식) 리스트 조회 용도
	List<EdocFormDto> selectFormList();
	
	// 문서 종류에 따른 양식 내용 조회 용도
	List<EdocFormDto> selectEdFrContentList(String docType);
	
	// 결재선 설정 모달 조회
	List<DeptDto> selectApprLine();
	
	// 기안서 작성 (결재 작성 문서 insert)
	int insertDoc(EdocDto edocDto);
	
	// 진행중인 문서 목록 페이징 (전체)
	int selectAllListCnt(String userId);

	// 진행중인 문서 목록 조회 (전체)
	List<EdocFormDto> selectAllList(PageInfoDto pi, String userId);
	
	// 진행중인 문서 목록 검색 (전체)
	int selectSearchListCnt(Map<String, String> search);

	List<EdocDto> selectSearchList(Map<String, String> search, PageInfoDto pi);
	
	// 진행중인 문서 상세 (기안문서 정보 + 기안자 정보 조회)
	EdocDto selectEdocDetail(String edNo);
	
	// 진행중인 문서 상세 (보안등급 수정)
	int updateSecCode(EdocDto edocDto);

	// 진행중인 문서 상세 (기안 취소)
	int modifyDelYn(String edNo);
	
	// 진행중인 문서 상세 (결재)
	int updateEdocHist(EdocHistDto edocHistDto);
	
	// 진행중인 문서 상세 (결재한 사람 count)
	int selectEdHistSubCodeCnt(EdocHistDto edocHistDto);
	
	// 결재 상태 05로 업데이트
	int updateEdocStatusAppr(EdocHistDto edocHistDto);
	
	// 결재 상태 06로 업데이트
	int updateEdocStatusCxl(EdocHistDto edocHistDto);
}
