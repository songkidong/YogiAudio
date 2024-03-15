package com.project3.yogiaudio.dto.common;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
  * @FileName : PageReq.java
  * @Project : YogiAudio
  * @Date : 2024. 3. 14. 
  * @작성자 : 노수현
  * @변경이력 :
  * @프로그램 설명 : 페이징 요청
  */
@Getter
@Setter
@ToString
@NoArgsConstructor
public class PageReq {
	
	// 현재 페이지 번호 : page == number
	private int page;
	
	// 페이지당 출력할 데이터 개수
	private int size;
	
	// 검색
	private String searchType;
	private String searchInput;

	public PageReq(int page, int size) {
		this.page = page;
		this.size = size;
	}

}
