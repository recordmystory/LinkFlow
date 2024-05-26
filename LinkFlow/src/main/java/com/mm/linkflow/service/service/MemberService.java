package com.mm.linkflow.service.service;



import java.util.List;

import com.mm.linkflow.dto.MemberDto;

public interface MemberService {
	
		//로그인용 서비스 
	   MemberDto loginMember(MemberDto m);
	   
	   //마이페이지 정보 수정용 서비스 	   
	   int updateMember(MemberDto m);
	   
	  
	   
	   //마이페이지 암호 변경하는 서비스 
	   int updatePwd(MemberDto m);
	   
	   //올해,이번달 근무 상황 조회 하는 서비스 
	   MemberDto myAttemdamce(String userId);
	   
	   //사원 연차 사용 검색 조회 서비스
	   List<MemberDto> searchDayoff(MemberDto m);
	   
	   //마이페이지 정보만 업데이트하는 서비스 
	   int updatInfoeMember(MemberDto m);
	   
	   //프로필 이미지 삭제 서비스 
	   int deleteProfill(MemberDto m);
	   
	   String SerchPwd(String userId);
	   
	   // 남자 사원수 조회용 - 황민우
	   int selectMale();
	   // 여자 사원수 조회용 - 황민우
	   int selectFemale();
	   // 전체 사원수 조회용 - 황민우
	   int selectAllMember(String date);
	   // 입사자 조회용 - 황민우
	   int selectHireMember(String date);
	   // 퇴사자 조회용 - 황민우
	   int selectRetireMember(String date);
	   // 팀별 인원 조회용 - 황민우
	   List<MemberDto> selectTeamMember(String title);

	   // 카테고리마스터조회용 - 구성모
	   MemberDto selectCategoryMaster(String boardType);
	   // 메일수신할때 유저있는지 체크용 - 구성모
	   int selectCheckUser(String[] email);
}
