package com.mm.linkflow.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mm.linkflow.dto.ScheduleDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class CalenderDao {
	private final SqlSessionTemplate sqlSessionTemplate;

	//일정등록
	public int insertSch(ScheduleDto schedule) {
		return sqlSessionTemplate.insert("calendarMapper.insertSch", schedule);
	}

	/*
	 * //일정 등록 - 아이디와 서브코드로 calNo조회 public String getSelectCalNo(Map<String, String>
	 * selectCalNo) { return
	 * sqlSessionTemplate.selectOne("calendarMapper.getSelectCalNo", selectCalNo); }
	 */  
	
	//특정 캘린더 전체 일정 조회 
	public List<ScheduleDto> selectSchList(String schCalSubCode) {
        return sqlSessionTemplate.selectList("calendarMapper.selectScheduleList", schCalSubCode);
	}
}
