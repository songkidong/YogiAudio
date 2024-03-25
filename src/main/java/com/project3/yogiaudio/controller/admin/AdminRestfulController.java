package com.project3.yogiaudio.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.project3.yogiaudio.dto.admin.NoticeSaveFormDTO;
import com.project3.yogiaudio.dto.admin.QnaReplySaveFormDTO;
import com.project3.yogiaudio.filedb.entity.Filedb;
import com.project3.yogiaudio.filedb.service.FiledbService;
import com.project3.yogiaudio.repository.entity.board.BoardQna;
import com.project3.yogiaudio.service.AdminBoardService;
import com.project3.yogiaudio.service.AdminService;

import lombok.extern.log4j.Log4j2;

@Log4j2
@RestController
@RequestMapping("/admin")
public class AdminRestfulController {

	@Autowired
	private AdminService adminService;
	
	@Autowired
	private AdminBoardService adminBoardService;
	
	// 유저 탈퇴
	@PostMapping("/user/{id}")
	public ResponseEntity<?> withdrawUser(@PathVariable("id") Integer id) {
		
		boolean result = adminService.withdrawUser(id);
		
		return new ResponseEntity<Boolean>(result, HttpStatus.OK);
	}
	
	// 음악 삭제 / music entity의 musicNo 타입이 int인데, Integer로 해도 상관없음
	@DeleteMapping("/music/{musicNo}")
	public ResponseEntity<?> deleteMusic(@PathVariable("musicNo") Integer musicNo) {
		
		//log.info("musicNo : " + musicNo);
		boolean result = adminService.deleteMusic(musicNo);
		
		return new ResponseEntity<Boolean>(result, HttpStatus.OK);
	}
	
	// 공지사항 삭제
	@DeleteMapping("/notice/{id}")
	public ResponseEntity<?> deleteNotice(@PathVariable("id") Integer id) {
		
		boolean result = adminBoardService.deleteNotice(id);
		
		return new ResponseEntity<Boolean>(result, HttpStatus.OK);
	}
	
	// 공지사항 등록
	@PostMapping("/notice")
	public ResponseEntity<?> insertNotice(NoticeSaveFormDTO dto) {
		
		log.info("dto : " + dto);
		log.info("files : " + dto.getFiles());
		boolean result = adminBoardService.insertNotice(dto);
		
		return new ResponseEntity<Boolean>(result, HttpStatus.OK);
	}
	
	// 공지사항 수정 // 등록이랑 매핑 주소 같은데 pathvariable 방식으로 구분될 수 있는가요?? O
	@PostMapping("/notice/{id}")
	public ResponseEntity<?> updateNotice(@PathVariable("id") Integer id, NoticeSaveFormDTO dto) {
		
		log.info("id : " + id);
		log.info("dto : " + dto);
		
		boolean result = adminBoardService.updateNotice(id, dto);
		
		return new ResponseEntity<Boolean>(result, HttpStatus.OK);
	}
	
	// qna 삭제
	@DeleteMapping("/qna/{id}")
	public ResponseEntity<?> deleteQna(@PathVariable("id") Integer id) {
		
		boolean result = adminBoardService.deleteQna(id);
		
		return new ResponseEntity<Boolean>(result, HttpStatus.OK);
	}
	
	// qna 답변 등록
	@PostMapping("/reply")
	public ResponseEntity<?> insertQnaReply(@RequestParam("boardQnaId") Integer boardQnaId, QnaReplySaveFormDTO dto) {
		
		boolean result = adminBoardService.insertQnaReply(boardQnaId, dto);
		
		return new ResponseEntity<Boolean>(result, HttpStatus.OK);
	}
	
	// qna 답변 삭제 
	// ajax 데이터 받을 때 어노테이션 없을 때 됐던 적도 있는데, 안되는 상황이 발생하는 경우도 있어서 RequestParam 사용하자
	// Long 타입 아니라도 실행됨
	@DeleteMapping("/reply/{id}")
	public ResponseEntity<?> deleteReply(@PathVariable("id") Integer id, @RequestParam("boardQnaId") Integer boardQnaId) {
		
		log.info("boardQnaId : " + boardQnaId);
		
		boolean result = adminBoardService.deleteReply(id, boardQnaId); 
		
		return new ResponseEntity<Boolean>(result, HttpStatus.OK);
	}
	
	// qna 답변 수정
	@PostMapping("/reply/{id}")
	public ResponseEntity<?> updateReply(@PathVariable("id") Integer id, QnaReplySaveFormDTO dto) {

		log.info("dto : " + dto);
		boolean result = adminBoardService.updateReply(id, dto);
		
		return new ResponseEntity<Boolean>(result, HttpStatus.OK);
	}
	
	
	// 자유게시판 삭제 / Long 타입인데 Integer로 받아도 실행됨!
	@DeleteMapping("/free/{id}")
	public ResponseEntity<?> deleteFree(@PathVariable("id") Integer id) {
		
		boolean result = adminBoardService.deleteFree(id);
		
		return new ResponseEntity<Boolean>(result, HttpStatus.OK);
	}
	
	// 자유게시판 댓글 삭제
	@DeleteMapping("/comment/{id}")
	public ResponseEntity<?> deleteComment(@PathVariable("id") Integer id) {
		
		boolean result = adminBoardService.deleteComment(id);
		
		return new ResponseEntity<Boolean>(result, HttpStatus.OK);
	}
	
	// 환불 승인
	@PostMapping("/refund/{id}")
	public ResponseEntity<?> updateRefund(@PathVariable("id") Integer id,
										@RequestParam("userId") Integer userId, 
										@RequestParam("amount") Integer amount, 
										@RequestParam("pNo") Integer pNo) {
		
		log.info("id : " + id);
		log.info("userId : " + userId);
		log.info("amount : " + amount);
		log.info("pNo : " + pNo);
		
		boolean result = adminService.updateRefund(id, userId, amount, pNo);
		
		return new ResponseEntity<Boolean>(result, HttpStatus.OK);
	}
	
	
	
	
	// 파일명 가져오기
		/*
		 * @GetMapping("/file") public ResponseEntity<?>
		 * findFileByUuid(@RequestParam("uuid") String uuid) {
		 * 
		 * log.info("uuid : " + uuid);
		 * 
		 * Filedb file = adminBoardService.findFileByUuid(uuid);
		 * 
		 * return new ResponseEntity<Filedb>(file, HttpStatus.OK); }
		 */
}
