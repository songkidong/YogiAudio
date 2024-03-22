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
public class User {

	private long id;
	private String name;
	private String nickname;
	private String email;
	private String password;
	private String filePath;
	private Timestamp createdAt;
	private String role;
	private String deleteYn;
	private Timestamp deleteAt;
	private String status;
	private String cancel;

	
	// 날짜 포멧 설정
	public String formatCreatedAt() {
		return TimeUtils.timestampToString(createdAt);
	}
	
    // filePath 필드에 대한 getter 메서드
    public String getFilePath() {
        return this.filePath;
    }
}
