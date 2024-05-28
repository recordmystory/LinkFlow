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
public class DispatchDto extends CommonDto {
	private int proNo;
	private String userId;
	private String role;
	private String task;
	private String startDate;
	private String endDate;
	private String disYn;
	private String userName;
	private String proTitle;
	private String client;
	private String deptTitle;
}
