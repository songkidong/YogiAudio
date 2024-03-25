package com.project3.yogiaudio.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project3.yogiaudio.dto.admin.AdminCriteria;
import com.project3.yogiaudio.dto.admin.AdminPageVO;
import com.project3.yogiaudio.dto.board.BoardFileDTO;
import com.project3.yogiaudio.dto.music.MusicDTO;
import com.project3.yogiaudio.dto.music.MusicVideoDTO;
import com.project3.yogiaudio.filedb.service.FiledbService;
import com.project3.yogiaudio.repository.entity.History;
import com.project3.yogiaudio.repository.entity.Music;
import com.project3.yogiaudio.repository.entity.Refund;
import com.project3.yogiaudio.repository.entity.User;
import com.project3.yogiaudio.repository.entity.board.BoardFree;
import com.project3.yogiaudio.repository.entity.board.BoardFreeComment;
import com.project3.yogiaudio.repository.entity.board.BoardNotice;
import com.project3.yogiaudio.repository.entity.board.BoardQna;
import com.project3.yogiaudio.repository.entity.board.BoardQnaReply;
import com.project3.yogiaudio.service.AdminBoardService;
import com.project3.yogiaudio.service.AdminService;
import com.project3.yogiaudio.service.MusicService;
import com.project3.yogiaudio.service.MusicVideoService;
import com.project3.yogiaudio.util.Define;

import jakarta.servlet.http.HttpSession;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
@RequestMapping("/admin")
public class AdminController {

	// Autowired에 final 선언
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private AdminBoardService adminBoardService;
	
	@Autowired
	private HttpSession session;
	
	@Autowired
	private MusicService musicService;
	
	@Autowired
	private MusicVideoService musicVideoService;
	
	@Autowired
	private FiledbService filedbService;


	// 인덱스
	@GetMapping("/index")
	public String indexPage(Model model) {
		
		//User principal = (User) session.getAttribute(Define.PRINCIPAL);
		User principal = (User) session.getAttribute(Define.PRINCIPAL);
		model.addAttribute("principal", principal);
		
		
		// qna 목록 최신 10개
		AdminCriteria cri = new AdminCriteria();
		List<BoardQna> qnaList = adminBoardService.findAllQna(cri);
		model.addAttribute("qnaList", qnaList);
		
		// 회원 수
		int userCountByUserRole = adminService.countAllUserByUserRole();
		model.addAttribute("userCountByUserRole", userCountByUserRole);
		
		// 음악 수
		int musicCount = adminService.countAllMusic();
		model.addAttribute("musicCount", musicCount);
		
		// 뮤직비디오 수
		int musicvideoCount = adminService.countAllMusicVideo();
		model.addAttribute("musicvideoCount", musicvideoCount);
		
		// 환불 내역 수
		int incompletedRefundCount = adminService.countAllIncompletedRefund();
		model.addAttribute("incompletedRefundCount", incompletedRefundCount);
		
		return "admin/index";
	}

	// 유저 목록
	// Criteria는 쿼리문에서 데이터를 가져올 때와 페이징처리를 하기 위함, 2가지 경우를 위해 쓰인다!
	@GetMapping("/userList")
	public String userListPage(AdminCriteria cri, Model model) {
		
		// Criteria의 page값을 1로 정해놓는 이유가 있다 -> 처음 목록페이지 들어올 때 1페이지, offset은 0
		List<User> userList = adminService.findAllUser(cri);
		log.info("userList" + userList);
		
		if(userList.isEmpty()) {
			model.addAttribute("userList", null);
		}else {
			model.addAttribute("userList", userList);
		}
		
		// 화면에 출력하기 위한 페이징 로직
		AdminPageVO pageVO = new AdminPageVO();
		// 페이지 번호 클릭할 때 파라미터 보낸 것을 AdminCriteria 매개변수로 받아서 set
		pageVO.setCri(cri);
		pageVO.setTotalCount(adminService.countAllUser());
		model.addAttribute("pageVO", pageVO);
		 
		return "admin/userList";
	}
	
