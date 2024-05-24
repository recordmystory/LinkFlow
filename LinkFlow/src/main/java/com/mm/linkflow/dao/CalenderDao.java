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

	//캘린더 메인 - 일정 등록
	public int insertSch(ScheduleDto schedule) {
		return sqlSessionTemplate.insert("calendarMapper.insertSch", schedule);
	}
	
	//캘린더 메인 - 일정 전체조회
	public List<ScheduleDto> selectSchList(Map<String, Object> sch) {
        return sqlSessionTemplate.selectList("calendarMapper.selectScheduleList", sch);
	}

	//휴지통 - 일정 상세조회
	public ScheduleDto detailSch(String schNo) {
		return sqlSessionTemplate.selectOne("calendarMapper.detailSch", schNo);
	}

	//캘린더 메인 - 일정 수정
	public int updateSch(ScheduleDto schedule) {
	    return sqlSessionTemplate.update("calendarMapper.updateSch", schedule);

	}
	//캘린더 메인 - 일정 삭제(상태변경)
	public int deleteSch(String schNo) {
		return sqlSessionTemplate.update("calendarMapper.deleteSch", schNo);
	}

	/*
	 * public int updateSchCalSubCode(Map<String, Object> map) { return
	 * sqlSessionTemplate.update("calendarMapper.updateCalendarSubCode", map); }
	 */
}
