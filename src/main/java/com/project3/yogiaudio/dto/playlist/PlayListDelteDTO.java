package com.project3.yogiaudio.dto.playlist;

import lombok.Data;

/**
  * @FileName : PlayListAddDTO.java
  * @Project : YogiAudio
  * @Date : 2024. 3. 15. 
  * @작성자 : 최장호
  * @변경이력 :
  * @프로그램 설명 : 플레이리스트 삭제 DTO
  */
@Data
public class PlayListDelteDTO {
	private long userId;
	private String playlistName;
	private int orderIndex;
	private long musicNo;
}
