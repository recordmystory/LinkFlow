package com.mm.linkflow.scheduler;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.mm.linkflow.service.service.AttemdamceService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Component
public class AttendanceScheduler {
	
	private final AttemdamceService attService;
	
	@Scheduled(cron="0 59 23 * * *")
	public void autoCheckOut() {
		attService.autoCheckOut();
	}
}
