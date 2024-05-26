package com.mm.linkflow.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.mm.linkflow.dto.MemberDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class MemberDao {
	private final SqlSessionTemplate sql;
	
	public MemberDto loginMember(MemberDto m) {
		
		return sql.selectOne("memberMapper.loginMember",m);
	}
	
	public int updateMember(MemberDto m) {
		return sql.update("memberMapper.updateMember",m);
	}



	public int updatePwd(MemberDto m) {
		// TODO Auto-generated method stub
		return sql.update("memberMapper.updatePwd",m);
	}

	public MemberDto myAttemdamce(String userId) {
		return sql.selectOne("memberMapper.myAttemdamce",userId);
	}

	public List<MemberDto> searchDayoff(MemberDto m) {
		return sql.selectList("memberMapper.searchDayoff",m);
	}

	public int updatInfoeMember(MemberDto m) {
		// TODO Auto-generated method stub
		return sql.update("memberMapper.updateInfoMember",m);
	}

	public int deleteProfill(MemberDto m) {
		// TODO Auto-generated method stub
		return sql.update("memberMapper.deleteProfill",m);
	}

	public String SerchPwd(String userId) {
		// TODO Auto-generated method stub
		return sql.selectOne("memberMapper.SerchPwd",userId);
	}
	
	// 남자 사원수 조회용 - 황민우
	public int selectMale() {
		return sql.selectOne("memberMapper.selectMale");
	}
	// 여자 사원수 조회용 - 황민우
	public int selectFemale() {
		return sql.selectOne("memberMapper.selectFemale");
	}
	// 전체 사원수 조회용 - 황민우
	public int selectAllMember(String date) {
		return sql.selectOne("memberMapper.selectAllMember", date);
	}
	// 입사자 조회용 - 황민우
	public int selectHireMember(String date) {
		return sql.selectOne("memberMapper.selectHireMember", date);
	}
	// 퇴사자 조회용 - 황민우
	public int selectRetireMember(String date) {
		return sql.selectOne("memberMapper.selectRetireMember", date);
	}
	// 팀별 인원 조회용 - 황민우
	public List<MemberDto> selectTeamMember(String title){
		return sql.selectList("memberMapper.selectTeamMember", title);
	}
	
	// 카테고리마스터 조회용 - 구성모
	public MemberDto selectCategoryMaster(String boardType) {
		return sql.selectOne("memberMapper.selectCategoryMaster", boardType);
	}
	
	// 메일수신때 유저있는지 체크용 - 구성모
	public int selectCheckUser(String[] email) {
		return sql.selectOne("memberMapper.selectCheckUser", email);
	}



}
