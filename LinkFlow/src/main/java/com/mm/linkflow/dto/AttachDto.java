package com.mm.linkflow.dto;

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
public class AttachDto extends CommonDto {
	private int fileNo; 		   // 파일번호
	private int refNo; 			   // 참조번호
	private String refCategory;    // 참조타입
	private String originName;     // 파일 원본명
	private String filesystemName; // 파일 수정명
	private String filePath;       // 파일 경로

}
