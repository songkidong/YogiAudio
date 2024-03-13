package com.project3.yogiaudio.service.board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project3.yogiaudio.dto.board.NoticeDTO;
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
	
	
	
}