	// 음악 목록
	@GetMapping("/musicList")
	public String musicListPage(AdminCriteria cri, Model model) {
		
		// 한 페이징 당 게시글 수 변경
		cri.setPageSize(8);
		// Criteria의 page값을 1로 정해놓는 이유가 있다 -> 처음 목록페이지 들어올 때 1페이지, offset은 0
		List<Music> musicList = adminService.findAllMusic(cri);
		
		if(musicList.isEmpty()) {
			model.addAttribute("musicList", null);
		}else {
			model.addAttribute("musicList", musicList);
		}
		
		
		
		AdminPageVO pageVO = new AdminPageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(adminService.countAllMusic());
		model.addAttribute("pageVO", pageVO);
		
		
		return "admin/musicList";
	}
	
	//뮤비리스트
	@GetMapping("/musicvideoList")
	public String mvListPage(AdminCriteria cri, Model model) {
		
		cri.setPageSize(12);
		List<MusicVideoDTO> musicvideoList = adminService.findAllMusicVideo(cri);
		
		if(musicvideoList.isEmpty()) {
			model.addAttribute("musicvideoList", null);
		}else {
			model.addAttribute("musicvideoList", musicvideoList);
		}
		
		AdminPageVO pageVO = new AdminPageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(adminService.countAllMusicVideo());
		model.addAttribute("pageVO", pageVO);
		
		
		return "admin/mvList";
	}
	
	
	
	// 공지사항 목록
	@GetMapping("/noticeList")
	public String noticeListPage(AdminCriteria cri, Model model) {
		
		List<BoardNotice> noticeList = adminBoardService.findAllNotice(cri);
		
		if(noticeList.isEmpty()) {
			model.addAttribute("noticeList", null);
		}else {
			model.addAttribute("noticeList", noticeList);
		}
		
		AdminPageVO pageVO = new AdminPageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(adminBoardService.countAllNotice());
		model.addAttribute("pageVO", pageVO);
		
		return "admin/noticeList";
	}
	
	// 공지사항 글보기
	@GetMapping("/noticeView/{id}")
	public String noticeViewPage(@PathVariable("id") Integer id, Model model) {
		
		BoardNotice notice = adminBoardService.findNoticeById(id);
		model.addAttribute("notice", notice);
		
		// 파일 목록
		List<BoardFileDTO> BoardFileDTOList = adminBoardService.findNoticeFiles(id);
		log.info("BoardFileDTOList " + BoardFileDTOList );
		model.addAttribute("BoardFileDTOList", BoardFileDTOList);
		
		return "admin/noticeView";
	}
	
	// 공지사항 수정하기
	@GetMapping("/updateNotice/{id}")
	public String updateNoticePage(@PathVariable("id") Integer id, Model model) {
		
		BoardNotice notice = adminBoardService.findNoticeById(id);
		model.addAttribute("notice", notice);
		
		// 파일 목록
		List<BoardFileDTO> BoardFileDTOList = adminBoardService.findNoticeFiles(id);
		log.info("BoardFileDTOList " + BoardFileDTOList );
		model.addAttribute("BoardFileDTOList", BoardFileDTOList);
		
		return "admin/updateNotice";
	}
	
	// qna 목록
	@GetMapping("/qnaList")
	public String qnaListPage(AdminCriteria cri, Model model) {
		
		List<BoardQna> qnaList = adminBoardService.findAllQna(cri);
		model.addAttribute("qnaList", qnaList);
		
		AdminPageVO pageVO = new AdminPageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(adminBoardService.countAllQna());
		model.addAttribute("pageVO", pageVO);
		
		return "admin/qnaList";
	}
	
