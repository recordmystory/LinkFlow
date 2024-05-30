package com.mm.linkflow.service.service;

import java.util.List;
import java.util.Map;

import com.mm.linkflow.dto.CalendarDto;
import com.mm.linkflow.dto.DeptDto;
import com.mm.linkflow.dto.ScheduleDto;
import com.mm.linkflow.dto.ShaSchDto;

public interface CalendarService {
	//캘린더 메인 - 일정 등록
	int insertSch(ScheduleDto schedule);
	
	//캘린더 메인 - 일정 전체조회
	List<ScheduleDto> selectSchList(Map<String, Object> sch);
	
	//휴지통 - 일정 상세
	ScheduleDto detailSch(String schNo);
	
	//캘린더 메인 - 일정 수정
	int updateSch(Map<String, Object> sch);
	/*
	 * //수정 - 캘린더 CAL_SUB_CODE int updateSchCalSubCode(Map<String, Object> map);
	 */
	//캘린더 메인 - 일정삭제(상태변경)
	int deleteSch(String schNo);

	//휴지통 - 일정 전체조회
	List<ScheduleDto> selectSchWasteList(String schCalSubCode);

	//휴지통 - 일정 복구 
	int wasteSchRestore(String schNo);

	//휴지통- 30일 뒤 일정 완전삭제(스케줄러)
	int wasteSchCompletely();

	//휴지통- 일정완전삭제
	int wasteSchRemoval(String schNo);

    //제이트리 조직도 멤버조회
	List<DeptDto> selecteMemberList();

	//공유일정
	int insertSharedSch(String shareId, String userId);


}
  