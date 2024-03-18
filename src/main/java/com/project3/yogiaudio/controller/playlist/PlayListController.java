package com.project3.yogiaudio.controller.playlist;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.project3.yogiaudio.dto.music.MusicDTO;
import com.project3.yogiaudio.dto.playlist.PlayListAddDTO;
import com.project3.yogiaudio.dto.playlist.PlayListDelteDTO;
import com.project3.yogiaudio.dto.playlist.PlayListSaveDTO;
import com.project3.yogiaudio.dto.playlist.PlayListStartDTO;
import com.project3.yogiaudio.dto.playlist.PlaylistAddRspDTO;
import com.project3.yogiaudio.filedb.service.FiledbService;
import com.project3.yogiaudio.repository.entity.User;
import com.project3.yogiaudio.repository.entity.playlist.Playlist;
import com.project3.yogiaudio.repository.entity.playlist.PlaylistOrder;
import com.project3.yogiaudio.service.MusicService;
import com.project3.yogiaudio.service.playlist.PlaylistOrderService;
import com.project3.yogiaudio.service.playlist.PlaylistService;
import com.project3.yogiaudio.util.Define;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

/**
 * @FileName : PlayListController.java
 * @Project : YogiAudio
 * @Date : 2024. 3. 13.
 * @작성자 : 최장호
 * @변경이력 :
 * @프로그램 설명 : 플레이리스트 컨트롤러
 */
@Controller
@Slf4j
public class PlayListController {
	@Autowired
	private MusicService musicService;

	@Autowired
	private PlaylistOrderService playlistOrderService;
	@Autowired
	private PlaylistService playlistService;
	@Autowired
	private HttpSession httpSession;

	@GetMapping("/test")
	public String test() {
		return "test";
	}

	/**
	 * @Method Name : musicPlayerPage
	 * @작성일 : 2024. 3. 16.
	 * @작성자 : 최장호
	 * @변경이력 :
	 * @Method 설명 : 음악플레이어 화면, default playlist 실행 // 1. 로그인한 user면 default 데이터 조회 후
	 *         넘기기
	 * @param model
	 * @return
	 */
	@GetMapping("/musicPlayer")
	public String musicPlayerPage(Model model) {
		User user = (User) httpSession.getAttribute(Define.PRINCIPAL);
		if (user != null) {
			List<PlayListStartDTO> playList = playlistService.readPlaylistByUserId(user.getId());
			if (playList != null && playList.isEmpty() == false) {
				model.addAttribute("playList", playList);
			}
		}
		return "musicPlayer";
	}

	@GetMapping("/test2")
	public String test2() {
		return "test2";
	}

	@GetMapping("/test3")
	public String test3() {
		return "test3";
	}
	
	@GetMapping("/test4")
	public String test4() {
		return "test4";
	}

	/**
	 * @Method Name : addPlayList
	 * @작성일 : 2024. 3. 16.
	 * @작성자 : 최장호
	 * @변경이력 :
	 * @Method 설명 : // 1. 플레이리스트에 노래저장 // 2. 저장된 노래 정보 반환
	 * @param input
	 * @return
	 */
	@PostMapping("/addPlayList")
	@ResponseBody
	public PlaylistAddRspDTO addPlayList(@RequestBody PlayListAddDTO input) {
		User user = (User)httpSession.getAttribute(Define.PRINCIPAL);
		PlaylistAddRspDTO playlistAddRspDTO = new PlaylistAddRspDTO();
		if(user != null) {
			// 1. 로그인 시 플레이리스트에 노래추가
			input.setUserId(user.getId());
			PlayListSaveDTO resultPlaylist = playlistService.savePlayList(input);
			playlistAddRspDTO.setPlaylistName(resultPlaylist.getPlaylistName());
			playlistAddRspDTO.setOrderIndex(resultPlaylist.getOrderIndex());
		}
		// 2. 추가된 노래 정보 반환
		MusicDTO musicDTO = musicService.readByMusicno((int) input.getMusicNo());
		playlistAddRspDTO.setFromMusicDTO(musicDTO);
		log.debug(playlistAddRspDTO.getPlaylistName());
		
		return playlistAddRspDTO;
	}

	/**
	  * @Method Name : deletePlayList
	  * @작성일 : 2024. 3. 17.
	  * @작성자 : 최장호
	  * @변경이력 : 
	  * @Method 설명 : playlist에서 삭제
	  * @param input
	  * @return
	  */
	@PostMapping("/deletePlayList")
	@ResponseBody
	public PlayListDelteDTO deletePlayList(@RequestBody PlayListDelteDTO input) {
		User user = (User)httpSession.getAttribute(Define.PRINCIPAL);
		if(user != null) {
			// 1. 로그인 시 플레이리스트에 노래추가
			input.setUserId(user.getId());
			int result = playlistService.deletePlayList(input);
		}
		return input;
	}
	
	@Autowired
	private FiledbService filedbService;

	@GetMapping("/testMusic")
	public String testMusic() {
		return "testMusic";
	}

	@PostMapping("/testFile")
	public void a(@RequestParam("file") MultipartFile file) {
		System.out.println("최장호");
		String fileMusic = filedbService.saveFiles(file);
		System.out.println("최장호");
		System.out.println(fileMusic);
	}
}
