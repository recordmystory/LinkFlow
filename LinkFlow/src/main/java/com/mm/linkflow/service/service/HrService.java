package com.mm.linkflow.service.service;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.mm.linkflow.dto.BoardCategoryDto;
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
	int insertDept(DeptDto d);
	int insertCategory(BoardCategoryDto bd);
	//조직 변경 
	int updateDeptTable(DeptDto d);
	int updateDept(BoardCategoryDto bd);
	
	//조직 삭제 
	int deleteDept(BoardCategoryDto bd);
	int DeleteDeptTable(DeptDto d);
	
	//아이디 중복확인 
	int checkId(String checkId);
	//부서 코드 중복확인 
	int checkCode(String deptCode);
	
	//구성원 추가 및 수정에 직급 부서 종류 
	List<DeptDto> selectDeftList();
	List<CommonTableDto> selectCommonTableList();
	
	// JS트리용 조직도 조회하는 서비스 -구성모
	List<DeptDto> selectApprLine();
	
}
