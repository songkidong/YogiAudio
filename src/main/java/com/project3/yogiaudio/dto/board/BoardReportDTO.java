package com.project3.yogiaudio.dto.board;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class BoardReportDTO {

	private long id;
	private long targetType;
	private long targetId;
	private long targetUserId;
	private long userId;
	private String reportReason;
	private String status;
	private Timestamp createdAt;
}
