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
public class NoticeUpdateDTO {

	private long id;
	private long writerId;
	private String title;
	private String content;
	private List<MultipartFile> files;
	private Timestamp createdAt;
	
	// 추가 필드 - file(uuid, originName)
	private List<BoardFileDTO> boardFileDTOList;
	
	// ajax
	private List<String> deletedHref;
	private List<String> href;
	
	
}
