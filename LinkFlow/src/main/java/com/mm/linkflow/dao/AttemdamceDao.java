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
	
	// 퇴근 체크 확인용
	public int selectCheckOut(String userId) {
		return sql.selectOne("attemdamceDaoMapper.selectCheckOut", userId);
				
	}
	
	// 퇴근 시간 가져오기 용
	public String selectCheckOutTime(String userId) {
		return sql.selectOne("attemdamceDaoMapper.selectCheckOutTime", userId);
	}
	
	// 퇴근 update 용
	public int checkOutAtt(String userId) {
		return sql.update("attemdamceDaoMapper.checkOutAtt", userId);
	}
	
	// 퇴근 자동 update 용
	
	public int autoCheckOut() {
		return sql.update("attemdamceDaoMapper.autoCheckOut");
	}
	
}
