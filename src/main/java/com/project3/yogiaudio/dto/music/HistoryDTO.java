package com.project3.yogiaudio.dto.music;

import com.project3.yogiaudio.repository.entity.History;

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
public class HistoryDTO {
	
	private Integer hno;
	private Integer id;
	private String orderId;
	private String paymentKey;
	private String amount;
	private String cancelYn;
	
	
}
