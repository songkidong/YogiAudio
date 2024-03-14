package com.project3.yogiaudio.repository.entity;

import java.sql.Timestamp;

import com.project3.yogiaudio.util.TimeUtils;

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
public class Music {

	private int musicNo;
	private String musicTitle;
	private String musicSinger;
	private String musicContent;
	private String startdate;
	private Timestamp regdate;
	private String filePath;
	private String musicMajor;
	private String musicMinor;
	private int musicPrice;
	
	// 날짜 포멧 설정
	public String formatRegDate() {
		return TimeUtils.timestampToString(regdate);
	}
}
