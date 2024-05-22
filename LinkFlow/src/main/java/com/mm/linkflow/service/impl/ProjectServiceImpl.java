package com.mm.linkflow.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.mm.linkflow.dao.ProjectDao;
import com.mm.linkflow.dto.PageInfoDto;
import com.mm.linkflow.dto.ProjectDto;
import com.mm.linkflow.service.service.ProjectService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class ProjectServiceImpl implements ProjectService {
	
	private final ProjectDao proDao;

	@Override
	public List<ProjectDto> listProject(PageInfoDto pi) {
		return proDao.selectProjectList(pi);
	}

	@Override
	public int addProject(ProjectDto pro) {
		return proDao.addProject(pro);
	}

	@Override
	public int selectProjectCount() {
		return proDao.selectProjectCount();
	}
}
