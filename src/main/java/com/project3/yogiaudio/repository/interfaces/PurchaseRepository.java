package com.project3.yogiaudio.repository.interfaces;

import java.time.LocalDateTime;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project3.yogiaudio.dto.common.Criteria;
import com.project3.yogiaudio.dto.music.CancelDTO;
import com.project3.yogiaudio.dto.music.PurchaseDTO;

@Mapper
public interface PurchaseRepository {

	//이용권리스트출력
	public List<PurchaseDTO> purchaseListAll(Criteria cri) throws Exception;
	
	//이용권전부 카운팅하기
	public int countPurchaseList() throws Exception;
	
	//이용권상세보기 페이징
	public PurchaseDTO purchaseDetail(@Param(value = "pno") int pno);
	
	//결제취소용
	public PurchaseDTO purchaseDetailCancel();
	
	
	
	//결제상태변경하기
	public Integer statusUpdate(@Param(value = "id") int id);
	
	//결제내역등록하기
	public Integer insertHistory(@Param(value = "id") int id,@Param(value="orderId") String orderId, @Param(value="paymentKey") String paymentKey, @Param(value="amount") int amount,@Param(value="pno") int pno);
	
	//결제상태원상복귀하기
	public Integer resetUpdate(@Param(value ="pno") int pno, LocalDateTime targetTime, @Param(value ="id") int id);
	
	//결제취소내역 DB업데이트하기
	public Integer cancelPayment(CancelDTO dto);
	
	//hno 로 paymentkey 불러오기
	public CancelDTO paymentKeyByHno(CancelDTO dto);
	
	
	
	
	
	
}
