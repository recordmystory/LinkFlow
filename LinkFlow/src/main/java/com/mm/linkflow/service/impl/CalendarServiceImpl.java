package com.mm.linkflow.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.mm.linkflow.controller.CalendarController;
import com.mm.linkflow.dao.CalenderDao;
import com.mm.linkflow.dto.DeptDto;
import com.mm.linkflow.dto.ScheduleDto;
import com.mm.linkflow.service.service.CalendarService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class CalendarServiceImpl implements CalendarService {
	
	private final CalenderDao calendarDao;

	//캘린더 메인 - 일정 등록
	@Override
	public int insertSch(ScheduleDto schedule) {
		return calendarDao.insertSch(schedule);
	}

	//캘린더 메인 - 일정 전체조회
	@Override
	public List<ScheduleDto> selectSchList(Map<String, Object> sch) {
		return calendarDao.selectSchList(sch);
	}

	//휴지통 - 일정 상세
	@Override
	public ScheduleDto detailSch(String schNo) {
		return calendarDao.detailSch(schNo);
	}

	//캘린더 메인 - 일정 수정
	@Override
	public int updateSch(ScheduleDto schedule) {
		String schNo = schedule.getSchNo();
	    log.debug("schNo: {}", schNo);	    
	    return calendarDao.updateSch(schedule);
	}
	
	//캘린더 메인 - 일정삭제(상태변경)
	@Override
	public int deleteSch(String schNo) {
		return calendarDao.deleteSch(schNo);
	}
	
	//휴지통 - 일정조회
	@Override
	public List<ScheduleDto> selectSchWasteList(String schCalSubCode) {
		log.debug(schCalSubCode);
		return calendarDao.selectSchWasteList(schCalSubCode);
	}
	
	//휴지통 - 일정복구
	@Override
	public int wasteSchRestore(String schNo) {
		return calendarDao.wasteSchRestore(schNo);
	}

	//휴지통 - 30일 뒤 일정 완전 삭제 (스케줄러)
	@Override
	public int wasteSchCompletely() {
		return calendarDao.wasteSchCompletely();	
	}

	//휴지통 - 일정 완전삭제
	@Override
	public int wasteSchRemoval(String schNo) {
		return calendarDao.wasteSchRemoval(schNo);	
		
	}

	//제이트리 조직도 멤버조회
	@Override
	public List<DeptDto> selecteMemberList() {
		return calendarDao.selecteMemberList();	
	}

	/*
	 * @Override public int updateSchCalSubCode(Map<String, Object> map) { return
	 * calendarDao.updateSchCalSubCode(map); }
	 */
	


	
}
