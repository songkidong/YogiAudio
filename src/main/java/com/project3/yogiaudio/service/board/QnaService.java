package com.project3.yogiaudio.service.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project3.yogiaudio.dto.common.PageReq;
import com.project3.yogiaudio.dto.common.PageRes;
import com.project3.yogiaudio.filedb.service.FiledbService;
import com.project3.yogiaudio.repository.entity.board.BoardNotice;
import com.project3.yogiaudio.repository.entity.board.BoardQna;
import com.project3.yogiaudio.repository.interfaces.board.QnaRepository;

@Service
public class QnaService {
	
	@Autowired
	private QnaRepository qnaRepository;
	
	@Autowired
	private FiledbService filedbService;
	
	/**
	 * @Method Name : getAllPageCount
	 * @작성일 : 2024. 3. 19.
	 * @작성자 : 노수현
	 * @변경이력 :
	 * @Method 설명 : 문의하기 검색&페이징 list 갯수
	 */
	public int getAllPageCount() {
		String searchType = null;
		String searchInput = null;
		return qnaRepository.getAllPageCount(searchType, searchInput);
	}
	
	
	/**
	  * @Method Name : findAllByKeywordwithPasing
	  * @작성일 : 2024. 3. 19.
	  * @작성자 : 노수현
	  * @변경이력 : 
	  * @Method 설명 : 문의하기 검색&페이징 list
	  */
	public PageRes<BoardQna> findAllByKeywordwithPasing(PageReq pageReq) {
		int page = pageReq.getPage();
		int size = pageReq.getSize();
		int offset = (page - 1) * size; // 오프셋 계산
		String searchType = pageReq.getSearchType();
		String searchInput = pageReq.getSearchInput();

		// 총 데이터 개수 조회
		long totalElements = qnaRepository.getAllPageCount(searchType, searchInput);
		System.out.println("총갯수 :" + totalElements);

		// 페이징 처리된 목록 조회
		List<BoardQna> QnaList = qnaRepository.findAllByKeywordwithPasing(offset, size, searchType,
				searchInput);

		// 페이징 결과 객체 생성
		PageRes<BoardQna> pageRes = new PageRes<>(QnaList, page, totalElements, size);

		return pageRes;
	}
	
	
	
}
