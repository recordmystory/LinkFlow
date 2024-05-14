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
public class DispatchDto {
	private int proNo;
	private String userId;
	private String role;
	private String task;
	private Date startDate;
	private Date endDate;
	private String disYn;
}
