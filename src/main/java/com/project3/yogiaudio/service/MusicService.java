package com.project3.yogiaudio.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project3.yogiaudio.dto.common.Criteria;
import com.project3.yogiaudio.dto.music.MusicDTO;
import com.project3.yogiaudio.repository.interfaces.MusicRepository;

@Service
public class MusicService {
	
	@Autowired
	private MusicRepository musicRepository;
	
	//국내음악리스트 출력하기
	public List<MusicDTO> domesticListAll(Criteria cri) throws Exception{
		List<MusicDTO> result = musicRepository.domesticListAll(cri);
		return result;
	}
	
	
	//국내음악리스트 카운팅하기
	public int countdomesticListAll() throws Exception{
		return musicRepository.countdomesticListAll();

	}

	
	//국내음악리스트(조건) 출력하기
	public List<MusicDTO> searchDmusicList(Criteria cri) throws Exception{
		List<MusicDTO> result = musicRepository.searchDmusicList(cri);
		return result;
	}

	
	//국내음악리스트(조건) 카운팅하기
	public Integer countsearchDmusicList(Criteria cri) throws Exception{
		return musicRepository.countsearchDmusicList(cri);
	}
	
	//국외음악리스트(조건) 출력하기
	public List<MusicDTO> searchAmusicList(Criteria cri) throws Exception{
		List<MusicDTO> result = musicRepository.searchAmusicList(cri);
		return result;
	}
	
	//국외음악리스트(조건) 카운팅하기
	public int countsearchAmusicList(Criteria cri) throws Exception{
		return musicRepository.countsearchAmusicList(cri);
	}
	
	
	//국외음악리스트 출력하기
	public List<MusicDTO> aboardListAll(Criteria cri) throws Exception{
		List<MusicDTO> result = musicRepository.aboardListAll(cri);
		return result;
	}
	
	
	//국외음악리스트 카운팅하기
	public int countaboardListAll() throws Exception{
		return musicRepository.countaboardListAll();		
	}
	
	
	//국내음악 디테일
	public MusicDTO domesticDetail(@Param(value = "musicno") int musicno, @Param(value = "musicmajor") String musicmajor) {
		return musicRepository.domesticDetail(musicno,musicmajor);
	}

	
	//국외음악 디테일
	public MusicDTO aboardDetail(@Param(value = "musicno") int musicno, @Param(value = "musicmajor") String musicmajor) {
		return musicRepository.aboardDetail(musicno, musicmajor);
	}
	
	
	//앨범자켓바꾸기
	@Transactional
	public void albumUpdate(MusicDTO dto,String filePath) {
		
		MusicDTO music = MusicDTO.builder()
				.musicno(dto.getMusicno())
				.filepath(filePath)
				.build();
		
		Integer result = musicRepository.albumUpdate(music);
		
	}
	
	
	//좋아요 업데이트하기
	@Transactional
	public void likeit(MusicDTO dto,@Param(value = "musicno") int musicno, @Param(value = "musicmajor") String musicmajor) {
		
		MusicDTO music = MusicDTO.builder()
				.likeit(dto.getLikeit())
				.build();
		
		int result = musicRepository.likeit(music, musicno, musicmajor);
	}

	
	//음원등록하기
	@Transactional
	public void musicUpdate(MusicDTO dto,String fileMusic) {
		
		MusicDTO music = MusicDTO.builder()
				.musicno(dto.getMusicno())
				.filemusic(fileMusic)
				.build();
		
		Integer result = musicRepository.musicUpdate(music);
		
	}
	
	
	
	
	//최신순으로 출력하기
	public List<MusicDTO> newMusicList(Criteria cri) throws Exception{
		List<MusicDTO> result = musicRepository.newMusicList(cri);
		return result;
	}
	
	
	//최신음악리스트 전부출력하기
	public List<MusicDTO> newListAll(Criteria cri) throws Exception{
		List<MusicDTO> result = musicRepository.newListAll(cri);
		return result;
	}

	
	//최신음악리스트 전부(카운팅) 하기
	public Integer newListAllcount() throws Exception{
		return musicRepository.newListAllcount();
	}
	
	
	
	
	//좋아요순으로 출력하기
	public List<MusicDTO> likeMusicList(Criteria cri) throws Exception{
		List<MusicDTO> result = musicRepository.likeMusicList(cri);
		return result;
	}
	
	
	
	//국외최신순
	public List<MusicDTO> newAboardMusicList() throws Exception{
		List<MusicDTO> result = musicRepository.newAboardMusicList();
		return result;
	}
	
	
	
	
	
}
