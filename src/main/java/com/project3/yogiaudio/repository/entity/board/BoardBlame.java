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
public class BoardBlame {

	private long id;
	private long targetType;
	private long targetId;
	private long targetUserId;
	private long userId;
	private long blameCount;
	private String blameReason;
	private long status;
	private Timestamp createdAt;
	

}
