package com.mm.linkflow.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@ToString
@Builder
public class CommonDto {
	
	private Date regDate;
	private Date modDate;
	private String regId;
	private String modId;
	private String delYN;
	
	
	
	// 첨부파일 인서트시 필요한 매개변수 생성자 - 황민우
	public CommonDto(String regId, String modId) {
		super();
		this.regId = regId;
		this.modId = modId;
	}

	
}
