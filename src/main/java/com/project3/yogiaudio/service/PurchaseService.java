package com.project3.yogiaudio.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project3.yogiaudio.dto.common.Criteria;
import com.project3.yogiaudio.dto.music.PurchaseDTO;
import com.project3.yogiaudio.repository.interfaces.PurchaseRepository;

@Service
public class PurchaseService {

	@Autowired
	private PurchaseRepository purchaseRepository;
	
	//이용권리스트출력하기
	public List<PurchaseDTO> purchaseListAll(Criteria cri) throws Exception{
		List<PurchaseDTO> result = purchaseRepository.purchaseListAll(cri);
		return result;
		
	}
	
	//이용권갯수 카운팅하기
	public int countPurchaseList() throws Exception{
		return purchaseRepository.countPurchaseList();
	}
	
	
}
