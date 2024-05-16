package com.mm.linkflow.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class AttemdamceDao {
	private final SqlSessionTemplate sql;
	
	
	// 출근 체크 확인용
	public int selectCheckIn(String userId) {
		return sql.selectOne("attemdamceDaoMapper.selectCheckIn", userId);
	}
	
	// 출근 insert 용
	public int checkInAtt(String userId) {
		return sql.insert("attemdamceDaoMapper.checkInAtt", userId);
	}
	
}
