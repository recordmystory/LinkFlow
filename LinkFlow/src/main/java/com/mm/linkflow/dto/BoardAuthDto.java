package com.mm.linkflow.dto;

import java.util.ArrayList;

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
public class BoardAuthDto extends CommonDto {
	private String userId;
	private String boardCategory;
	private String readYN;
	private String writeYN;
	
	private String userName;
	private String subName;
	private String deptTitle;
	private String boardRight;
	
	private ArrayList<BoardAuthDto> authList;
}
