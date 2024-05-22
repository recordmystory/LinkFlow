package com.mm.linkflow.service.service;

import java.util.List;

import com.mm.linkflow.dto.ProjectDto;


public interface ProjectService {
	
	// 프로젝트 목록 조회
	List<ProjectDto> listProject();
	
	// 프로젝트 등록
	int addProject(ProjectDto pro);
	
}
