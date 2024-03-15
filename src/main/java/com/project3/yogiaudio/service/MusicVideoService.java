package com.project3.yogiaudio.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
