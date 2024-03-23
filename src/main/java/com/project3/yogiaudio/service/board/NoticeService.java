package com.project3.yogiaudio.service.board;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.project3.yogiaudio.dto.board.NoticeDTO;
import com.project3.yogiaudio.dto.board.NoticeUpdateDTO;
import com.project3.yogiaudio.dto.common.PageReq;
import com.project3.yogiaudio.dto.common.PageRes;
import com.project3.yogiaudio.filedb.entity.Filedb;
import com.project3.yogiaudio.filedb.service.FiledbService;
import com.project3.yogiaudio.repository.entity.board.BoardNotice;
import com.project3.yogiaudio.repository.entity.board.BoardQna;
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
	 * @Method Name : saveNotice
	 * @작성일 : 2024. 3. 13.
	 * @작성자 : 노수현
	 * @변경이력 :
	 * @Method 설명 : 공지사항 작성하기
	 */
	public int saveNotice(NoticeDTO noticeDTO) {

		List<MultipartFile> validFiles = new ArrayList<>();

		// 빈 파일이 아닌 경우에만 유효한 파일 목록에 추가
		if (noticeDTO.getFiles() != null) {
			for (MultipartFile file : noticeDTO.getFiles()) {
				if (!file.isEmpty()) {
					validFiles.add(file);
				}
			}
		}

		String filePath = filedbService.saveFiles(validFiles);

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
	 * @Method 설명 : 공지사항 검색&페이징 list 갯수
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
	 * @Method 설명 : 공지사항 검색&페이징 list
	 */
	public PageRes<BoardNotice> findAllByKeywordwithPasing(PageReq pageReq) {

		int page = pageReq.getPage();
		int size = pageReq.getSize();
		int offset = (page - 1) * size; // 오프셋 계산
		String searchType = pageReq.getSearchType();
		String searchInput = pageReq.getSearchInput();

		// 총 데이터 개수 조회
		long totalElements = noticeRepository.getAllPageCount(searchType, searchInput);
		System.out.println("총갯수 :" + totalElements);

		// 페이징 처리된 목록 조회
		List<BoardNotice> NoticeList = noticeRepository.findAllByKeywordwithPasing(offset, size, searchType,
				searchInput);

		// 페이징 결과 객체 생성
		PageRes<BoardNotice> pageRes = new PageRes<>(NoticeList, page, totalElements, size);

		return pageRes;

	}

	/**
	 * @Method Name : noticeView
	 * @작성일 : 2024. 3. 22.
	 * @작성자 : 노수현
	 * @변경이력 :
	 * @Method 설명 : 공지사항 상세보기
	 */
	public BoardNotice noticeReadById(int id) {

		BoardNotice boardNotice = noticeRepository.findAllById(id);
		String filePathList = boardNotice.getFilePath();
		System.out.println("파일패스리스트야??????? " + filePathList);

		String[] filePaths = filePathList.split(",");

		List<String> uuids = new ArrayList<>();
		for (String filePath : filePaths) {
			int index = filePath.lastIndexOf("/get-file/"); // 마지막 '/get-file/'의 위치를 찾음
			if (index != -1) { // '/get-file/'을 찾았을 경우
				String uuid = filePath.substring(index + "/get-file/".length()); // '/get-file/' 다음의 문자열을 추출하여 uuid로 저장
				uuids.add(uuid); // 추출된 uuid를 리스트에 추가
				System.out.println("유유아이디들들들들??" + uuids);
				System.out.println("유유아이디야???" + uuid);
			}
		}

		Filedb filedb = null;

		List<String> originalFileNames = new ArrayList<>();

		for (String uuid : uuids) {
			// uuid로 첨부된 파일 원래 이름 찾기
			filedb = filedbService.findByUuid(uuid);
			System.out.println("원래이름나오는리스트야??????? " + filedb);
			originalFileNames.add(filedb.getOriginalFileName()); // 파일 이름을 리스트에 추가
		}

		boardNotice.setOriginFileName(originalFileNames); // 리스트를 BoardNotice 객체에 설정

		return boardNotice;
	}

	/**
	 * @Method Name : noticeDelete
	 * @작성일 : 2024. 3. 22.
	 * @작성자 : 노수현
	 * @변경이력 :
	 * @Method 설명 : 공지사항 삭제하기
	 */
	public boolean noticeDelete(int id) {

		BoardNotice boardNotice = noticeRepository.findAllById(id);
		String deleteFilePaths = boardNotice.getFilePath();
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

		int result = noticeRepository.noticeDelete(id);

		if (result == 1) {
			return true;
		}

		return false;
	}

	/**
	 * @Method Name : noticeUpdate
	 * @작성일 : 2024. 3. 22.
	 * @작성자 : 노수현
	 * @변경이력 :
	 * @Method 설명 : 공지사항 수정하기
	 */
	public boolean noticeUpdate(int id, NoticeUpdateDTO noticeUpdateDTO) {

		List<MultipartFile> validFiles = new ArrayList<>();

		// 빈 파일이 아닌 경우에만 유효한 파일 목록에 추가
		if (noticeUpdateDTO.getFiles() != null) {
			for (MultipartFile file : noticeUpdateDTO.getFiles()) {
				if (!file.isEmpty()) {
					validFiles.add(file);
				}
			}
		}

		String filePath = "";

		if (validFiles != null && validFiles.isEmpty() == false) {
			filePath = filedbService.saveFiles(validFiles);
		}

		List<String> deleteList = noticeUpdateDTO.getDeletedHref();

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

		List<String> hrefList = noticeUpdateDTO.getHref();

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

		BoardNotice boardNotice = BoardNotice.builder().title(noticeUpdateDTO.getTitle())
				.content(noticeUpdateDTO.getContent()).filePath(filePath).id(id).build();

		int result = noticeRepository.noticeUpdate(boardNotice);

		if (result == 1) {
			return true;
		}

		return false;
	}

}
