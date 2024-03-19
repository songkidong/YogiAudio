package com.project3.yogiaudio.repository.entity.playlist;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
  * @FileName : PlaylistOrder.java
  * @Project : YogiAudio
  * @Date : 2024. 3. 12. 
  * @작성자 : 최장호
  * @변경이력 :
  * @프로그램 설명 : playlist_order 엔티티
  */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Playlist {
	private long id;
	private long userId;
	private String playlistName;
}
