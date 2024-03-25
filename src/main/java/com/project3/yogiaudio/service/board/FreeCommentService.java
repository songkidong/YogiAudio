package com.project3.yogiaudio.service.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project3.yogiaudio.dto.board.FreeCommentDTO;
import com.project3.yogiaudio.repository.entity.board.BoardFree;
import com.project3.yogiaudio.repository.entity.board.BoardFreeComment;
import com.project3.yogiaudio.repository.interfaces.board.FreeCommentRepository;
import com.project3.yogiaudio.repository.interfaces.board.FreeRepository;

@Service
public class FreeCommentService {

	@Autowired
	private FreeCommentRepository freeCommentRepository;

	// 리스트
	public List<BoardFreeComment> selectFreeCommentList(int boardFreeId) {
		return freeCommentRepository.selectFreeCommentList(boardFreeId);
	}

	// 작성하기
	@Transactional
	public boolean freeCommentSave(FreeCommentDTO freeCommentDTO, int boardFreeId) {
		System.out.println("여기는서비스디티오"+freeCommentDTO);
		System.out.println("여기는서비스자게아이디"+boardFreeId);
		
		BoardFreeComment boardFreeComment = BoardFreeComment.builder().writerId(freeCommentDTO.getWriterId()).content(freeCommentDTO.getContent())
				.boardFreeId(boardFreeId).build();

		System.out.println("여기는서비스엔티티"+boardFreeComment);
		
		int result = freeCommentRepository.freeCommentSave(boardFreeComment);
		
		if (result == 1) {
			return true;
		}

		return false;
	}

	// 상세보기
	public BoardFreeComment freeCommentView(int boardFreeId) {

		System.out.println(" 서비스 " + boardFreeId);

		return freeCommentRepository.freeCommentView(boardFreeId);
	}
	
	// 삭제하기
	public boolean freeCommentDelete(int id) {

		int result = freeCommentRepository.freeCommentDelete(id);

		if (result == 1) {
			return true;
		}

		return false;
	}

}
