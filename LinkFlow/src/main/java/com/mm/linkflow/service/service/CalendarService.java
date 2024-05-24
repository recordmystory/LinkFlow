package com.mm.linkflow.service.service;

import java.util.List;
import java.util.Map;

import com.mm.linkflow.dto.CalendarDto;
import com.mm.linkflow.dto.ScheduleDto;

public interface CalendarService {
	//캘린더 메인 - 일정 등록
	int insertSch(ScheduleDto schedule);
	
	//캘린더 메인 - 일정 전체조회
	List<ScheduleDto> selectSchList(Map<String, Object> sch);
	
	//휴지통 - 일정 상세
	ScheduleDto detailSch(String schNo);
	
	//캘린더 메인 - 일정 수정
	int updateSch(ScheduleDto schedule);
	/*
	 * //수정 - 캘린더 CAL_SUB_CODE int updateSchCalSubCode(Map<String, Object> map);
	 */
	//캘린더 메인 - 일정삭제(상태변경)
	int deleteSch(String schNo);

}
  