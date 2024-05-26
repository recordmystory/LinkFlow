package com.mm.linkflow.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.mm.linkflow.dao.ProjectDao;
import com.mm.linkflow.dto.DispatchDto;
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

	@Override
	public List<ProjectDto> searchListProject(Map<String, String> search, PageInfoDto pi) {
		return proDao.searchListProject(search, pi);
	}

	@Override
	public int searchProjectCount(Map<String, String> search) {
		return proDao.searchProjectCount(search);
	}

	@Override
	public ProjectDto selectDetailProject(int no) {
		return proDao.selectDetailProject(no);
	}

	@Override
	public List<DispatchDto> selectProjectDispatch(int no) {
		return proDao.selectProjectDispatch(no);
	}

	@Override
	public void addDispatch(DispatchDto dis) {
		proDao.addDispatch(dis);
	}

	@Override
	public int checkDispatch(DispatchDto dis) {
		return proDao.checkDispatch(dis);
	}
}
