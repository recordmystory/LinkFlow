package com.mm.linkflow.service.service;

import java.util.List;
import java.util.Map;

import com.mm.linkflow.dto.CalendarDto;
import com.mm.linkflow.dto.ScheduleDto;

public interface CalendarService {
	//일정등록
	int insertSch(ScheduleDto schedule);
	
	//한 캘린더의 모든 일정 조회
	List<ScheduleDto> selectSchList(String[] schCalSubCode);

	/*
	 * //일정둥록 -calNo조회 String getSelectCalNo(Map<String, String> selectCalNo);
	 */
}
