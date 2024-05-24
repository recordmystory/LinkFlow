package com.mm.linkflow.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.SuperBuilder;

@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString
public class EdocHistDto extends CommonDto {
	private String userId; 
	private String edNo; 
	private int edHistOrder; 
	private String edHistSubCode; 
	private String edHistDate; 
	private String edHistComment;  
	private String edFormCode;
	
	// 진행중인 문서 상세 페이지에서 조회할 쿼리
	private String userName;
	private String signUrl;
	
	
	private List<EdocFormDto> edocFormList;
	
}
