package com.project3.yogiaudio.dto.user;

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
public class LikeMusicListDTO {
	private String filePath;
	private int musicNo;
	private String musicTitle;
	private String musicSinger;
	private Timestamp createdAt;
	
	// 날짜 포멧 설정
	public String formatCreatedAt() {
		return TimeUtils.timestampToString(createdAt);
	}
}
