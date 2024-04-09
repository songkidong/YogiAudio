package com.project3.yogiaudio.service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.project3.yogiaudio.dto.admin.AdminCriteria;
import com.project3.yogiaudio.dto.admin.NoticeSaveFormDTO;
import com.project3.yogiaudio.dto.admin.QnaReplySaveFormDTO;
import com.project3.yogiaudio.dto.board.BoardFileDTO;
import com.project3.yogiaudio.repository.entity.Filedb;
import com.project3.yogiaudio.repository.entity.User;
import com.project3.yogiaudio.repository.entity.board.BoardFree;
import com.project3.yogiaudio.repository.entity.board.BoardFreeComment;
import com.project3.yogiaudio.repository.entity.board.BoardNotice;
import com.project3.yogiaudio.repository.entity.board.BoardQna;
import com.project3.yogiaudio.repository.entity.board.BoardQnaReply;
import com.project3.yogiaudio.repository.interfaces.AdminBoardRepository;
import com.project3.yogiaudio.repository.interfaces.FiledbRepository;
import com.project3.yogiaudio.util.Define;

import jakarta.servlet.http.HttpSession;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Service
public class AdminBoardService {

	@Autowired
	private AdminBoardRepository adminBoardRepository;
	
	@Autowired
	private FiledbService fileDbService;
	
	@Autowired
	private FiledbRepository fileDbRepository;
	
	@Autowired
	private HttpSession session;
	
	/**
	  * @Method Name : findAllNotice
	  * @작성일 : 2024. 3. 13.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 공지사항 목록
	  */
	public List<BoardNotice> findAllNotice(AdminCriteria cri) {
		
		return adminBoardRepository.findAllNotice(cri);
	}
	
	/**
	  * @Method Name : countAllNotice
	  * @작성일 : 2024. 3. 13.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 공지사항 카운팅
	  */
	public int countAllNotice() {
		
		return adminBoardRepository.countAllNotice();
	}
	
	/**
	  * @Method Name : deleteNotice
	  * @작성일 : 2024. 3. 13.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 공지사항 삭제
	  */
	public boolean deleteNotice(Integer id) {
		
		return adminBoardRepository.deleteNotice(id);
	}
	
	/**
	  * @Method Name : findNoticeById
	  * @작성일 : 2024. 3. 15.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 공지사항 글보기
	  */
	public BoardNotice findNoticeById(Integer id) {
		
		return adminBoardRepository.findNoticeById(id);
	}
	
	/**
	  * @Method Name : insertNotice
	  * @작성일 : 2024. 3. 14.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : ★★★★★공지사항 등록 
	  */
	
	@Transactional  
	public boolean insertNotice(NoticeSaveFormDTO dto) {
		
		// 사용자 정보 가져오기
		User principal = (User) session.getAttribute(Define.PRINCIPAL);
		
		String filePath = null;
		
		// 폼 전송으로 인해 DTO의 files에 데이터 매핑 됨
		List<MultipartFile> files = dto.getFiles();
		
		// Iterator 활용하여 모든 요소 검증 및 제거
		Iterator<MultipartFile> iterator = files.iterator();
		
		// 모든 요소 검증
		while(iterator.hasNext()) {
		    MultipartFile file = iterator.next();
		    // 파일첨부 안한 경우 getOriginalFilename() 비어있음
		    if(file.getOriginalFilename().isEmpty()) {
		        iterator.remove(); // 안전하게 요소 제거
		    }
		}
		
		// files 가 빈 리스트가 아닐때 : 파일 첨부한 경우 
		if(!files.isEmpty()) {
			filePath = fileDbService.saveFiles(files);
		}
		
		BoardNotice notice = BoardNotice.builder()
						.writerId(principal.getId()) 
						.title(dto.getTitle())
						.content(dto.getContent())
						.filePath(filePath)
						.build();
		
		return adminBoardRepository.insertNotice(notice);
	}
	
