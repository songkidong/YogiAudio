package com.project3.yogiaudio.dto.user;

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
public class HistoryListDTO {

	private int hno;
	private int id;
	private int pNo;
	private String orderId;
	private String amount;
	private Timestamp date;
	private String name;
	private String nickname;
	private String purchaseName;

	// 날짜 포멧 설정
	public String formatCreatedAt() {
		return TimeUtils.timestampToString(date);
	}
}