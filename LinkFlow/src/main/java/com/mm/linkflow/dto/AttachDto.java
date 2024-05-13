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
public class AttachDto extends CommonDto {
	private int fileNo;
	private int refNo;
	private String refCategory;
	private String originName;
	private String filesystemName;
	private String filePath;
}
