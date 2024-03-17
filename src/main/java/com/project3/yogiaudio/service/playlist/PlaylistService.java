package com.project3.yogiaudio.service.playlist;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project3.yogiaudio.dto.playlist.PlayListAddDTO;
import com.project3.yogiaudio.dto.playlist.PlayListDelteDTO;
import com.project3.yogiaudio.dto.playlist.PlayListSaveDTO;
import com.project3.yogiaudio.dto.playlist.PlayListStartDTO;
import com.project3.yogiaudio.repository.entity.playlist.Playlist;
import com.project3.yogiaudio.repository.entity.playlist.PlaylistOrder;
import com.project3.yogiaudio.repository.interfaces.playlist.PlaylistRepository;
import com.project3.yogiaudio.util.Define;

import lombok.extern.slf4j.Slf4j;

/**
 * @FileName : PlaylistService.java
 * @Project : YogiAudio
 * @Date : 2024. 3. 12.
 * @작성자 : 최장호
 * @변경이력 :
 * @프로그램 설명 : playlist 서비스
 */
@Service
@Slf4j
public class PlaylistService {

	@Autowired
	private PlaylistRepository playlistRepository;
	@Autowired
	private PlaylistOrderService playlistOrderService;

	/**
	  * @Method Name : readPlaylistByUserId
	  * @작성일 : 2024. 3. 17.
	  * @작성자 : 최장호
	  * @변경이력 : 
	  * @Method 설명 : 
	  * @param userId
	  * @return
	  */
	public List<PlayListStartDTO> readPlaylistByUserId(long userId) {
		Map<String, Object> params = new HashMap<>();
		params.put("userId", userId);
		params.put("playlistName", Define.PLAYLIST_DEFAULT);
		// default 플레이리스트 유무 확인
		Playlist defaultPlaylist = playlistRepository.findByUserIdAndPlaylistName(params);
		List<PlayListStartDTO> playList = new ArrayList<>();
		if (defaultPlaylist != null) {
			playList = playlistRepository.findPlayListById(defaultPlaylist.getId());
		}
		return playList;
	}

	public int delete(long id) {
		return playlistRepository.delete(id);
	}

	/**
	 * @Method Name : savePlayList
	 * @작성일 : 2024. 3. 16.
	 * @작성자 : 최장호
	 * @변경이력 :
	 * @Method 설명 : 
	 * // 1. playlist 이름 없으면 default 값 세팅 
	 * // 2. playlist + userId 로 playlist 찾기 
	 * // 2-1. 만약 playlist가 없으면 새로 추가함. 
	 * // 3. playlist_id로 playlist_order 조회 후 index (마지막 번호 + 1) 노래 추가하기 
	 * // 3-1. 만약 playlist_id로 찾은 결과 없으면 새로 추가하기. 번호 1부터 시작
	 * @param input
	 * @return
	 */
	@Transactional
	public PlayListSaveDTO savePlayList(PlayListAddDTO input) {
		int result = 0;
		PlayListSaveDTO returnDTO = new PlayListSaveDTO();
		// 1. playlist 이름 없으면 default 값 세팅
		if (input.getPlaylistName() == null || input.getPlaylistName().isEmpty()) {
			input.setPlaylistName(Define.PLAYLIST_DEFAULT);
		}
		// 2. playlist + userId 로 playlist 찾기
		Map<String, Object> params = new HashMap<>();
		params.put("userId", input.getUserId());
		params.put("playlistName", input.getPlaylistName());
		Playlist playlist = playlistRepository.findByUserIdAndPlaylistName(params);
		// 2-1. 만약 playlist가 없으면 새로 추가함.
		if (playlist == null) {
			Playlist newPlaylist = Playlist.builder().playlistName(input.getPlaylistName()).userId(input.getUserId())
					.build();
			result = playlistRepository.insert(newPlaylist);
			if (result == 0) {
				throw new DataAccessException("Failed to insert playlist") {
				};
			}
			playlist = new Playlist();
			playlist.setId(newPlaylist.getId());
			playlist.setPlaylistName(newPlaylist.getPlaylistName());
		}
		// 3. playlist_id로 playlist_order 조회 후 index (마지막 번호 + 1) 노래 추가하기
		PlaylistOrder playlistOrder = playlistOrderService.readLastByplaylistId(playlist.getId());
		if (playlistOrder != null) {
			// playlist의 가장 마지막 순서에 추가됨.
			int addIndex = playlistOrder.getOrderIndex() + 1;
			PlaylistOrder addPlaylistOrder = PlaylistOrder.builder().playlistId(playlist.getId())
					.musicNo(input.getMusicNo()).orderIndex(addIndex).build();
			result = playlistOrderService.addList(addPlaylistOrder);
			if (result == 0) {
				throw new DataAccessException("Failed to insert playlist") {
				};
			}
			returnDTO.setOrderIndex(addPlaylistOrder.getOrderIndex());
			// 3-1. 만약 playlist_id로 찾은 결과 없으면 새로 추가하기. 번호 1부터 시작
		} else {
			PlaylistOrder newPlaylistOrder = PlaylistOrder.builder().playlistId(playlist.getId())
					.musicNo(input.getMusicNo()).orderIndex(1).build();
			result = playlistOrderService.addList(newPlaylistOrder);
			if (result == 0) {
				throw new DataAccessException("Failed to insert playlist") {
				};
			}
			returnDTO.setOrderIndex(newPlaylistOrder.getOrderIndex());
		}
		returnDTO.setId(playlist.getId());
		returnDTO.setPlaylistName(playlist.getPlaylistName());
		return returnDTO;
	}

	/**
	  * @Method Name : deletePlayList
	  * @작성일 : 2024. 3. 17.
	  * @작성자 : 최장호
	  * @변경이력 : 
	  * @Method 설명 :
		// 1.playlist 조회 후 playlist_id
		// 2. playlist_id, index로 playlist_order 삭제하기
	  * @param input
	  * @return
	  */
	@Transactional
	public int deletePlayList(PlayListDelteDTO input) {
		Map<String, Object> playlistParams = new HashMap<>();
		playlistParams.put("userId", input.getUserId());
		playlistParams.put("playlistName", input.getPlaylistName());

		Playlist playlist = playlistRepository.findByUserIdAndPlaylistName(playlistParams);
		if(playlist == null) {
			throw new DataAccessException("Failed to insert playlist") {};
		}
		Map<String, Object> deleteParams = new HashMap<>();
		deleteParams.put("playlistId", playlist.getId());
		deleteParams.put("orderIndex", input.getOrderIndex());
		deleteParams.put("musicNo", input.getMusicNo());

		int result = playlistOrderService.deleteByIndex(deleteParams);
		
		return result;
	}
}
