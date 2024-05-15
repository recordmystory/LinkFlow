package com.mm.linkflow.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.mm.linkflow.dao.EdsmCrTempDao;
import com.mm.linkflow.dto.EdocFormDto;
import com.mm.linkflow.dto.PageInfoDto;
import com.mm.linkflow.service.service.EdsmCrTempService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class EdsmCrTempImpl implements EdsmCrTempService {
	
	private final EdsmCrTempDao edsmCrTempDao;
	
	@Override
	public int insertForm(EdocFormDto edsmForm) {
		return edsmCrTempDao.insertForm(edsmForm);
	}

	@Override
	public int selectCrTempListCnt() {
		return edsmCrTempDao.selectCrTempListCnt();
	}

	@Override
	public List<EdocFormDto> selectCrTempList(PageInfoDto pi) {
		return edsmCrTempDao.selectCrTempList(pi);
	}

}
