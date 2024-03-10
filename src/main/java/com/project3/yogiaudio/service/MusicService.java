package com.project3.yogiaudio.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project3.yogiaudio.product.dto.Criteria;
import com.project3.yogiaudio.product.dto.MusicDTO;
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

	
	//국외음악리스트 출력하기
	public List<MusicDTO> aboardListAll(Criteria cri) throws Exception{
		List<MusicDTO> result = musicRepository.aboardListAll(cri);
		return result;
	}
	
	
	//국외음악리스트 카운팅하기
	public int countaboardListAll() throws Exception{
		return musicRepository.countaboardListAll();		
	}
	

	
	
	
	
}