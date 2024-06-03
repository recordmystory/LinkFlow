package com.mm.linkflow.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

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

    // 캘린더 메인 - 일정 등록
    @Override
    public int insertSch(ScheduleDto schedule, String userId, List<String> shareIds) {
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

    // 캘린더 메인 - 일정 전체 조회
    @Override
    public List<ScheduleDto> selectSchList(Map<String, Object> sch) {
    	return calendarDao.selectSchList(sch);
    }

    // 휴지통 - 일정 상세
    @Override
    public ScheduleDto detailSch(String schNo) {
        return calendarDao.detailSch(schNo);
    }

    // 캘린더 메인 - 일정 삭제(상태변경)
    @Override
    public int deleteSch(String schNo) {
        int result1 = calendarDao.deleteSch(schNo);
        // 일정 공유 삭제
        int result2 = calendarDao.deleteShareSch(schNo);
        if (result2 <= 0) {
            result2 = 1;
        }
        return result1 * result2;
    }

    // 휴지통 - 일정 조회
    @Override
    public List<ScheduleDto> selectSchWasteList(String schCalSubCode, String userId) {
        return calendarDao.selectSchWasteList(schCalSubCode, userId);
    }

    // 휴지통 - 일정 복구
    @Override
    public int wasteSchRestore(String schNo) {
        int result1 = calendarDao.wasteSchRestore(schNo);
        // 일정 공유 복구
        int result2 = calendarDao.wasteShareRestore(schNo);
        if (result2 <= 0) {
            result2 = 1;
        }
        return result1 * result2;
    }

    // 휴지통 - 30일 뒤 일정 완전 삭제 (스케줄러)
    @Override
    public int wasteSchCompletely() {
        int result1 = calendarDao.wasteSchCompletely();
        int result2 = 1;
        int result = result1 * result2;
        // 공유 일정 완전 삭제
        if (result1 <= 0) {
            result1 = 1;
            result2 = calendarDao.shareSchCompletely();
            log.debug("공유 일정 삭제 성공{}", result2);
            return result;
        }
        log.debug("일정 삭제 성공:{}", result1);
        return result;
    }

    // 휴지통 - 일정 완전 삭제
    @Override
    public int wasteSchRemoval(String schNo) {
        // 자식
        int result1 = calendarDao.wasteShareRemoval(schNo);
        if (result1 > 0) {
            // 부모
            int result2 = calendarDao.deleteSchWaste(schNo);
            return result1 * result2;
        } else {
            result1 = 1;
            int result2 = calendarDao.deleteSchWaste(schNo);
            return result1 * result2;
        }
    }

    // 제이트리 조직도 멤버 조회
    @Override
    public List<DeptDto> selecteMemberList() {
        return calendarDao.selecteMemberList();
    }

    // 캘린더 메인 - 일정 수정, 공유 일정 수정
    @Override
    public int updateSchedule(ScheduleDto data, String userId, List<String> shareIds) {
        int result1 = calendarDao.updateSch(data);
        String schNo = data.getSchNo();

        int result2 = 1;
        if (shareIds != null && !shareIds.isEmpty()) {
        	result2 = 0;
            for (String shareId : shareIds) {
                int sharedSch = calendarDao.checkSharedSch(schNo, shareId);
                if (sharedSch > 0) { // 이미 공유 받은 경우 수정
                    result2 += calendarDao.updateSharedSch(userId, shareId, schNo); // 공유 일정 수정
                } else {
                    result2 += calendarDao.insertShared(userId, shareId, schNo); // 공유 일정 추가
                }
            }
        }
        return result1 * result2;
    }
}