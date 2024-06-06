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
public class ReceiveMailDto {
	private String userId;
	private int mailNo;
	private String delYN;
	private String readYN;
	private String type;
	
	private String transTime;
	private String userName;
	private String mailTitle;
}
