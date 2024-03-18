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
public class CancelDTO {
	
	private Integer hno;
	private Integer hcno;
	private String orderName;
	private String method;
	private String cancelReason;
	private String paymentKey;
	
}