	/**
	  * @Method Name : updateNotice
	  * @작성일 : 2024. 3. 20.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 공지사항 수정
	  */
	@Transactional
	public boolean updateNotice(Integer id, NoticeSaveFormDTO dto) {

		String filePath = null;
		
		// 폼 전송으로 인해 DTO의 files에 데이터 매핑 됨
		List<MultipartFile> files = dto.getFiles();
		
		// Iterator 활용하여 모든 요소 검증 및 제거
		Iterator<MultipartFile> iterator = files.iterator();
		
		// 모든 요소 검증
		while(iterator.hasNext()) {
		    MultipartFile file = iterator.next();
		    // 파일첨부 안한 경우 getOriginalFilename() 비어있음
		    if(file.getOriginalFilename().isEmpty()) {
		        iterator.remove(); // 안전하게 요소 제거
		    }
		}
		
		// 기존 파일 href 목록 
		List<String> hrefList = dto.getHrefs();
		
		// href 목록이 남아있다면
		if(!hrefList.isEmpty()) {
			
			// filePath 가 null 이면, += 연산 오류 발생하므로 빈문자열로 초기화
			filePath = "";
			
			for(String href : hrefList) {
				filePath += href + ","; 
			}
			
			// 1. files 가 빈 리스트가 아닐때 : 파일 첨부한 경우 
			if(!files.isEmpty()) {
				filePath += fileDbService.saveFiles(files);
			}else {
			
				// 2. 파일 첨부 안한경우에 href 목록 추가한 filePath의 마지막 "," 제거
				// ex) 10개면 substring(0, 9) : 8번 인덱스까지 출력
				filePath = filePath.substring(0, filePath.length() - 1);
			}
			
		}else {
			
			// href 목록 없을 때
			// 1. files 가 빈 리스트가 아닐때 : 파일 첨부한 경우 
			if(!files.isEmpty()) {
				filePath = fileDbService.saveFiles(files);
			}
			
			// 2. 파일 첨부 안한 경우 filePath = null 로 update
		}
		
		// 기존 데이터 가져오기
		BoardNotice notice = adminBoardRepository.findNoticeById(id);

		// builder는 완전히 새로운 객체를 다시 생성하는 것 => 수정에는 이용 불가
		notice.setTitle(dto.getTitle());
		notice.setContent(dto.getContent());
		notice.setFilePath(filePath);
		
		log.info("notice : " + notice);
		
		return adminBoardRepository.updateNotice(notice);
	}
	
	/**
	  * @Method Name : findNoticeFileNames
	  * @작성일 : 2024. 3. 22.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 공지사항 파일 목록
	  */
	@Transactional
	public List<BoardFileDTO> findNoticeFiles(Integer id) {
		
		// 공지사항 filePath 가져오기
		BoardNotice notice = adminBoardRepository.findNoticeById(id);
		String filePath = notice.getFilePath();
		System.out.println("!!!!!!!!!!!!!!!!!!!!!filePath : " + filePath);
		
		
		List<BoardFileDTO> boardFileDTOList = new ArrayList<>();
		
		// 파일 첨부 안했을 때 오류 발생하므로, filePath가 null이면
		if(filePath == null || filePath.isEmpty()) {
		
			return boardFileDTOList; // 바로 메서드 종료
		}
		 
		String[] filePaths = filePath.split(","); // split은 문자열 받아야하므로 ""
		log.info("filePaths : " + filePaths);
		
		for(int i=0 ; i<filePaths.length ; i++) {

			BoardFileDTO boardFileDTO = new BoardFileDTO();
			
			boardFileDTO.setFilePath(filePaths[i]);
			
			String uuid = filePaths[i].split("/")[5];
			Filedb file = fileDbRepository.findByUuid(uuid);
			boardFileDTO.setOriginFileName(file.getOriginalFileName());
			
			boardFileDTOList.add(boardFileDTO);
		}
		
		return boardFileDTOList;
		
	}
	
	/**
	  * @Method Name : findAllQna
	  * @작성일 : 2024. 3. 14.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : qna 목록
	  */
	public List<BoardQna> findAllQna(AdminCriteria cri) {
		
		return adminBoardRepository.findAllQna(cri);
	}
	
	/**
	  * @Method Name : countAllQna
	  * @작성일 : 2024. 3. 14.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : qna 카운팅
	  */
	public int countAllQna() {
		
		return adminBoardRepository.countAllQna();
	}
	
