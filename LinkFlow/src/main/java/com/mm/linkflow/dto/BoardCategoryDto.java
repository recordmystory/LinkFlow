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
public class BoardCategoryDto extends CommonDto{
	
	private String boardCategory;
	private String categoryName;
	private String deptCode;
	private String categoryType;
}
