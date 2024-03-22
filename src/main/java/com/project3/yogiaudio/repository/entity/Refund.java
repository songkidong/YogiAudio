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
public class Refund {

	private int id;
	private int hno;
	private int userId;
	private String refundYn;
	private Timestamp refundReqDate;
	private Timestamp refundDate;
	
	// 조인 칼럼 추가
	// user 테이블
	private String name;
	private String nickname;
	// history 테이블
	private int pno; // cancel 테이블에 insert 하기 위해 필요한 칼럼(ajax로 전송할 때 파라미터로 사용하기 위함)
	private String amount;
	private Timestamp date; // DB datetime 타입 / Timestamp로 설정해도 되나요??
	// purchase 테이블
	private String purchaseName;
	
	
	
	// 날짜 포멧 설정
	public String formatRefundReqDate() {
		return TimeUtils.timestampToString(refundReqDate);
	}
	
 	public String formatRefundDate() {
		return TimeUtils.timestampToString(refundDate);
	}
 	
	public String formatHistoryDate() {
		return TimeUtils.timestampToString(date);
	}
	
}
