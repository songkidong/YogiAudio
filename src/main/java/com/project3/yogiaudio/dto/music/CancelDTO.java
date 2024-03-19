package com.project3.yogiaudio.dto.music;

import java.sql.Timestamp;

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
	
	private Integer cno;
	private Integer id;
	private Integer pno;
	private String paymentKey;
	private String amount;
	private Timestamp date;
	
	
	
	
}
