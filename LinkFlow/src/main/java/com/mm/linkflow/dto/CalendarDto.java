package com.mm.linkflow.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class CalendarDto extends CommonDto{
	private String calNo;
	private String deptCode;
	private String calSubCode;
	private String calColor;

    private List<ScheduleDto> schedules;

}
