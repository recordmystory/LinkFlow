package com.mm.linkflow.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

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
}
