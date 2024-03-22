package com.project3.yogiaudio.repository.entity;

import java.sql.Timestamp;

import com.project3.yogiaudio.util.TimeUtils;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class History {
	
	private int hno; // hNo는 왜 안되는 거죠??
	private int id;
	private int pNo;
	private String orderId; // 결제 API 활용할 때 json 데이터 String으로 반환되므로 문자열로 테이블 설계
	private String paymentKey; 
	private String amount; 
	private Timestamp date;

	// 조인 칼럼 추가
	private String name;
	private String nickname;
	private String purchaseName;
	
	// 날짜 포멧 설정
	public String formatCreatedAt() {
		return TimeUtils.timestampToString(date);
	}
	
}
