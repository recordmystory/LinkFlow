package com.mm.linkflow.service.service;

import java.util.List;
import java.util.Map;

import com.mm.linkflow.dto.DailyDto;
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
	
	// 파견인원 조회
	List<DispatchDto> selectProjectDispatch(int no);
	
	// 파견인원 추가
	void addDispatch(DispatchDto dis);
	
	// 파견인원 등록 체크
	int checkDispatch(DispatchDto dis);
	
	// 파견인원 수정
	void modifyDispatch(DispatchDto dis);
	
	// 파견인원 삭제
	int deleteDispatch(DispatchDto dis);
	
	// 프로젝트 & 파견인원 동시 삭제
	void deleteProjectDispatch(int proNo);
	
	// 프로젝트 수정
	void modifyProject(ProjectDto pro);
	
	// 프로젝트 삭제
	void deleteProject(int proNo);
	
	// 프로젝트 인원 조회
	List<DispatchDto> listDispatch(PageInfoDto pi);
	
	// 프로젝트 인원 수 조회
	int listDispatchCount();
	
	// 인원 검색 수 조회
	int searchDispatchCount(Map<String, String> search);
	
	// 인원 검색 조회
	List<DispatchDto> searchDispatchList(Map<String, String> search, PageInfoDto pi);
	
	// 본인 프로젝트 조회
	List<DispatchDto> myDispatchList(String userId, PageInfoDto pi);
	
	// 본인 프로젝트 카운트 조회
	int myDispatchCount(String userId);
	
	// 프로젝트 PM 여부 확인
//	int projectPmCount(String userId);
	
	// 일일작업 리스트 조회
	List<DailyDto> dailyList(String userId, PageInfoDto pi);
	
	// 일일작업 카운트 조회
	int dailyCount(String userId);
	
	// 일일작업 등록
	void addDaily(DailyDto dai);
	
	// 일일작업 중복 체크
	int dailyCheck(DailyDto dai);
	
	// 본인 프로젝트 조회(일일작업 용)
	List<DispatchDto> dailyProjectList(String userId);
	
	// 일일작업 조회
	DailyDto detailDaily(int daiNo);
	
	// 일일작업 수정
	void modifyDaily(DailyDto dai);
	
	// 일일작업 삭제
	void deleteDaily(int daiNo);
	
	// 일일작업 검색 조회
	List<DailyDto> searchDaily(Map<String, String> search, PageInfoDto pi);
	
	// 일일작업 검색 카운트
	int searchDailyCount(Map<String, String> search);
	
	// 직원별 일일작업 조회
	List<DailyDto> listDailyLead(PageInfoDto pi, Map<String, String> map);
	
	// 직원별 일일작업 카운트
	int listDailyLeadCount(Map<String, String> map);
	
	// 직원별 일일작업 검색 조회
	List<DailyDto> searchDailyLead(Map<String, String> search, PageInfoDto pi);
	
	// 직원별 일일작업 검색 카운트
	int searchDailyLeadCount(Map<String, String> search);
	
	// 직원별 일일작업 피드백
	void modifyDailyLead(DailyDto dai);
}
