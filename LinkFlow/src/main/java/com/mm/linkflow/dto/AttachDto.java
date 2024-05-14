package com.mm.linkflow.dto;

import java.sql.Date;

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
	private int fileNo; 		   // 파일번호
	private int refNo; 			   // 참조번호
	private String refCategory;    // 참조타입
	private String originName;     // 파일 원본명
	private String filesystemName; // 파일 수정명
	private String filePath;       // 파일 경로

	// 첨부파일 인서트시 필요한 매개변수 생성자 - 황민우
	public AttachDto(String regId, String modId, int refNo, String refCategory, String originName, String filesystemName, String filePath) {
		super(regId, modId);
		this.refNo = refNo;
		this.refCategory = refCategory;
		this.originName = originName;
		this.filesystemName = filesystemName;
		this.filePath = filePath;
	}

	// 첨부파일 조회시 필요한 매개변수 생성자 - 황민우
	public AttachDto(int refNo, String refCategory) {
		super();
		this.refNo = refNo;
		this.refCategory = refCategory;
	}
	
	

	
}
