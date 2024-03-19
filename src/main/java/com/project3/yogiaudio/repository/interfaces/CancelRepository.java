package com.project3.yogiaudio.repository.interfaces;

import java.time.LocalDateTime;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

@Mapper
public interface CancelRepository {
	
	//취소내역등록하기
	public Integer InsertCancel(@Param(value = "id") int id, @Param(value="paymentKey") String paymentKey, @Param(value="amount") int amount,@Param(value="pno") int pno);
	
	
	//환불후상태업데이트하기
	public Integer refundStatus(@Param(value = "id") int id);
	
	
	
	
	
}
