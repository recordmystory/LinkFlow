package com.mm.linkflow.service.service;

import com.mm.linkflow.dto.AttemdamceDto;

public interface AttemdamceService {
	
	//나의 근태를 확인
	AttemdamceDto myAttemdamce(AttemdamceDto att);
	
	// 출근 체크 확인용
	int selectCheckIn(String userId);
	
	// 출근 insert 용
	int checkInAtt(String userId);
}
