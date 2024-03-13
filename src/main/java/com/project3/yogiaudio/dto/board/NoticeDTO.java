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
public class NoticeDTO {
	
	private long id;
	private long writerId;
	private String title;
	private String content;
	private MultipartFile file;
	private Timestamp createdAt;
	
	
	
	
	
}
