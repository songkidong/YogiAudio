package com.project3.yogiaudio.service.board;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.project3.yogiaudio.dto.board.NoticeDTO;
import com.project3.yogiaudio.dto.board.QnaDTO;
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
		List<BoardQna> QnaList = qnaRepository.findAllByKeywordwithPasing(offset, size, searchType, searchInput);

		// 페이징 결과 객체 생성
		PageRes<BoardQna> pageRes = new PageRes<>(QnaList, page, totalElements, size);

		return pageRes;
	}

	/**
	 * @Method Name : saveQna
	 * @작성일 : 2024. 3. 19.
	 * @작성자 : 노수현
	 * @변경이력 :
	 * @Method 설명 : 나의 문의하기 작성하기
	 */
	public int saveQna(QnaDTO qnaDTO) {

		List<MultipartFile> validFiles = new ArrayList<>();

		// 빈 파일이 아닌 경우에만 유효한 파일 목록에 추가
		if (qnaDTO.getFiles() != null) {
			for (MultipartFile file : qnaDTO.getFiles()) {
				if (!file.isEmpty()) {
					validFiles.add(file);
				}
			}
		}


		String filePath = filedbService.saveFiles(validFiles);

		BoardQna boardQna = BoardQna.builder().writerId(qnaDTO.getWriterId()).title(qnaDTO.getTitle())
				.content(qnaDTO.getContent()).filePath(filePath).build();

		int result = qnaRepository.insertQna(boardQna);

		return result;

	}

	/**
	 * @Method Name : qnaView
	 * @작성일 : 2024. 3. 19.
	 * @작성자 : 노수현
	 * @변경이력 :
	 * @Method 설명 : 문의하기 상세보기
	 */
	public BoardQna qnaReadById(int id) {

		return qnaRepository.findById(id);
	}

	/**
	 * @Method Name : qnaUpdate
	 * @작성일 : 2024. 3. 19.
	 * @작성자 : 노수현
	 * @변경이력 : 1. file서비스 새로 insert한 파일 saves로직 수행, 2. deletedHref uuid 잘라서 file서비스 삭제로직 수행
	 * @Method 설명 : 문의하기 수정하기
	 */
	public boolean qnaUpdate(int id, QnaDTO qnaDTO) {

		List<MultipartFile> validFiles = new ArrayList<>();

		// 빈 파일이 아닌 경우에만 유효한 파일 목록에 추가
		if (qnaDTO.getFiles() != null) {
			for (MultipartFile file : qnaDTO.getFiles()) {
				if (!file.isEmpty()) {
					validFiles.add(file);
				}
			}
		}

		String filePath = filedbService.saveFiles(validFiles);

		BoardQna boardQna = BoardQna.builder().title(qnaDTO.getTitle()).content(qnaDTO.getContent()).filePath(filePath)
				.id(id).build();

		int result = qnaRepository.qnaUpdate(boardQna);

		if (result == 1) {
			return true;
		}

		return false;
	}

	/**
	 * @Method Name : qnaDelete
	 * @작성일 : 2024. 3. 19.
	 * @작성자 : 노수현
	 * @변경이력 :
	 * @Method 설명 : 문의하기 삭제하기
	 */
	public boolean qnaDelete(int id) {

		int result = qnaRepository.qnaDelete(id);

		if (result == 1) {
			return true;
		}

		return false;
	}

}
