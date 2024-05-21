package com.mm.linkflow.service.service;

import java.util.List;

import com.mm.linkflow.dto.CommonTableDto;
import com.mm.linkflow.dto.DeptDto;
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
	//구성원 조회 
	MemberDto selectDatailMember(String id);
	//구성원 정보 변경
	int updateInfoMember(MemberDto m);
	//비밀번호 초기화 로직
	int resetPasswoard(MemberDto m);
	//퇴사 처리하는 로직 
	int goRetire(MemberDto m);
	//재직 처리하는 로직 
	int goJoinPathy(MemberDto m);
	
	//조직 추가 
	
	//조직 변경 
	
	//아이디 중복확인 
	int checkId(String checkId);
	
	//구성원 추가 및 수정에 직급 부서 종류 
	List<DeptDto> selectDeftList();
	List<CommonTableDto> selectCommonTableList();
}
