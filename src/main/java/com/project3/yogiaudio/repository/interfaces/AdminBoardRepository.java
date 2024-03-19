package com.project3.yogiaudio.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project3.yogiaudio.dto.admin.AdminCriteria;
import com.project3.yogiaudio.repository.entity.Music;
import com.project3.yogiaudio.repository.entity.User;
import com.project3.yogiaudio.repository.entity.board.BoardFree;
import com.project3.yogiaudio.repository.entity.board.BoardFreeComment;
import com.project3.yogiaudio.repository.entity.board.BoardNotice;
import com.project3.yogiaudio.repository.entity.board.BoardQna;
import com.project3.yogiaudio.repository.entity.board.BoardQnaReply;

@Mapper
public interface AdminBoardRepository {
	
	
	
	// 공지사항 목록
	public List<BoardNotice> findAllNotice(AdminCriteria cri);
	// 공지사항 카운팅
	public int countAllNotice();
	// 공지사항 삭제
	public boolean deleteNotice(Integer id);
	// 공지사항 글보기
	public BoardNotice findNoticeById(Integer id);

	// qna 목록
	public List<BoardQna> findAllQna(AdminCriteria cri);
	// qna 카운팅
	public int countAllQna();
	// qna 삭제
	public boolean deleteQna(Integer id);
	// qna 글보기
	public BoardQna findQnaById(Integer id);
	// qna 답변 등록
	public boolean insertQnaReply(BoardQnaReply boardQnaReply);
	// qna 답변 등록시 답변여부 Y 표시
	public void updateAnwerYnByInsertReply(Integer id);
	// qna 답변 목록
	public List<BoardQnaReply> findAllReplyByBoardQnaId(Integer boardQnaId);
	// qna 답변 삭제
	public boolean deleteReply(Integer id);
	// qna 답변 모두 삭제되면 답변여부 N 표시
	public void updateAnwerYnByDeleteReply(Integer id);
	// qna 삭제시 모든 답변 삭제
	public void deleteReplysByBoardQnaId(Integer boardQnaId);
	
	// 자유게시판 목록
	public List<BoardFree> findAllFree(AdminCriteria cri);
	// 자유게시판 카운팅
	public int countAllFree();
	// 자유게시판 삭제
	public boolean deleteFree(Integer id);
	// 자유게시판 글보기
	public BoardFree findFreeById(Integer id);
	// 자유게시판 댓글 목록
	public List<BoardFreeComment> findAllCommentByBoardFreeId(Integer boardFreeId);
	// 자유게시판 댓글 삭제
	public boolean deleteComment(Integer id);
	// 자유게시판 글 삭제시 모든 댓글 삭제
	public void deleteCommentsByBoardFreeId(Integer boardFreeId);
	
	// 공지사항 등록
	public boolean insertNotice(BoardNotice notice);
	
	
	
	
}
