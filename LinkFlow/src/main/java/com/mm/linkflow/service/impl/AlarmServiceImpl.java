package com.mm.linkflow.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.mm.linkflow.dao.AlarmDao;
import com.mm.linkflow.dto.AlarmDto;
import com.mm.linkflow.service.service.AlarmService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class AlarmServiceImpl implements AlarmService {
	
	private final AlarmDao alarmDao;
	
	@Override
	public List<AlarmDto> selectAlarmList(String userId) {
		return alarmDao.selectAlarmList(userId);
	}

	@Override
	public int insertAlarm(AlarmDto alarm) {
		return alarmDao.insertAlarm(alarm);
	}

	@Override
	public int readAlarm(int alarmNo) {
		return alarmDao.readAlarm(alarmNo);
	}

	@Override
	public int delAlarm(int alarmNo) {
		return alarmDao.delAlarm(alarmNo);
	}

	@Override
	public int selectAlarmNo(String bkNo) {
		return alarmDao.selectAlarmNo(bkNo);
	}

	@Override
	public int allReadAlarm(String userId) {
		return alarmDao.allReadAlarm(userId);
	}

}
