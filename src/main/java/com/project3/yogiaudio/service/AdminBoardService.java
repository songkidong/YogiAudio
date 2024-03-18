package com.project3.yogiaudio.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project3.yogiaudio.dto.admin.AdminCriteria;
import com.project3.yogiaudio.dto.admin.NoticeSaveFormDTO;
import com.project3.yogiaudio.dto.board.NoticeDTO;
import com.project3.yogiaudio.filedb.service.FiledbService;
import com.project3.yogiaudio.repository.entity.Music;
import com.project3.yogiaudio.repository.entity.User;
import com.project3.yogiaudio.repository.entity.board.BoardFree;
import com.project3.yogiaudio.repository.entity.board.BoardFreeComment;
import com.project3.yogiaudio.repository.entity.board.BoardNotice;
import com.project3.yogiaudio.repository.entity.board.BoardQna;
import com.project3.yogiaudio.repository.interfaces.AdminRepository;

@Service
public class AdminBoardService {

	@Autowired
	AdminRepository adminRepository;
	
	@Autowired
	FiledbService fileDbService;
	
	/**
	  * @Method Name : findAllNotice
	  * @작성일 : 2024. 3. 13.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 공지사항 목록
	  */
	public List<BoardNotice> findAllNotice(AdminCriteria cri) {
		
		return adminRepository.findAllNotice(cri);
	}
	
	/**
	  * @Method Name : countAllNotice
	  * @작성일 : 2024. 3. 13.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 공지사항 카운팅
	  */
	public int countAllNotice() {
		
		return adminRepository.countAllNotice();
	}
	
	/**
	  * @Method Name : deleteNotice
	  * @작성일 : 2024. 3. 13.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 공지사항 삭제
	  */
	public boolean deleteNotice(Integer id) {
		
		return adminRepository.deleteNotice(id);
	}
	
	/**
	  * @Method Name : findNoticeById
	  * @작성일 : 2024. 3. 15.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 공지사항 글보기
	  */
	public BoardNotice findNoticeById(Integer id) {
		
		return adminRepository.findNoticeById(id);
	}
	
	/**
	  * @Method Name : findAllQna
	  * @작성일 : 2024. 3. 14.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : qna 목록
	  */
	public List<BoardQna> findAllQna(AdminCriteria cri) {
		
		return adminRepository.findAllQna(cri);
	}
	
	/**
	  * @Method Name : countAllQna
	  * @작성일 : 2024. 3. 14.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : qna 카운팅
	  */
	public int countAllQna() {
		
		return adminRepository.countAllQna();
	}
	
	/**
	  * @Method Name : deleteQna
	  * @작성일 : 2024. 3. 14.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : qna 삭제
	  */
	public boolean deleteQna(Integer id) {
		
		return adminRepository.deleteQna(id);
	}
	
	/**
	  * @Method Name : findAllFree
	  * @작성일 : 2024. 3. 18.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 자유게시판 목록
	  */
	public List<BoardFree> findAllFree(AdminCriteria cri) {
		
		return adminRepository.findAllFree(cri);
	}
	
	/**
	  * @Method Name : countAllFree
	  * @작성일 : 2024. 3. 18.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 자유게시판 카운팅
	  */
	public int countAllFree() {
		
		return adminRepository.countAllFree();
	}
	
	/**
	  * @Method Name : deleteFree
	  * @작성일 : 2024. 3. 18.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 자유게시판 삭제
	  */
	public boolean deleteFree(Integer id) {
		
		// 해당 글의 모든 댓글 삭제
		adminRepository.deleteCommentsByBoardFreeId(id);
		
		return adminRepository.deleteFree(id);
	}
	
	/**
	  * @Method Name : findFreeById
	  * @작성일 : 2024. 3. 18.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 자유게시판 글보기
	  */
	public BoardFree findFreeById(Integer id) {
		
		return adminRepository.findFreeById(id);
	}
	
	/**
	  * @Method Name : findAllFreeCommentByBoardFreeId
	  * @작성일 : 2024. 3. 18.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 자유게시판 댓글 목록
	  */
	public List<BoardFreeComment> findAllCommentByBoardFreeId(Integer boardFreeId) {
		
		return adminRepository.findAllCommentByBoardFreeId(boardFreeId);
	}
	
	/**
	  * @Method Name : deleteComment
	  * @작성일 : 2024. 3. 18.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 자유게시판 댓글 삭제
	  */
	public boolean deleteComment(Integer id) {
		
		return adminRepository.deleteComment(id);
	}
	
	
	/**
	  * @Method Name : insertNotice
	  * @작성일 : 2024. 3. 14.
	  * @작성자 : 박한산
	  * @변경이력 : 
	  * @Method 설명 : 공지사항 등록
	  */
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
		
		return adminRepository.insertNotice(notice);
	}
	
	
	
	
}
