package com.mm.linkflow.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.mm.linkflow.dao.ProjectDao;
import com.mm.linkflow.dto.DailyDto;
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

	@Override
	public void modifyDispatch(DispatchDto dis) {
		proDao.modifyDispatch(dis);
	}

	@Override
	public int deleteDispatch(DispatchDto dis) {
		return proDao.deleteDispatch(dis);
	}

	@Override
	public void modifyProject(ProjectDto pro) {
		proDao.modifyProject(pro);
	}

	@Override
	public void deleteProject(int proNo) {
		proDao.deleteProject(proNo);
	}

	@Override
	public List<DispatchDto> listDispatch(PageInfoDto pi) {
		return proDao.listDispatch(pi);
	}

	@Override
	public int listDispatchCount() {
		return proDao.listDispatchCount();
	}

	@Override
	public int searchDispatchCount(Map<String, String> search) {
		return proDao.searchDispatchCount(search);
	}

	@Override
	public List<DispatchDto> searchDispatchList(Map<String, String> search, PageInfoDto pi) {
		return proDao.searchDispatchList(search, pi);
	}

	@Override
	public List<DispatchDto> myDispatchList(String userId, PageInfoDto pi) {
		return proDao.myDispatchList(userId, pi);
	}

	@Override
	public int myDispatchCount(String userId) {
		return proDao.myDispatchCount(userId);
	}

	@Override
	public void deleteProjectDispatch(int proNo) {
		proDao.deleteProjectDispatch(proNo);
	}

	/*
	@Override
	public int projectPmCount(String userId) {
		return proDao.projectPmCount(userId);
	}
	*/

	@Override
	public List<DailyDto> dailyList(String userId, PageInfoDto pi) {
		return proDao.dailyList(userId, pi);
	}

	@Override
	public int dailyCount(String userId) {
		return proDao.dailyCount(userId);
	}

	@Override
	public void addDaily(DailyDto dai) {
		proDao.addDaily(dai);
	}

	@Override
	public List<DispatchDto> dailyProjectList(String userId) {
		return proDao.dailyProjectList(userId);
	}

	@Override
	public DailyDto detailDaily(int daiNo) {
		return proDao.detailDaily(daiNo);
	}

	@Override
	public void modifyDaily(DailyDto dai) {
		proDao.modifyDaily(dai);
	}

	@Override
	public void deleteDaily(int daiNo) {
		proDao.deleteDaily(daiNo);
	}

	@Override
	public List<DailyDto> searchDaily(Map<String, String> search, PageInfoDto pi) {
		return proDao.searchDaily(search, pi);
	}

	@Override
	public int searchDailyCount(Map<String, String> search) {
		return proDao.searchDailyCount(search);
	}

	@Override
	public int dailyCheck(DailyDto dai) {
		return proDao.dailyCheck(dai);
	}

	@Override
	public List<DailyDto> listDailyLead(PageInfoDto pi, Map<String, String> map) {
		return proDao.listDailyLead(pi, map);
	}

	@Override
	public int listDailyLeadCount(Map<String, String> map) {
		return proDao.listDailyLeadCount(map);
	}

	@Override
	public List<DailyDto> searchDailyLead(Map<String, String> search, PageInfoDto pi) {
		return proDao.searchDailyLead(search, pi);
	}

	@Override
	public int searchDailyLeadCount(Map<String, String> search) {
		return proDao.searchDailyLeadCount(search);
	}

	@Override
	public void modifyDailyLead(DailyDto dai) {
		proDao.modifyDailyLead(dai);
	}
}
