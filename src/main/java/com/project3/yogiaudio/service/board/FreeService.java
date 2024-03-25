package com.project3.yogiaudio.service.board;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.project3.yogiaudio.dto.board.FreeDTO;
import com.project3.yogiaudio.dto.board.FreeUpdateDTO;
import com.project3.yogiaudio.dto.common.PageReq;
import com.project3.yogiaudio.dto.common.PageRes;
import com.project3.yogiaudio.filedb.entity.Filedb;
import com.project3.yogiaudio.filedb.service.FiledbService;
import com.project3.yogiaudio.repository.entity.board.BoardFree;
import com.project3.yogiaudio.repository.interfaces.board.FreeRepository;

@Service
public class FreeService {

	@Autowired
	private FreeRepository freeRepository;

	@Autowired
	private FiledbService filedbService;

	/**
	 * @Method Name : savefree
	 * @작성일 : 2024. 3. 23.
	 * @작성자 : 노수현
	 * @변경이력 :
	 * @Method 설명 : 자유게시판 작성하기
	 */
	public int savefree(FreeDTO freeDTO) {

		List<MultipartFile> validFiles = new ArrayList<>();

		// 빈 파일이 아닌 경우에만 유효한 파일 목록에 추가
		if (freeDTO.getFiles() != null) {
			for (MultipartFile file : freeDTO.getFiles()) {
				if (!file.isEmpty()) {
					validFiles.add(file);
				}
			}
		}

		String filePath = filedbService.saveFiles(validFiles);

		BoardFree boardfree = BoardFree.builder().writerId(freeDTO.getWriterId()).title(freeDTO.getTitle())
				.content(freeDTO.getContent()).filePath(filePath).build();

		int result = freeRepository.insertFree(boardfree);

		return result;

	}

	/**
	 * @Method Name : getAllPageCount
	 * @작성일 : 2024. 3. 23.
	 * @작성자 : 노수현
	 * @변경이력 :
	 * @Method 설명 : 자유게시판 검색&페이징 list 갯수
	 */
	public int getAllPageCount() {
		String searchType = null;
		String searchInput = null;
		return freeRepository.getAllPageCount(searchType, searchInput);
	}

	/**
	 * @Method Name : findAllByKeywordwithPasing
	 * @작성일 : 2024. 3. 23.
	 * @작성자 : 노수현
	 * @변경이력 :
	 * @Method 설명 : 자유게시판 검색&페이징 list
	 */
	public PageRes<BoardFree> findAllByKeywordwithPasing(PageReq pageReq) {

		int page = pageReq.getPage();
		int size = pageReq.getSize();
		int offset = (page - 1) * size; // 오프셋 계산
		String searchType = pageReq.getSearchType();
		String searchInput = pageReq.getSearchInput();

		// 총 데이터 개수 조회
		long totalElements = freeRepository.getAllPageCount(searchType, searchInput);
		System.out.println("총갯수 :" + totalElements);

		// 페이징 처리된 목록 조회
		List<BoardFree> freeList = freeRepository.findAllByKeywordwithPasing(offset, size, searchType, searchInput);

		// 페이징 결과 객체 생성
		PageRes<BoardFree> pageRes = new PageRes<>(freeList, page, totalElements, size);

		return pageRes;

	}

	/**
	 * @Method Name : freeView
	 * @작성일 : 2024. 3. 23.
	 * @작성자 : 노수현
	 * @변경이력 :
	 * @Method 설명 : 자유게시판 상세보기
	 */
	@Transactional
	public BoardFree freeReadById(int id) {
		// 조회수 증가 --> 새로고침 후 리스트 반영됨
		freeRepository.incrementViewCount(id);

		// 게시물 정보 조회
		BoardFree boardfree = freeRepository.findAllById(id);
		if (boardfree != null) {
			// 첨부 파일 정보 조회 및 설정
			List<String> originalFileNames = new ArrayList<>();
			String filePathList = boardfree.getFilePath();
			String[] filePaths = filePathList.split(",");
			for (String filePath : filePaths) {
				int index = filePath.lastIndexOf("/get-file/");
				if (index != -1) {
					String uuid = filePath.substring(index + "/get-file/".length());
					Filedb filedb = filedbService.findByUuid(uuid);
					if (filedb != null) {
						originalFileNames.add(filedb.getOriginalFileName());
					}
				}
			}
			boardfree.setOriginFileName(originalFileNames);

			return boardfree;
		}
		return boardfree;
	}

