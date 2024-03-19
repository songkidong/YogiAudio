package com.project3.yogiaudio.repository.entity.product;

import java.sql.Timestamp;

import com.project3.yogiaudio.util.TimeUtils;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

/**
  * @FileName : LikeMusic.java
  * @Project : YogiAudio
  * @Date : 2024. 3. 19. 
  * @작성자 : 최장호
  * @변경이력 :
  * @프로그램 설명 : like_music tb entity
  */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LikeMusic {
	private long id;
	private long userId;
	private long musicNo;
}
