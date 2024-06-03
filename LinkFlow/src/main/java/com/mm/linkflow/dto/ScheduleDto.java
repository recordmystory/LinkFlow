package com.mm.linkflow.dto;

import java.util.List;

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
public class ScheduleDto extends CommonDto{
	private String schNo;
	private String calNo;
	private String schContent;
	private String startDate;
	private String endDate;
	private String address;
	private String notifyYn;
	private String schImport;
	private String calColor;
	private String schTitle;
	private String schCalSubCode; 
	private String modId; 
	private List<String> shareIds;
}
