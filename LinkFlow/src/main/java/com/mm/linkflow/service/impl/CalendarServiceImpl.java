package com.mm.linkflow.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.mm.linkflow.dao.CalenderDao;
import com.mm.linkflow.dto.ScheduleDto;
import com.mm.linkflow.service.service.CalendarService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CalendarServiceImpl implements CalendarService {
	
	private final CalenderDao calendarDao;

	//일정 등록
	@Override
	public int insertSch(ScheduleDto schedule) {
		return calendarDao.insertSch(schedule);
	}

	@Override
	public List<ScheduleDto> selectSchList(String calNo) {
		return null;
		//return calendarDao.selectSchList();

	}

	
}
