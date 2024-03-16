package com.project3.yogiaudio.dto.playlist;

import lombok.Data;

/**
  * @FileName : PlayListStartDTO.java
  * @Project : YogiAudio
  * @Date : 2024. 3. 12. 
  * @작성자 : 최장호
  * @변경이력 :
  * @프로그램 설명 : playlist를 실행시킬때 담기는 dto
  */
@Data
public class PlayListStartDTO {
	private String playlistName;
	private String musicTitle;
	private String musicSinger;
	private String lyrics;
	private String filePath;
	private String fileMusic;
}
