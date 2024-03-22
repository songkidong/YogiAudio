package com.project3.yogiaudio.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project3.yogiaudio.dto.admin.AdminCriteria;
import com.project3.yogiaudio.dto.admin.NoticeSaveFormDTO;
import com.project3.yogiaudio.dto.admin.QnaSaveFormDTO;
import com.project3.yogiaudio.filedb.entity.Filedb;
import com.project3.yogiaudio.filedb.repository.FiledbRepository;
import com.project3.yogiaudio.filedb.service.FiledbService;
import com.project3.yogiaudio.repository.entity.board.BoardFree;
import com.project3.yogiaudio.repository.entity.board.BoardFreeComment;
import com.project3.yogiaudio.repository.entity.board.BoardNotice;
import com.project3.yogiaudio.repository.entity.board.BoardQna;
import com.project3.yogiaudio.repository.entity.board.BoardQnaReply;
import com.project3.yogiaudio.repository.interfaces.AdminBoardRepository;

@Service
public class AdminBoardService {

	@Autowired
	private AdminBoardRepository adminBoardRepository;
	
	@Autowired
	private FiledbService fileDbService;
	
	@Autowired
	private FiledbRepository fileDbRepository;
	
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
	  * @Method 설명 : 공지사항 등록 // @Transactional 처리 안해도 됨??
	  */
	@Transactional  
	public boolean insertNotice(NoticeSaveFormDTO dto) {
		
		// 단일 파일 업로드
		//String filePath = fileDbService.saveFiles(dto.getFilePath());
		// 다중 파일 업로드
		String filePath = fileDbService.saveFiles(dto.getFiles());
		
		BoardNotice notice = BoardNotice.builder()
						.writerId(100) // 작성자 아이디 임시번호
						.title(dto.getTitle())
						.content(dto.getContent())
						.filePath(filePath) // 타입 String
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
	public boolean updateNotice(Integer id, NoticeSaveFormDTO dto) {

		// 다중 파일 업로드
		String filePath = fileDbService.saveFiles(dto.getFiles());
		
		BoardNotice boardNotice = BoardNotice.builder()
							.title(dto.getTitle())
							.content(dto.getContent())
							.filePath(filePath)
							.build();
		
		return adminBoardRepository.updateNotice(id, boardNotice);
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
	public boolean insertQnaReply(Integer boardQnaId, QnaSaveFormDTO dto) {
		
		// 답변 등록
		BoardQnaReply boardQnaReply = BoardQnaReply.builder()
									.writerId(15) // 현재 사용자 정보로 수정하기
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
	  * @Method Name : selectFile
	  * @작성일 : 2024. 3. 20.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 파일명 가져오기
	  */
	public Filedb findFileByUuid(String uuid) {
		
		return fileDbRepository.findByUuid(uuid);
	}
	
	
	
	
	
}