	/**
	  * @Method Name : deleteQna
	  * @작성일 : 2024. 3. 14.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : qna 삭제
	  */
	@Transactional
	public boolean deleteQna(Integer id) {
		
		boolean result = adminBoardRepository.deleteQna(id);
		
		// qna 삭제 완료되면, 모든 답변 삭제
		if(result == true) {
			adminBoardRepository.deleteReplysByBoardQnaId(id);
		}
		
		return result;
	}
	
	/**
	  * @Method Name : findQnaById
	  * @작성일 : 2024. 3. 19.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : qna 글보기
	  */
	public BoardQna findQnaById(Integer id) {
		
		return adminBoardRepository.findQnaById(id);
	}
	
	/**
	  * @Method Name : insertQnaReply
	  * @작성일 : 2024. 3. 19.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : qna 답변 등록
	  */
	@Transactional 
	public boolean insertQnaReply(Integer boardQnaId, QnaReplySaveFormDTO dto) {
		
		// 사용자 정보 가져오기
		User principal = (User) session.getAttribute(Define.PRINCIPAL);
		
		// 답변 등록
		BoardQnaReply boardQnaReply = BoardQnaReply.builder()
									.writerId(principal.getId()) // principal.getId() 
									.boardQnaId(boardQnaId) // boardQnaId 매개변수로 받기
									.content(dto.getContent())
									.build();
		
		boolean result = adminBoardRepository.insertQnaReply(boardQnaReply);
		
		// 순서는 답변이 등록되면, 수정되는 것이 맞다!!
		// 답변 등록 완료되면, 답변 여부 Y로 표시
		if(result == true) {
			adminBoardRepository.updateAnwerYnByInsertReply(boardQnaId);
		}
									
		return result;
	}

	/**
	  * @Method Name : findAllReplyByBoardQnaId
	  * @작성일 : 2024. 3. 19.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : qna 답변 목록
	  */
	public List<BoardQnaReply> findAllReplyByBoardQnaId(Integer boardQnaId) {
		
		return adminBoardRepository.findAllReplyByBoardQnaId(boardQnaId);
	}
	
	/**
	  * @Method Name : deleteReply
	  * @작성일 : 2024. 3. 19.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : qna 답변 삭제
	  */
	@Transactional 
	public boolean deleteReply(Integer id, Integer boardQnaId) {
		
		boolean result = adminBoardRepository.deleteReply(id);
		
		// qna 답변이 아예 없으면, 답변여부 N으로 표시
		List<BoardQnaReply> replyList = adminBoardRepository.findAllReplyByBoardQnaId(boardQnaId);
		if(replyList.isEmpty()) {
			adminBoardRepository.updateAnwerYnByDeleteReply(boardQnaId);
		}
		
		return result;
	}
	
	/**
	  * @Method Name : updateReply
	  * @작성일 : 2024. 3. 25.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : qna 답변 수정
	  */
	public boolean updateReply(Integer id, QnaReplySaveFormDTO dto) {
		
		BoardQnaReply boardQnaReply = adminBoardRepository.findReplyById(id);
		boardQnaReply.setContent(dto.getContent());
		
		return adminBoardRepository.updateReply(boardQnaReply);
	}
	
	/**
	  * @Method Name : findQnaFiles
	  * @작성일 : 2024. 3. 25.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : qna 파일 목록
	  */
	@Transactional
	public List<BoardFileDTO> findQnaFiles(Integer id) {
			
			// qna filePath 가져오기
			BoardQna qna = adminBoardRepository.findQnaById(id);
			String filePath = qna.getFilePath();
			System.out.println("!!!!!!!!!!!!!!!!!!!!!filePath : " + filePath);
			
			
			List<BoardFileDTO> boardFileDTOList = new ArrayList<>();
			
			// 파일 첨부 안했을 때 오류 발생하므로, filePath가 null이면
			if(filePath == null || filePath.isEmpty()) {
			
				return boardFileDTOList; // 바로 메서드 종료
			}
			 
			String[] filePaths = filePath.split(","); // split은 문자열 받아야하므로 ""
			log.info("filePaths : " + filePaths);
			
			for(int i=0 ; i<filePaths.length ; i++) {
	
				BoardFileDTO boardFileDTO = new BoardFileDTO();
				
				boardFileDTO.setFilePath(filePaths[i]);
				
				String uuid = filePaths[i].split("/")[5];
				Filedb file = fileDbRepository.findByUuid(uuid);
				boardFileDTO.setOriginFileName(file.getOriginalFileName());
				
				boardFileDTOList.add(boardFileDTO);
			}
			
			return boardFileDTOList;
	}
	
