package com.mm.linkflow.dto;

import java.util.List;

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
public class BoardDto extends CommonDto {
	
	private int boardNo;
	private String boardCategory;
	private String boardTitle;
	private String boardContent;
	private int count;
	private String tempSave;
	private String noticeYN;
	private String boardType;
	
	private List<AttachDto> attachList;
}
