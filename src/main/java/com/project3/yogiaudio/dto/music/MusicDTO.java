package com.project3.yogiaudio.dto.music;

import java.sql.Timestamp;

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
public class MusicDTO {
	
	private long id;
	private int musicno;
	private String musictitle;
	private String musicsinger;
	private String musiccontent;
	private String musiccompany;
	private String lyrics;
	private String startdate;
	private Timestamp regdate;
	private String filepath;
	private String filemusic;
	private String musicsample;
	private String musicmajor;
	private String musicminor;
	private int musicprice;
	private String status;
	private List<MultipartFile> files; // 파일 url

	
	
	
}