	/**
	 * @Method Name : freeDelete
	 * @작성일 : 2024. 3. 23.
	 * @작성자 : 노수현
	 * @변경이력 :
	 * @Method 설명 : 자유게시판 삭제하기
	 */
	public boolean freeDelete(int id) {

		BoardFree boardfree = freeRepository.findAllById(id);
		String deleteFilePaths = boardfree.getFilePath();
		System.out.println("이거맞아??????? " + deleteFilePaths);

		String[] filePaths = deleteFilePaths.split(",");

		List<String> uuids = new ArrayList<>();
		for (String filePath : filePaths) {
			int index = filePath.lastIndexOf("/get-file/"); // 마지막 '/get-file/'의 위치를 찾음
			if (index != -1) { // '/get-file/'을 찾았을 경우
				String uuid = filePath.substring(index + "/get-file/".length()); // '/get-file/' 다음의 문자열을 추출하여 uuid로 저장
				uuids.add(uuid); // 추출된 uuid를 리스트에 추가
			}
		}
		// uuid 리스트를 사용하여 파일 삭제
		for (String uuid : uuids) {
			// 파일 삭제 메소드 호출
			int deleteResult = filedbService.deleteByUuid(uuid);
			if (deleteResult != 1) {
				// 파일 삭제 실패 시 예외 처리 또는 로그 출력 등을 수행할 수 있습니다.
				return false;
			}
		}

		int result = freeRepository.freeDelete(id);

		if (result == 1) {
			return true;
		}

		return false;
	}

	/**
	 * @Method Name : freeUpdate
	 * @작성일 : 2024. 3. 23.
	 * @작성자 : 노수현
	 * @변경이력 :
	 * @Method 설명 : 자유게시판 수정하기
	 */
	public boolean freeUpdate(int id, FreeUpdateDTO freeUpdateDTO) {

		List<MultipartFile> validFiles = new ArrayList<>();

		// 빈 파일이 아닌 경우에만 유효한 파일 목록에 추가
		if (freeUpdateDTO.getFiles() != null) {
			for (MultipartFile file : freeUpdateDTO.getFiles()) {
				if (!file.isEmpty()) {
					validFiles.add(file);
				}
			}
		}

		String filePath = "";

		if (validFiles != null && validFiles.isEmpty() == false) {
			filePath = filedbService.saveFiles(validFiles);
		}

		List<String> deleteList = freeUpdateDTO.getDeletedHref();

		int deleteResult = 0;

		if (deleteList != null) {
			for (String deleteFilePath : deleteList) {
				// "get-file/" 다음의 부분을 추출합니다.
				int index = deleteFilePath.lastIndexOf("/get-file/"); // 마지막 '/get-file/'의 위치를 찾음
				if (index != -1) { // '/get-file/'을 찾았을 경우
					String uuid = deleteFilePath.substring(index + "/get-file/".length()); // '/get-file/' 다음의 문자열을 추출하여
																							// uuid로 저장
					deleteResult += filedbService.deleteByUuid(uuid);
				}

			}
		}

		if (deleteList != null && deleteResult != deleteList.size()) {
			return false;
		}

		// 기존 filePath가 있으면 유지하고, 없으면 빈 문자열로 초기화합니다.
		if (filePath == null) {
			filePath = "";
		}

		List<String> hrefList = freeUpdateDTO.getHref();

		// hrefList가 null이 아닌 경우에만 처리합니다.
		if (hrefList != null) {
			// 기존 filePath에 누적하여 새로운 파일 경로를 추가합니다.
			for (String addFilePath : hrefList) {
				if (!filePath.isEmpty()) {
					filePath += ",";
				}
				filePath += addFilePath;
			}
		}

		BoardFree boardfree = BoardFree.builder().title(freeUpdateDTO.getTitle()).content(freeUpdateDTO.getContent())
				.filePath(filePath).id(id).build();

		int result = freeRepository.freeUpdate(boardfree);

		if (result == 1) {
			return true;
		}

		return false;
	}

	public PageRes<BoardFree> getSortedFreeBoard(String sortType, int page, int size) {
		int offset = (page - 1) * size;
		List<BoardFree> sortedList = null;
		long totalElements = 0;
		switch (sortType) {
		case "오래된순":
			sortedList = freeRepository.findAllByOrderByCreatedAtASCWithPaging(offset, size);
			totalElements = freeRepository.countAllByOrderByCreatedAtASC(); // 정렬된 전체 데이터 개수 가져오기
			break;
		case "조회순":
			sortedList = freeRepository.findAllByOrderByHitDescWithPaging(offset, size);
			totalElements = freeRepository.countAllByOrderByHitDesc(); // 정렬된 전체 데이터 개수 가져오기
			break;

		}
		return new PageRes<>(sortedList, page, totalElements, size);
	}

}
