package com.mm.linkflow.service.service;

import com.mm.linkflow.dto.AttemdamceDto;

public interface AttemdamceService {
	
	//나의 근태를 확인
	AttemdamceDto myAttemdamce(AttemdamceDto att);
}
