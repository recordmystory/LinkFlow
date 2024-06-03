package com.mm.linkflow.scheduler;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.mm.linkflow.service.impl.BookingServiceImpl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Component
public class BookingRoomScheduler {

	private final BookingServiceImpl bkService;
	
	@Scheduled(cron="0 0,30 10-18 * * MON-FRI")
	public void autoRoomBkEnd() {
		log.debug("돌아가나요");
		bkService.autoRoomBkEnd();
	}
	
	@Scheduled(cron = "0 0 9 * * MON-FRI")
	public void autoCarBkUse() {
		log.debug("돌아가나요?");
		bkService.autoCarBkUse();
	}
}
