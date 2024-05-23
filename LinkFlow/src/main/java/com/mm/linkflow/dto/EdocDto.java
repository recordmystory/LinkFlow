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
public class EdocDto extends CommonDto {
	private String edNo;
	private String edFormCode;
	private String edTitle;
	private String edContent;
	private int presDate;
	private String secCode;
	private String status;
	private String tempSave;
	
	private String deptTitle; // 진행중인 문서 상세 조회 페이지에서 부서명 담길 필드 추가 
	private String edFrName; // 문서 이름
	
	// 첨부파일
	private List<AttachDto> attachList;
	
	// 결재이력 (결재자)
	private List<EdocHistDto> edocHistList;
	
	// 참조자
	private List<EdocRefDto> edocRefList;
}	