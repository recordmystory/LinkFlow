package com.mm.linkflow.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mm.linkflow.dto.MemberDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class HrDao {
	private final SqlSessionTemplate sql;

	public List<MemberDto> selectMemberList() {
		// TODO Auto-generated method stub
		return sql.selectList("hrMapper.selectMemberList");
	}

	public List<MemberDto> searhMemberList(String keyword) {
		// TODO Auto-generated method stub
		return sql.selectList("hrMapper.selectMemberList",keyword);
	}
	
	
}
