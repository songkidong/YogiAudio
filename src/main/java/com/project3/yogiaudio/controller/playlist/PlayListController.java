package com.project3.yogiaudio.controller.playlist;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project3.yogiaudio.dto.playlist.PlayListAddDTO;
import com.project3.yogiaudio.dto.playlist.PlayListStartDTO;
import com.project3.yogiaudio.repository.entity.playlist.PlaylistOrder;
import com.project3.yogiaudio.service.MusicService;
import com.project3.yogiaudio.service.playlist.PlaylistOrderService;
import com.project3.yogiaudio.service.playlist.PlaylistService;

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
	
	@GetMapping("/test")
	public String test() {
		return "test";
	}
	@GetMapping("/musicPlayer")
	public String musicPlayerPage(Model model) {
		long id = 1;
//		// 여기서 플레이리스트 정보 가져와서 세팅해야함.
		List<PlayListStartDTO> playList = playlistService.readPlaylistById(id);
		model.addAttribute("playList" , playList);
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
	
	@PostMapping("/addPlayList")
	@ResponseBody
	public String addPlayList(@RequestBody PlayListAddDTO input) {
		playlistService.savePlayList(input);
		return "이거 추가 되었습니다" + input;
	}
}
