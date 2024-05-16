package com.mm.linkflow.dao;

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

	public int checkPassword(MemberDto m) {
		// TODO Auto-generated method stub
		return sql.selectOne("memberMapper.checkPassword",m);
	}

	public int updatePwd(MemberDto m) {
		// TODO Auto-generated method stub
		return sql.update("memberMapper.updatePwd",m);
	}

	public MemberDto myAttemdamce(String userId) {
		return sql.selectOne("memberMapper.myAttemdamce",userId);
	}



}
