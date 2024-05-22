package com.mm.linkflow.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.mm.linkflow.dao.EdsmProgDao;
import com.mm.linkflow.dto.DeptDto;
import com.mm.linkflow.dto.EdocDto;
import com.mm.linkflow.dto.EdocFormDto;
import com.mm.linkflow.dto.EdocHistDto;
import com.mm.linkflow.dto.PageInfoDto;
import com.mm.linkflow.service.service.EdsmProgService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class EdsmProgServiceImpl implements EdsmProgService {
	
	private final EdsmProgDao edsmProgDao;
	

//	@Override
//	public int selectAllListCount() {
//		return 0;
//	}
//
//	@Override
//	public List<EdocDto> selectAllList(PageInfoDto pi) {
//		return null;
//	}

	@Override
	public List<EdocFormDto> selectFormList() {
		return edsmProgDao.selectFormList();
	}

	@Override
	public List<EdocFormDto> selectEdFrContentList(String docType) {
		return edsmProgDao.selectEdFrContentList(docType);
	}

	@Override
	public List<DeptDto> selectApprLine() {
		return edsmProgDao.selectApprLine();
	}

	@Override
	public int insertDoc(EdocDto edocDto) {
		return edsmProgDao.insertDoc(edocDto);
	}



}
