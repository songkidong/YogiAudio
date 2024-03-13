package com.project3.yogiaudio.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project3.yogiaudio.dto.common.Criteria;
import com.project3.yogiaudio.dto.music.PurchaseDTO;

@Mapper
public interface PurchaseRepository {

	//이용권리스트출력
	public List<PurchaseDTO> purchaseListAll(Criteria cri) throws Exception;
	
	//이용권전부 카운팅하기
	public int countPurchaseList() throws Exception;
	
	
	
}
