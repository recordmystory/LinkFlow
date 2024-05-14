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
public class EdocDto extends CommonDto {
	private String edNo;
	private String edFormCode;
	private String edTitle;
	private String edContent;
	private int presDate;
	private String secCode;
	private String status;
	
	private List<EdocHistDto> edocHistList;
}
