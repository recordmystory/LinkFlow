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

}
