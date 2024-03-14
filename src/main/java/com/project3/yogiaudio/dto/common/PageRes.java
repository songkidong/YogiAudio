package com.project3.yogiaudio.dto.common;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * @FileName : PageRes.java
 * @Project : YogiAudio
 * @Date : 2024. 3. 14.
 * @작성자 : 노수현
 * @변경이력 :
 * @프로그램 설명 : 페이징 결과 클래스
 */
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class PageRes<Object> {

	// 쿼리 결과를 저장할 배열
	private List<Object> content;

	// 현재 페이지 번호 : 0부터 시작
	private int number;

	// 테이블 총 건수
	private long totalElements;

	// 테이블 총 건수 / 페이지당 출력할 개수(size)
	// 총 페이지 수
	private int totalPages;

	// 1 페이지당 개수
	private int size;

	// 시작 블럭 페이지 번호
	private int startPage;

	// 끝 블럭 페이지 번호
	private int endPage;

	public PageRes(List<Object> content, int number, long totalElements, int size) {
		this.content = content;
		this.number = number; // 현재 페이지 번호
		this.totalElements = totalElements; // 총 데이터 개수
		this.size = size; // 1페이지 당 개수

		this.totalPages = (int) Math.ceil((double) totalElements / size); // 총페이지 수 (소수점이 나오면 +1 페이지 더함)

		this.startPage = ((int) Math.floor((double) (number) / size) * size) + 1; // 현재 페이지 블럭의 시작 페이지 번호
		this.startPage = (this.startPage < 1) ? 1 : this.startPage; // 시작페이지 번호 보정(1보다 작을 수 없음)

		this.endPage = this.startPage + (size - 1); // 현재 페이지 블럭의 끝 페이지 번호
		this.endPage = (this.endPage > this.totalPages) ? this.totalPages : this.endPage; // 끝페이지 보정(총페이지수보다 클 수 없음)
	}

	// 데이터가 없으면 false, 있으면 true
	public boolean isEmpty() {
		if (totalElements > 0) {
			return false;
		} else {
			return true;
		}
	}
}
