package com.mm.linkflow.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mm.linkflow.dto.ScheduleDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class CalenderDao {
	private final SqlSessionTemplate sqlSessionTemplate;

	public int insertSch(ScheduleDto schedule) {
		return sqlSessionTemplate.insert("calendarMapper.insertSch", schedule);
	}
}
