package com.project3.yogiaudio.service;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;

import com.project3.yogiaudio.repository.interfaces.CancelRepository;

@Service
public class CancelService {

	@Autowired
	private CancelRepository cancelRepository;
	
	
	//결제취소후내역등록하기
	@Transactional
	public Integer InsertCancel(@Param(value="amount") int amount,@Param(value="pno") int pno, @Param(value = "id") int id) {
		return cancelRepository.InsertCancel(id,amount, pno);
		
	}
	
	
	//상태변경하기
	@Transactional
	public Integer refundStatus(@Param(value = "id") int id) {
		return cancelRepository.refundStatus(id);
	}
	
	
	
	
	
	
}
