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
@Setter
@Getter
@ToString
public class AttemdamceDto extends CommonDto {
	private  int attNo;
	private String userId;
	private String startDtime;
	private String endDtime;
	private int lateCount; //지각 횟수
	private int absentCount; //결근 횟수
}	

