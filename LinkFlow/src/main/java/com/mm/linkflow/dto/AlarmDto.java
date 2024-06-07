package com.mm.linkflow.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.SuperBuilder;

@SuperBuilder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class AlarmDto extends CommonDto{

	private int alarmNo;
	private String userId;
	private String alarmCode;
	private String checkYN;
	private String alarmTitle;
	private String alarmURL;
	private String bookingNo;
	private String alarmDate;
	private String supName;
}
