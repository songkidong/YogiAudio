package com.project3.yogiaudio.dto.admin;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class NoticeSaveFormDTO {

	private String title;
	private String content;

	// 파일처리 
	// 단일파일
	private MultipartFile filePath;
	// 다중파일
	private List<MultipartFile> files;
	
	// 기존 파일 목록의 href
	private List<String> hrefs;
	
	private List<String> deletedHrefs;
	
}
