package com.mm.linkflow.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mm.linkflow.dto.MemberDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class MemberDao {
	private final SqlSessionTemplate sqlSession;
	
	public MemberDto loginMember(MemberDto m) {
		
		return sqlSession.selectOne("memberMapper.loginMember",m);
	}
}
