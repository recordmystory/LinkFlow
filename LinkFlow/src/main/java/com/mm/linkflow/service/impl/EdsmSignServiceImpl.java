package com.mm.linkflow.service.impl;

import org.springframework.stereotype.Service;

import com.mm.linkflow.dao.EdsmSignDao;
import com.mm.linkflow.dto.MemberDto;
import com.mm.linkflow.service.service.EdsmSignService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class EdsmSignServiceImpl implements EdsmSignService {
	
	private final EdsmSignDao edsmSignDao;
	
	@Override
	public int uploadSignImg(MemberDto m) {
		return edsmSignDao.uploadSignImg(m);
	}

}
