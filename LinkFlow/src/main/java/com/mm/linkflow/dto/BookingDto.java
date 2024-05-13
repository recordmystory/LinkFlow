package com.mm.linkflow.dto;

import java.sql.Date;

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
public class BookingDto extends CommonDto {
	
	private String bookingNo;
	private String bookingId;
	private String deptCode;
	private String assetsNo;
	private String bkContent;
	private Date bkStartDt;
	private Date bkEndDt;
	private String rejContent;
	private String Status;
}
