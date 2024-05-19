package com.mm.linkflow.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.mm.linkflow.controller.CalendarController;
import com.mm.linkflow.dao.CalenderDao;
import com.mm.linkflow.dto.ScheduleDto;
import com.mm.linkflow.service.service.CalendarService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class CalendarServiceImpl implements CalendarService {
	
	private final CalenderDao calendarDao;

	//일정 등록
	@Override
	public int insertSch(ScheduleDto schedule) {
		return calendarDao.insertSch(schedule);
	}

	/*
	 * //일정 등록 - 아이디와 서브코드로 calNo조회
	 * 
	 * @Override public String getSelectCalNo(Map<String, String> selectCalNo) {
	 * return calendarDao.getSelectCalNo(selectCalNo); }
	 */

	//특정 캘린더 일정 전체 조회
	@Override
	public List<ScheduleDto> selectSchList(String schCalSubCode) {
		return calendarDao.selectSchList(schCalSubCode);
	}

	//일정 상세조회 
	@Override
	public ScheduleDto detailSch(String schNo) {
		return calendarDao.detailSch(schNo);
	}

	//일정수정
	@Override
	public int updateSch(ScheduleDto schedule) {
		String schNo = schedule.getSchNo();
	    log.debug("schNo: {}", schNo);	    
	    return calendarDao.updateSch(schedule);
	}
	


	
}
