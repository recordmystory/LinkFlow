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
public class ProjectDto extends CommonDto {
	private int proNo;
	private String deptCode;
	private String proTitle;
	private String client;
	private String address;
	private String detailAdd;
	private String startDate;
	private String endDate;
	private String proYn;
	private String deptName;
}
