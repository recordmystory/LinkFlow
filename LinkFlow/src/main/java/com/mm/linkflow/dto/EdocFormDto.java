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
public class EdocFormDto extends CommonDto {
	private String edFrCode; 
	private String edFrName; 
	private String edFrContent; 
	private int presDate; 
	private String secCode; 
}
