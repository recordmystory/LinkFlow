package com.mm.linkflow.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mm.linkflow.dto.MemberDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class GroupDao {
	private final SqlSessionTemplate sql;

	public List<MemberDto> groupList() {
		return sql.selectList("memberMapper.groupList");
	}

	public MemberDto groupinfoMember(String userId) {
		return sql.selectOne("memberMapper.groupinfoMember",userId);
	}
	
	
}
