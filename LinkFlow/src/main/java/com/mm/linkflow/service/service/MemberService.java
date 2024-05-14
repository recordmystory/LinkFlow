package com.mm.linkflow.service.service;

import org.springframework.web.multipart.MultipartFile;

import com.mm.linkflow.dto.MemberDto;

public interface MemberService {
	
		//로그인용 서비스 
	   MemberDto loginMember(MemberDto m);
	   
	 
	   
	   //마이페이지 정보 수정용 서비스 
	   
	   int updateMember(MemberDto m);
	   
	 ;
}
