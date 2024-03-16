package com.project3.yogiaudio.service.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project3.yogiaudio.dto.board.NoticeDTO;
import com.project3.yogiaudio.dto.common.PageReq;
import com.project3.yogiaudio.dto.common.PageRes;
import com.project3.yogiaudio.repository.entity.board.BoardNotice;
import com.project3.yogiaudio.repository.interfaces.board.NoticeRepository;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class NoticeService {
	
	@Autowired
	private NoticeRepository noticeRepository;
	

	/**
	  * @Method Name : noticeWrite
	  * @작성일 : 2024. 3. 13.
	  * @작성자 : 노수현
	  * @변경이력 : 
	  * @Method 설명 : 공지사항 작성하기
	  */
	@Transactional
	public int saveNotice(NoticeDTO noticeDTO) { 
		
		//String filePath = filedbService.saveFiles(noticeDTO.getFilePath());
		
		BoardNotice boardNotice = BoardNotice.builder()
				.writerId(noticeDTO.getWriterId())
				.title(noticeDTO.getTitle())
				.content(noticeDTO.getContent())
				//.filePath(filePath)
				.build();
		
		int result = noticeRepository.insertNotice(boardNotice);
		
		return result;

	}
	
	
	/**
	  * @Method Name : getAllPageCount
	  * @작성일 : 2024. 3. 14.
	  * @작성자 : 노수현
	  * @변경이력 : 
	  * @Method 설명 : 검색&페이징 list 갯수
	  */
	public int getAllPageCount() {
		return noticeRepository.getAllPageCount();
	}
	
	
	/**
	  * @Method Name : findAllByKeywordwithPasing
	  * @작성일 : 2024. 3. 14.
	  * @작성자 : 노수현
	  * @변경이력 : 
	  * @Method 설명 : 검색&페이징 list
	  */
	public PageRes<BoardNotice> findAllByKeywordwithPasing(PageReq pageReq){
		
		int page = pageReq.getPage();
		int size = pageReq.getSize();
		int offset = (page - 1) * size; // 오프셋 계산
		String searchType = pageReq.getSearchType();
		String searchInput = pageReq.getSearchInput();
		
		// 총 데이터 개수 조회
		long totalElements = noticeRepository.getAllPageCount();
		
		// 페이징 처리된 목록 조회
		List<BoardNotice> NoticeList = noticeRepository.findAllByKeywordwithPasing(offset, size, searchType, searchInput);
		
		// 페이징 결과 객체 생성
		PageRes<BoardNotice> pageRes = new PageRes<>(NoticeList ,page, totalElements, size);
		
		return pageRes;
		
	}
	
	
	
	
}
