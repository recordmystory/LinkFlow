package com.mm.linkflow.service.service;

import java.util.List;
import java.util.Map;

import com.mm.linkflow.dto.DispatchDto;
import com.mm.linkflow.dto.PageInfoDto;
import com.mm.linkflow.dto.ProjectDto;


public interface ProjectService {
	
	// 프로젝트 목록 조회
	List<ProjectDto> listProject(PageInfoDto pi);
	
	// 프로젝트 목록 검색
	List<ProjectDto> searchListProject(Map<String, String> search, PageInfoDto pi);
	
	// 프로젝트 등록
	int addProject(ProjectDto pro);
	
	// 프로젝트 카운트
	int selectProjectCount();
	
	// 프로젝트 검색 카운트
	int searchProjectCount(Map<String, String> search);
	
	// 프로젝트 상세 조회
	ProjectDto selectDetailProject(int no);
	
	// 프로젝트 투입인원 조회
	List<DispatchDto> selectProjectDispatch(int no);
	
	// 프로젝트 투입인원 추가
	void addDispatch(DispatchDto dis);
	
	// 프로젝트 투입인원 체크
	int checkDispatch(DispatchDto dis);
}
