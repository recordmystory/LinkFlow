package com.mm.linkflow.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

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
		
		return sql.selectList("projectMapper.selectProjectList", rowBounds);
	}
	
	// 프로젝트 카운트 조회
	public int selectProjectCount() {
		return sql.selectOne("projectMapper.selectProjectCount");
	}
}
