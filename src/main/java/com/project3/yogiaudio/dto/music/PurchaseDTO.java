package com.project3.yogiaudio.dto.music;

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
public class PurchaseDTO {

	private long id;
	private Integer pno;
	private String purchasename;
	private String purchasedetail;
	private Integer price;
	private String paymentKey;
	
}