	// qna 글보기
	@GetMapping("/qnaView/{id}")
	public String qnaViewPage(@PathVariable("id") Integer id, Model model) {
		
		BoardQna qna = adminBoardService.findQnaById(id);
		model.addAttribute("qna", qna);
		
		// 답변 목록
		List<BoardQnaReply> replyList = adminBoardService.findAllReplyByBoardQnaId(id);
		model.addAttribute("replyList", replyList);
		
		// 파일 목록
		List<BoardFileDTO> BoardFileDTOList = adminBoardService.findQnaFiles(id);
		log.info("BoardFileDTOList " + BoardFileDTOList );
		model.addAttribute("BoardFileDTOList", BoardFileDTOList);
		
		return "admin/qnaView";
	}
	
	// 자유게시판 목록
	@GetMapping("/freeList")
	public String freeListPage(AdminCriteria cri, Model model) {
		
		List<BoardFree> freeList = adminBoardService.findAllFree(cri);
		model.addAttribute("freeList", freeList);
		
		AdminPageVO pageVO = new AdminPageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(adminBoardService.countAllFree());
		model.addAttribute("pageVO", pageVO);
		
		return "/admin/freeList";
	}
	
	// 자유게시판 글보기
	@GetMapping("/freeView/{id}")
	public String freeViewPage(@PathVariable("id") Integer id, Model model) {
		
		BoardFree free = adminBoardService.findFreeById(id);
		model.addAttribute("free", free);
		
		// 댓글 목록
		List<BoardFreeComment> commentList = adminBoardService.findAllCommentByBoardFreeId(id);
		log.info("로그!!!!!! commentList : " + commentList);
		model.addAttribute("commentList", commentList);
		
		// 파일 목록
		List<BoardFileDTO> BoardFileDTOList = adminBoardService.findFreeFiles(id);
		log.info("BoardFileDTOList " + BoardFileDTOList );
		model.addAttribute("BoardFileDTOList", BoardFileDTOList);
		
		return "admin/freeView";
	}
	
	// 공지사항 등록
	@GetMapping("/saveNotice")
	public String saveNoticePage() {
		
		return "admin/saveNotice";
	}
	
	// 결제 내역
	@GetMapping("/historyList")
	public String historyListPage(AdminCriteria cri, Model model) {
		
		List<History> historyList = adminService.findAllHistory(cri);
		log.info("historyList : " + historyList);
		model.addAttribute("historyList", historyList);
		
		AdminPageVO pageVO = new AdminPageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(adminService.countAllHistory());
		model.addAttribute("pageVO", pageVO);
		
		return "admin/historyList";
	}
	
	// 환불 내역
	@GetMapping("/refundList")
	public String refundListPage(AdminCriteria cri, Model model) {
		
		List<Refund> refundList = adminService.findAllRefund(cri);
		model.addAttribute("refundList", refundList);
		
		AdminPageVO pageVO = new AdminPageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(adminService.countAllRefund());
		model.addAttribute("pageVO", pageVO);
		
		return "admin/refundList";
	}
	
	
	// 음악등록(GET)
	@GetMapping("/music-insert")
	public String musicInsertGET() {
		log.debug("음원등록페이지(관리자)실행!");
		return"admin/musicinsert";
	}
	
	
	// 뮤비등록(GET)
	@GetMapping("/mv-insert")
	public String mvInsertGET() {
		log.debug("뮤비등록페이지(관리자)실행!");
		return "admin/mvinsert";
	}
	
	
	
	// 음악등록(POST)
	@PostMapping("/music-insert")
	public String musicInsertPOST(MusicDTO dto) {
		
		String fileMusic = filedbService.saveFiles(dto.getFiles());
		String musicSample = filedbService.saveFiles(dto.getFiles());
		String filePath = filedbService.saveFiles(dto.getFiles2());
		
		adminService.insertMusic(dto, filePath, fileMusic, musicSample);
		
		
		log.debug("음악등록완료!");
		
		return "redirect:/admin/musicList";
	}
	
	
	// 뮤비등록(POST)
	@PostMapping("/mv-insert")
	public String mvinsertPOST(MusicVideoDTO dto) {
		
		String filePath = filedbService.saveFiles(dto.getFiles());
		adminService.insertMusicVideo(dto, filePath);
		
		log.debug("뮤비등록완료!");
		
		return "redirect:/admin/musicvideoList";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}
