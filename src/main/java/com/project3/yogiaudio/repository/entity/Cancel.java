package com.project3.yogiaudio.repository.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Cancel {

	private Integer hcno;
	private String orderName;
	private String method;
	private String cancelReason;
	
	
}
