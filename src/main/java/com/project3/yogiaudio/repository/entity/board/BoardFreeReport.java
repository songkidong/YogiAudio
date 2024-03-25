package com.project3.yogiaudio.repository.entity.board;

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
public class BoardFreeReport {

	private long id;
	private String targetType;
	private long targetId;
	private long targetUserId;
	private long userId;
	private String reportReason;
	private String status;
	private Timestamp createdAt;
	

}
