package com.project3.yogiaudio.dto.board;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

/**
  * @FileName : BoardFileDTO.java
  * @Project : YogiAudio
  * @Date : 2024. 3. 20. 
  * @작성자 : 노수현
  * @변경이력 :
  * @프로그램 설명 :
  */

@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class BoardFileDTO {
	
	private String filePath;
	private String originFileName;

}
