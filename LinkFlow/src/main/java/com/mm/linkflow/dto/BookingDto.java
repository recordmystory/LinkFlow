package com.mm.linkflow.dto;

import java.sql.Date;

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
public class BookingDto extends CommonDto {
	
	private String bookingNo;
	private String bookingId;
	private String userName;
	private String deptCode;
	private String assetsNo;
	private String bkContent;
	private String bkStartTime; // 시작 시간
	private String bkEndTime; // 끝 시간
	private String bkStartDate; // 시작 날짜
	private String bkEndDate; // 끝 날짜
	private String rejContent;
	private String status;
	private String assetsName;
	private String mainName;
	private String subName;
	private String enrDate;
	private String deptName;
}
