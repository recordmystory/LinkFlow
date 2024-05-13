package com.mm.linkflow.dto;

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
public class EdocHistDto extends CommonDto {
	private String userId; 
	private String edNo; 
	private int edHistOrder; 
	private String edHistSubCode; 
	private String edHistDate; 
	private String edHistComment;  
}
