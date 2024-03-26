package com.project3.yogiaudio.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project3.yogiaudio.dto.common.Criteria;
import com.project3.yogiaudio.dto.music.MusicVideoDTO;
import com.project3.yogiaudio.repository.interfaces.MusicVideoRepository;

@Service
public class MusicVideoService {

	@Autowired
	private MusicVideoRepository musicVideoRepository;
	
	
	//뮤비리스트출력하기
	public List<MusicVideoDTO> mvlistAll(Criteria cri) throws Exception{
		List<MusicVideoDTO> result = musicVideoRepository.mvlistAll(cri);
		return result;
	}
	
	//뮤비리스트갯수 계산하기
	public int mvlistCount() throws Exception{
		return musicVideoRepository.mvlistCount();
	}
	
	
	//메인페이지뮤비출력하기
	public List<MusicVideoDTO> mainMV() throws Exception{
		List<MusicVideoDTO> result = musicVideoRepository.mainMV();
		return result;
	}
	
	
	// 뮤비리스트 조건출력하기
	public List<MusicVideoDTO> optionMVlist(Criteria cri) throws Exception{
		List<MusicVideoDTO> result = musicVideoRepository.optionMVlist(cri);
		return result;
	}

	
	//뮤비리스트 조건 카운팅하기
	public Integer optionMVlistCount(Criteria cri) throws Exception{
		return musicVideoRepository.optionMVlistCount(cri);
	}
	
	//뮤비업데이트하기
	@Transactional
	public void mvUpdate(MusicVideoDTO dto,String filePath) {
		
		MusicVideoDTO mv = MusicVideoDTO.builder()
				.videono(dto.getVideono())
				.filepath(filePath)
				.mvfile(dto.getMvfile())
				.build();
		
		Integer result = musicVideoRepository.mvUpdate(mv);
	}

	
	
	
	
	
	
	
}
