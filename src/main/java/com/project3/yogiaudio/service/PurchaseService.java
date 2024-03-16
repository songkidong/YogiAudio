package com.project3.yogiaudio.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
	
	
	//이용권상세보기 페이지출력
	public PurchaseDTO purchaseDetail(@Param(value = "pno") int pno) {
		return purchaseRepository.purchaseDetail(pno);
	}
	
	
	//상태변경하기
	@Transactional
	public Integer statusUpdate(@Param(value = "id") int id) {
		return purchaseRepository.statusUpdate(id);
	}
	
	//결제내역등록하기
	@Transactional
	public Integer insertHistory(@Param(value = "id") int id,@Param(value="orderId") String orderId, @Param(value="paymentKey") String paymentKey, @Param(value="amount") int amount,@Param(value="pno") int pno) {
		return purchaseRepository.insertHistory(id, orderId, paymentKey, amount,pno);
	}

	
	
	
	
}
