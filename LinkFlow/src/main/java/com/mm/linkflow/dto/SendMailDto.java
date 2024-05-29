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
@Setter
@Getter
@ToString
public class SendMailDto extends CommonDto{
	private int mailNo;
	private String mailTitle;
	private String mailContent;
	private String transTime;
	private String tempSave;
	private String removeYN;
	private String userId;
	private String receiver;
	
	private String userName;
	
	private List<AttachDto> attachList;
}
