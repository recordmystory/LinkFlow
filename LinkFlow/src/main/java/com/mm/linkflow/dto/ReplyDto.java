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
@Getter
@Setter
@ToString
public class ReplyDto extends CommonDto {
	private int replyNo;
	private String replyContent;
	private String refNo;
	
	private String modCharDate;
	private String userName;
	private String position;
}
