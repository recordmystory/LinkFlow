package com.mm.linkflow.service.service;

import java.util.List;

import com.mm.linkflow.dto.MemberDto;

public interface HrService {
	//구성원 리스트 조회 
	List<MemberDto> selectMemberList();
	//구성원 검색 조회 
	List<MemberDto> searhMemberList(String keyword);
	//구성원 추가 
	int insertMember(MemberDto m);
	//구성원 변경 
	int modiflyMember(MemberDto m);
	//조직 추가 
	
	//조직 변경 
}
