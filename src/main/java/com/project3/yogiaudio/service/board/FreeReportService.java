package com.project3.yogiaudio.service.board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project3.yogiaudio.dto.board.BoardFreeReportDTO;
import com.project3.yogiaudio.repository.entity.board.BoardFreeReport;
import com.project3.yogiaudio.repository.interfaces.board.FreeReportRepository;

@Service
public class FreeReportService {

	@Autowired
	private FreeReportRepository freeReportRepository;

	/**
	 * @Method Name : saveBoardFreeReport
	 * @작성일 : 2024. 3. 25.
	 * @작성자 : 노수현
	 * @변경이력 :
	 * @Method 설명 : 게시판 신고하기
	 */
	public int saveBoardFreeReport(BoardFreeReportDTO boardFreeReportDTO) {

		BoardFreeReport boardFreeReport = BoardFreeReport.builder().targetType(boardFreeReportDTO.getTargetType()).targetId(boardFreeReportDTO.getTargetId())
				.targetUserId(boardFreeReportDTO.getTargetUserId()).userId(boardFreeReportDTO.getUserId()).reportReason(boardFreeReportDTO.getReportReason()).build();

		int result = freeReportRepository.insertFreeBoardReport(boardFreeReport);
		
		return result;
	}
	
	/**
	  * @Method Name : checkReport
	  * @작성일 : 2024. 3. 25.
	  * @작성자 : 노수현
	  * @변경이력 : 
	  * @Method 설명 : 게시글 신고 중복 확인
	  */
	public String checkReport(BoardFreeReportDTO boardFreeReportDTO) {
		String result = "success";
		
		BoardFreeReport boardFreeReport = freeReportRepository.checkReport(boardFreeReportDTO);
		if(boardFreeReport == null) {
			result = "fail";
		}
		
		return result;
		
	}
	
}
