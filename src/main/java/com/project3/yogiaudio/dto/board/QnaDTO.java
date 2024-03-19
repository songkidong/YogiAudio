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
public class QnaDTO {

	private long id;
	private long writerId;
	private String title;
	private String content;
	private String amswerYn;
	private List<MultipartFile> files;
	private Timestamp createdAt;
	
	// file 수정,삭제
	private List<String> uuidList;
	
	
}
