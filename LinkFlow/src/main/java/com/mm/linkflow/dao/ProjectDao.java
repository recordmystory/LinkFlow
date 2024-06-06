package com.mm.linkflow.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mm.linkflow.dto.DailyDto;
import com.mm.linkflow.dto.DispatchDto;
import com.mm.linkflow.dto.PageInfoDto;
import com.mm.linkflow.dto.ProjectDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class ProjectDao {
	private final SqlSessionTemplate sql;
	
	// 프로젝트 등록
	public int addProject(ProjectDto pro) {
		return sql.insert("projectMapper.addProject", pro);
	}
	
	// 프로젝트 목록 조회
	public List<ProjectDto> selectProjectList(PageInfoDto pi){
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1) * limit;
		
		RowBounds rowBounds= new RowBounds( offset, limit );
		
		return sql.selectList("projectMapper.selectProjectList", null, rowBounds);
	}
	
	// 프로젝트 목록 검색
	public List<ProjectDto> searchListProject(Map<String, String> search, PageInfoDto pi){
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1) * limit;
		
		RowBounds rowBounds= new RowBounds( offset, limit );
		
		return sql.selectList("projectMapper.searchListProject", search, rowBounds);
	}
	
	// 프로젝트 카운트 조회
	public int selectProjectCount() {
		return sql.selectOne("projectMapper.selectProjectCount");
	}
	
	// 프로젝트 검색 카운트 조회
	public int searchProjectCount(Map<String, String> search) {
		return sql.selectOne("projectMapper.searchProjectCount", search);
	}
	
	// 프로젝트 상세 조회
	public ProjectDto selectDetailProject(int no) {
		return sql.selectOne("projectMapper.selectDetailProject", no);
	}
	
	// 파견인원 조회
	public List<DispatchDto> selectProjectDispatch(int no){
		return sql.selectList("projectMapper.selectProjectDispatch", no);
	}
	
	// 파견인원 추가
	public void addDispatch(DispatchDto dis) {
		sql.insert("projectMapper.addDispatch", dis);
	}
	
	// 파견인원 등록 체크
	public int checkDispatch(DispatchDto dis) {
		return sql.selectOne("projectMapper.checkDispatch", dis);
	}
	
	// 파견인원 수정
	public void modifyDispatch(DispatchDto dis) {
		sql.update("projectMapper.modifyDispatch", dis);
	}
	
	// 파견인원 삭제
	public int deleteDispatch(DispatchDto dis) {
		return sql.delete("projectMapper.deleteDispatch", dis);
	}
	
	// 프로젝트 & 파견인원 동시 삭제
	public void deleteProjectDispatch(int proNo) {
		sql.delete("projectMapper.deleteProjectDispatch", proNo);
	}
	
	// 프로젝트 수정
	public void modifyProject(ProjectDto pro) {
		sql.update("projectMapper.modifyProject", pro);
	}
	
	// 프로젝트 삭제
	public void deleteProject(int proNo) {
		sql.update("projectMapper.deleteProject", proNo);
	}
	
	// 프로젝트 인원 조회
	public List<DispatchDto> listDispatch(PageInfoDto pi){
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1) * limit;
		
		RowBounds rowBounds= new RowBounds( offset, limit );
		
		return sql.selectList("projectMapper.listDispatch", null, rowBounds);
	}
	
	// 프로젝트 인원 수 조회
	public int listDispatchCount() {
		return sql.selectOne("projectMapper.listDispatchCount");
	}
	
	// 인원 검색 수 조회
	public int searchDispatchCount(Map<String, String> search) {
		return sql.selectOne("projectMapper.searchDispatchCount", search);
	}
	
	// 인원 검색 조회
	public List<DispatchDto> searchDispatchList(Map<String, String> search, PageInfoDto pi){
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1) * limit;
		
		RowBounds rowBounds= new RowBounds( offset, limit );
		
		return sql.selectList("projectMapper.searchDispatchList", search, rowBounds);
	}
	
	// 본인 프로젝트 조회
	public List<DispatchDto> myDispatchList(String userId, PageInfoDto pi){
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1) * limit;
		
		RowBounds rowBounds= new RowBounds( offset, limit );
		
		return sql.selectList("projectMapper.myDispatchList", userId, rowBounds);
	}
	
	// 본인 프로젝트 카운트 조회
	public int myDispatchCount(String userId) {
		return sql.selectOne("projectMapper.myDispatchCount", userId);
	}
	
	/*
	// 프로젝트 PM여부 확인
	public int projectPmCount(String userId) {
		return sql.selectOne("projectMapper.projectPmCount", userId);
	}
	*/
	
	// 일일작업 리스트 조회
	public List<DailyDto> dailyList(String userId, PageInfoDto pi){
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1) * limit;
		
		RowBounds rowBounds= new RowBounds( offset, limit );
		return sql.selectList("projectMapper.dailyList", userId, rowBounds);
	}
	
	// 일일작업 카운트 조회
	public int dailyCount(String userId) {
		return sql.selectOne("projectMapper.dailyCount", userId);
	}
	
	// 일일작업 등록
	public void addDaily(DailyDto dai) {
		sql.insert("projectMapper.addDaily", dai);
	}
	
	// 일일작업 중복 체크
	public int dailyCheck(DailyDto dai) {
		return sql.selectOne("projectMapper.dailyCheck", dai);
	}
	
	// 본인 프로젝트 조회(일일작업 용)
	public List<DispatchDto> dailyProjectList(String userId){
		return sql.selectList("projectMapper.dailyProjectList", userId);
	}
	
	// 일일작업 조회
	public DailyDto detailDaily(int daiNo) {
		return sql.selectOne("projectMapper.detailDaily", daiNo);
	}
	
	// 일일작업 수정
	public void modifyDaily(DailyDto dai) {
		sql.update("projectMapper.modifyDaily", dai);
	}
	
	// 일일작업 삭제
	public void deleteDaily(int daiNo) {
		sql.update("projectMapper.deleteDaily", daiNo);
	}
	
	// 일일작업 검색 조회
	public List<DailyDto> searchDaily(Map<String, String> search, PageInfoDto pi){
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1) * limit;
		
		RowBounds rowBounds= new RowBounds( offset, limit );
		
		return sql.selectList("projectMapper.searchDaily", search, rowBounds);
	}
	
	// 일일작업 검색 카운트
	public int searchDailyCount(Map<String, String> search) {
		return sql.selectOne("projectMapper.searchDailyCount", search);
	}
	
	// 직원별 일일작업 조회
	public List<DailyDto> listDailyLead(PageInfoDto pi, Map<String, String> map){
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1) * limit;
		
		RowBounds rowBounds= new RowBounds( offset, limit );
		
		return sql.selectList("projectMapper.listDailyLead", map, rowBounds);
	}
	
	// 직원별 일일작업 카운트
	public int listDailyLeadCount(Map<String, String> map)	{
		return sql.selectOne("projectMapper.listDailyLeadCount", map);
	}
	
	// 직원별 일일작업 검색 조회
	public List<DailyDto> searchDailyLead(Map<String, String> search, PageInfoDto pi){
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1) * limit;
		
		RowBounds rowBounds= new RowBounds( offset, limit );
		
		return sql.selectList("projectMapper.searchDailyLead", search, rowBounds);
	}
	// 직원별 일일작업 검색 카운트
	public int searchDailyLeadCount(Map<String, String> search){
		return sql.selectOne("projectMapper.searchDailyLeadCount", search);
	}
	
	// 직원별 일일작업 피드백
	public void modifyDailyLead(DailyDto dai) {
		sql.update("projectMapper.modifyDailyLead", dai);
	}
}
