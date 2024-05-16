package com.mm.linkflow.service.service;



import java.util.List;

import com.mm.linkflow.dto.MemberDto;

public interface MemberService {
	
		//로그인용 서비스 
	   MemberDto loginMember(MemberDto m);
	   
	   //마이페이지 정보 수정용 서비스 	   
	   int updateMember(MemberDto m);
	   
	   //마이페이지 암호변경전 암호 확인하는 서비스 
	   int checkPassword(MemberDto m);
	   
	   //마이페이지 암호 변경하는 서비스 
	   int updatePwd(MemberDto m);
	   
	   //올해,이번달 근무 상황 조회 하는 서비스 
	   MemberDto myAttemdamce(String userId);
	   
	   //사원 연차 사용 검색 조회 서비스
	   List<MemberDto> searchDayoff(MemberDto m);
	
	   
}
