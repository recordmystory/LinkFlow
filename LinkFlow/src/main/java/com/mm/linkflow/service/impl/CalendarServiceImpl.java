package com.mm.linkflow.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.mm.linkflow.controller.CalendarController;
import com.mm.linkflow.dao.CalenderDao;
import com.mm.linkflow.dto.DeptDto;
import com.mm.linkflow.dto.ScheduleDto;
import com.mm.linkflow.dto.ShaSchDto;
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
	public int insertSch(ScheduleDto schedule, String userId, List<String> shareIds){
		// 일정 등록
	    int result1 = calendarDao.insertSch(schedule);
	    int result2 = 1;
	    if (shareIds != null) {
	    	result2 = 0;
		    // 일정 공유
	        for (String shareId : shareIds) {
	        	result2 += calendarDao.insertSharedSch(shareId, userId);
	        }
	    }
	    return result1 * result2; 
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

	//캘린더 메인 - 일정 수정, 공유일정 수정
	@Override 
	public int updateSch(Map<String, String> data, String[] shareIds) { 
		int result1 = calendarDao.updateSch(data);
	    int result2 = 1;
	    if (shareIds != null) {
	    	result2 = 0;
		    // 일정 수정
	        for (String shareId : shareIds) {
	        	//공유캘린더 dto에 set으로 shareId넣어서 해보기
	        	ShaSchDto shaDto = new ShaSchDto();
	        	shaDto.setShareId(shareId);
	        	result2 += calendarDao.updateSharedSch(data);
	        }
	    }
	    return result1 * result2; 
	}
	 
	
	//캘린더 메인 - 일정삭제(상태변경)
	@Override
	public int deleteSch(String schNo) {
		 int result1 = calendarDao.deleteSch(schNo);
		  // 일정 공유 삭제 
		 int result2 = calendarDao.deleteShareSch(schNo);
		 if(result2 <= 0) {
			 result2 = 1;
		   return result1 * result2; 

		 }	
		 return result1 * result2; 
		  

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
		 int result1 = calendarDao.wasteSchRestore(schNo);
		  // 일정 공유 복구
		 int result2 = calendarDao.wasteShareRestore(schNo);
		 if(result2 <= 0) {
			 result2 = 1;
		   return result1 * result2; 

		 }	
		 return result1 * result2; 
	}

	//휴지통 - 30일 뒤 일정 완전 삭제 (스케줄러)
	@Override
	public int wasteSchCompletely() {
		return calendarDao.wasteSchCompletely();	
	}

	//휴지통 - 일정 완전삭제
	@Override
	public int wasteSchRemoval(String schNo) {
        
        // 부모 
        int result2 = calendarDao.deleteSchWaste(schNo);
        //자식        
        int result1 = calendarDao.wasteShareRemoval(schNo);

        if(result1 <= 0) {
        	result1 = 1;
        	return result1 * result2;
        }
    	return result1 * result2;
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
