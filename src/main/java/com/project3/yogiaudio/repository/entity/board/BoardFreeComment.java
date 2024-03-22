package com.project3.yogiaudio.repository.entity.board;

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
public class BoardFreeComment {

	private long id;
	private long writerId;
	private long boardFreeId;
	private String content;	
	private Timestamp createdAt;
	
	// 조인 추가 필드
	private String writerName;
	
	// 날짜 포멧 설정
	public String formatCreatedAt() {
		return TimeUtils.timestampToString(createdAt);
	}
}
