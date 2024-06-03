package com.mm.linkflow.scheduler;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.mm.linkflow.service.service.CalendarService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Component
public class CalendarScheduler {
	private final CalendarService calendarService;

	//DEL_YN이 'Y'고 modDate에서 31일째 되는 날 0시에 일정 삭제, 자동실행 
	@Scheduled(cron="0 0 0 * * *")
	public void wasteSchCompletely() {
		int result = calendarService.wasteSchCompletely();
		log.debug("삭제 테스트:{}", result);

	}
}
