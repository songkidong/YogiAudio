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
	public List<MusicDTO> domesticListAll() throws Exception{
		List<MusicDTO> result = musicRepository.domesticListAll();
		return result;
	}
	
	

	
	
	
	
}
