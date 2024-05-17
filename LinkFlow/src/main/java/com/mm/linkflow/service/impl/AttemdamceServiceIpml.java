package com.mm.linkflow.service.impl;

import org.springframework.stereotype.Service;

import com.mm.linkflow.dao.AttemdamceDao;
import com.mm.linkflow.dto.AttemdamceDto;
import com.mm.linkflow.service.service.AttemdamceService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class AttemdamceServiceIpml implements AttemdamceService {
	
	private final AttemdamceDao attDao;
	@Override
	public AttemdamceDto myAttemdamce(AttemdamceDto att) {
		
		return null;
	}
	
	@Override
	public int selectCheckIn(String userId) {
		return attDao.selectCheckIn(userId);
	}
	
	@Override
	public int checkInAtt(String userId) {
		return attDao.checkInAtt(userId);
	}

	@Override
	public int checkOutAtt(String userId) {
		return attDao.checkOutAtt(userId);
	}

	@Override
	public int selectCheckOut(String userId) {
		return attDao.selectCheckOut(userId);
	}

	@Override
	public int autoCheckOut() {
		return attDao.autoCheckOut();
	}

	@Override
	public String selectCheckOutTime(String userId) {
		return attDao.selectCheckOutTime(userId);
	}

}
