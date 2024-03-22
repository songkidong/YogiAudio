package com.project3.yogiaudio.dto.playlist;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
  * @FileName : PlayListAddDTO.java
  * @Project : YogiAudio
  * @Date : 2024. 3. 15. 
  * @작성자 : 최장호
  * @변경이력 :
  * @프로그램 설명 : 플레이리스트 저장 DTO
  */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class PlayListSaveDTO {
	private long id;
	private long userId;
	private String playlistName;
	private int orderIndex;
}
