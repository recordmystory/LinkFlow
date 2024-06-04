package com.mm.linkflow.service.service;

import java.util.List;

import com.mm.linkflow.dto.AlarmDto;

public interface AlarmService {
	
	List<AlarmDto> selectAlarmList(String userId);

	int insertAlarm(AlarmDto alarm);
	
	int readAlarm(int alarmNo);
	
	int delAlarm(int alarmNo);
	
	int selectAlarmNo(String bkNo);
	
	int allReadAlarm(String userId);
}
