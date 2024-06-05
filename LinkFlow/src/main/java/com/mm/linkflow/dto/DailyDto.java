package com.mm.linkflow.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString
public class DailyDto extends CommonDto {
	private int daiNo;
	private int proNo;
	private String daiContent;
	private String daiAns;
	private String ansDate;
	private String ansWriter;
	private String proTitle;
	private String userName;
	private String deptCode;
	private String client;
}
