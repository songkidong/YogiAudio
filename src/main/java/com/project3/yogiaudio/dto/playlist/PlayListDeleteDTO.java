package com.project3.yogiaudio.dto.playlist;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

import lombok.Data;

/**
  * @FileName : PlayListDeleteDTO.java
  * @Project : YogiAudio
  * @Date : 2024. 3. 15. 
  * @작성자 : 최장호
  * @변경이력 :
  * @프로그램 설명 : 플레이리스트 삭제 DTO
  */
@Data
public class PlayListDeleteDTO {
	private long userId;
	private String playlistName;
	private int orderIndex;
	private long musicNo;
}
