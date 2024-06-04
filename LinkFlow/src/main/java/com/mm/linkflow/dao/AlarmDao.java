package com.mm.linkflow.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mm.linkflow.dto.AlarmDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class AlarmDao {

	private final SqlSessionTemplate sql;

	public List<AlarmDto> selectAlarmList(String userId) {
		return sql.selectList("alarmMapper.selectAlarmList",userId);
	}

	public int insertAlarm(AlarmDto alarm) {
		return sql.insert("alarmMapper.insertAlarm",alarm);
	}

	public int readAlarm(int alarmNo) {
		return sql.update("alarmMapper.readAlarm",alarmNo);
	}

	public int delAlarm(int alarmNo) {
		return sql.update("alarmMapper.delAlarm",alarmNo);
	}

	public int selectAlarmNo(String bkNo) {
		return sql.selectOne("alarmMapper.selectAlarmNo",bkNo);
	}

	public int allReadAlarm(String userId) {
		return sql.update("alarmMapper.allReadAlarm",userId);
	}
	
	
	
}
