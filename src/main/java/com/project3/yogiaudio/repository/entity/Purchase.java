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
public class Purchase {

	private Integer pno;
	private String purchaseName;
	private String purchaseDetail;
	private Integer price;
	
	
	
	
}
