package com.project3.yogiaudio.dto.playlist;

import java.util.List;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

import lombok.Data;

/**
  * @FileName : PlayListDeleteDTO.java
  * @Project : YogiAudio
  * @Date : 2024. 3. 15. 
  * @작성자 : 최장호
  * @변경이력 :
  * @프로그램 설명 : 플레이리스트 삭제 DTO json으로 받기 위해 생성
  */
@Data
public class PlayListDeleteListDTO {
    private List<PlayListDeleteDTO> deleteList;
}