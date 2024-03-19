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
public class History {
	
	private Integer hno;
	private Integer id;
	private String orderId;
	private String paymentKey;
	private String amount;
	private String cancelYn;

	
	
	
}