	/**
	  * @Method Name : findAllFree
	  * @작성일 : 2024. 3. 18.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 자유게시판 목록
	  */
	public List<BoardFree> findAllFree(AdminCriteria cri) {
		
		return adminBoardRepository.findAllFree(cri);
	}
	
	/**
	  * @Method Name : countAllFree
	  * @작성일 : 2024. 3. 18.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 자유게시판 카운팅
	  */
	public int countAllFree() {
		
		return adminBoardRepository.countAllFree();
	}
	
	/**
	  * @Method Name : deleteFree
	  * @작성일 : 2024. 3. 18.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 자유게시판 삭제
	  */
	@Transactional
	public boolean deleteFree(Integer id) {
		
		boolean result = adminBoardRepository.deleteFree(id);
		
		// 자유게시판 삭제 완료되면, 해당 글의 모든 댓글 삭제
		if(result == true) {
			adminBoardRepository.deleteCommentsByBoardFreeId(id);
		}
		
		return result;
	}
	
	/**
	  * @Method Name : findFreeById
	  * @작성일 : 2024. 3. 18.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 자유게시판 글보기
	  */
	public BoardFree findFreeById(Integer id) {
		
		return adminBoardRepository.findFreeById(id);
	}
	
	/**
	  * @Method Name : findAllFreeCommentByBoardFreeId
	  * @작성일 : 2024. 3. 18.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 자유게시판 댓글 목록
	  */
	public List<BoardFreeComment> findAllCommentByBoardFreeId(Integer boardFreeId) {
		
		return adminBoardRepository.findAllCommentByBoardFreeId(boardFreeId);
	}
	
	/**
	  * @Method Name : deleteComment
	  * @작성일 : 2024. 3. 18.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 자유게시판 댓글 삭제
	  */
	public boolean deleteComment(Integer id) {
		
		return adminBoardRepository.deleteComment(id);
	}
	
	/**
	  * @Method Name : findFreeFiles
	  * @작성일 : 2024. 3. 25.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 자유게시판 파일 목록
	  */
	@Transactional
	public List<BoardFileDTO> findFreeFiles(Integer id) {
		
		// free filePath 가져오기
		BoardFree Free = adminBoardRepository.findFreeById(id);
		String filePath = Free.getFilePath();
		System.out.println("!!!!!!!!!!!!!!!!!!!!!filePath : " + filePath);
		
		
		List<BoardFileDTO> boardFileDTOList = new ArrayList<>();
		
		// 파일 첨부 안했을 때 오류 발생하므로, filePath가 null이면
		if(filePath == null || filePath.isEmpty()) {
		
			return boardFileDTOList; // 바로 메서드 종료
		}
		 
		String[] filePaths = filePath.split(","); // split은 문자열 받아야하므로 ""
		log.info("filePaths : " + filePaths);
		
		for(int i=0 ; i<filePaths.length ; i++) {

			BoardFileDTO boardFileDTO = new BoardFileDTO();
			
			boardFileDTO.setFilePath(filePaths[i]);
			
			String uuid = filePaths[i].split("/")[5];
			Filedb file = fileDbRepository.findByUuid(uuid);
			boardFileDTO.setOriginFileName(file.getOriginalFileName());
			
			boardFileDTOList.add(boardFileDTO);
		}
		
		return boardFileDTOList;
}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	  * @Method Name : selectFile
	  * @작성일 : 2024. 3. 20.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 파일명 가져오기
	  */
	/*
	 * public Filedb findFileByUuid(String uuid) {
	 * 
	 * return fileDbRepository.findByUuid(uuid); }
	 */
	
}
