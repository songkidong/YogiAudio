package com.project3.yogiaudio.service.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project3.yogiaudio.dto.board.NoticeDTO;
import com.project3.yogiaudio.dto.common.PageReq;
import com.project3.yogiaudio.dto.common.PageRes;
import com.project3.yogiaudio.filedb.service.FiledbService;
import com.project3.yogiaudio.repository.entity.board.BoardNotice;
import com.project3.yogiaudio.repository.interfaces.board.NoticeRepository;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class NoticeService {

	@Autowired
	private NoticeRepository noticeRepository;

	@Autowired
	private FiledbService filedbService;

	/**
	 * @Method Name : noticeWrite
	 * @작성일 : 2024. 3. 13.
	 * @작성자 : 노수현
	 * @변경이력 :
	 * @Method 설명 : 공지사항 작성하기
	 */
	public int saveNotice(NoticeDTO noticeDTO) {

		// form에서 넘어온 파일이 빈값이면 제거
		if (noticeDTO.getFiles() != null) {
			for (int i = 0; i < noticeDTO.getFiles().size(); i++) {
				if (noticeDTO.getFiles().get(i).isEmpty()) {
					noticeDTO.getFiles().remove(i);
				}
			}
		}

		String filePath = filedbService.saveFiles(noticeDTO.getFiles());

		BoardNotice boardNotice = BoardNotice.builder().writerId(noticeDTO.getWriterId()).title(noticeDTO.getTitle())
				.content(noticeDTO.getContent()).filePath(filePath).build();

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
		String searchType = null;
		String searchInput = null;
		return noticeRepository.getAllPageCount(searchType, searchInput);
	}

	/**
	 * @Method Name : findAllByKeywordwithPasing
	 * @작성일 : 2024. 3. 14.
	 * @작성자 : 노수현
	 * @변경이력 :
	 * @Method 설명 : 검색&페이징 list
	 */
	public PageRes<BoardNotice> findAllByKeywordwithPasing(PageReq pageReq) {

		int page = pageReq.getPage();
		int size = pageReq.getSize();
		int offset = (page - 1) * size; // 오프셋 계산
		String searchType = pageReq.getSearchType();
		String searchInput = pageReq.getSearchInput();

		// 총 데이터 개수 조회
		long totalElements = noticeRepository.getAllPageCount(searchType, searchInput);
		System.out.println("총갯수말해줘봐보바ㅗ바ㅗ바봐보바 :" + totalElements);

		// 페이징 처리된 목록 조회
		List<BoardNotice> NoticeList = noticeRepository.findAllByKeywordwithPasing(offset, size, searchType, searchInput);

		// 페이징 결과 객체 생성
		PageRes<BoardNotice> pageRes = new PageRes<>(NoticeList, page, totalElements, size);

		return pageRes;

	}

	/**
	  * @Method Name : noticeView
	  * @작성일 : 2024. 3. 18.
	  * @작성자 : 노수현
	  * @변경이력 : 
	  * @Method 설명 : 공지사항 상세보기
	  */
	public BoardNotice noticeView(int id) {
		
		return noticeRepository.findAllById(id);
	}

	/**
	  * @Method Name : noticeDelete
	  * @작성일 : 2024. 3. 18.
	  * @작성자 : 노수현
	  * @변경이력 : 
	  * @Method 설명 : 공지사항 삭제하기
	  */
	public boolean noticeDelete(int id) {
		
		int result = noticeRepository.noticeDelete(id);
		
		if(result == 1) {
			return true;
		}

		return false;
	}

}
