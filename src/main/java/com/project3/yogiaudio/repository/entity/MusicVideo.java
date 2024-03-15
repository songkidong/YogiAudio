package com.project3.yogiaudio.repository.entity;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

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
public class MusicVideo {
	
	private Integer videono;
	private String videotitle;
	private String videosinger;
	private String filepath;
	private String filemusic;
	private List<MultipartFile> files; // 파일 url
	
	
	
}
