package com.mm.linkflow.service.impl;

import org.springframework.stereotype.Service;

import com.mm.linkflow.dao.EdsmCrTempDao;
import com.mm.linkflow.dto.EdocFormDto;
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

}
