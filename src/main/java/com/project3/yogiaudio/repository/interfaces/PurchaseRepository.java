package com.project3.yogiaudio.repository.interfaces;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project3.yogiaudio.dto.common.Criteria;
import com.project3.yogiaudio.dto.music.PurchaseDTO;

@Mapper
public interface PurchaseRepository {

	//이용권리스트출력
	public List<PurchaseDTO> purchaseListAll(Criteria cri) throws Exception;
	
	//이용권전부 카운팅하기
	public int countPurchaseList() throws Exception;
	
	//이용권상세보기 페이징
	public PurchaseDTO purchaseDetail(@Param(value = "pno") int pno);
	
	
	//결제상태변경하기
	public Integer statusUpdate(@Param(value = "id") int id);
	
	
}