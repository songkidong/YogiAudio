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
public class BoardFree {

	private long id;
	private long writerId;
	private String title;
	private String content;
	private long hit;
	private String filePath;
	private Timestamp createdAt;

	
	
}
