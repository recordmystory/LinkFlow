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
public class AssetsDto extends CommonDto{

	private String assetsNo;
	private String assetsName;
	private String useYN;
	private String mainCode;
	private String subCode;
	private String subName;
}
