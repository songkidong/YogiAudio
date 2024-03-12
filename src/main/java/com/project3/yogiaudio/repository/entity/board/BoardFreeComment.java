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
public class BoardFreeComment {

	private long id;
	private long writerId;
	private long boardFreeId;
	private String content;	
	private Timestamp createdAt;
	
	
}
