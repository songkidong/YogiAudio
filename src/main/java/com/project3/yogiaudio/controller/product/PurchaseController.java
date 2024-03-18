package com.project3.yogiaudio.controller.product;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project3.yogiaudio.dto.common.Criteria;
import com.project3.yogiaudio.dto.common.PageVO;
import com.project3.yogiaudio.dto.music.CancelDTO;
import com.project3.yogiaudio.dto.music.PurchaseDTO;
import com.project3.yogiaudio.filedb.service.FiledbService;
import com.project3.yogiaudio.service.PurchaseService;
import com.project3.yogiaudio.util.Scheduler;

import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/purchase")
public class PurchaseController {

	@Autowired
	private PurchaseService purchaseService;
	@Autowired
	private FiledbService filedbService;
	@Autowired
	private Scheduler scheduler;
	
	// http://localhost:80/purchase/main
	
	@GetMapping("/main")
	public String purchaseMainPageGET(Model model,Criteria cri) throws Exception {
		
		
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(purchaseService.countPurchaseList());
		
		
		model.addAttribute("pageVO", pageVO);
		
		
		List<PurchaseDTO> result = purchaseService.purchaseListAll(cri);
		model.addAttribute("purchaselist", result);
		
		System.out.println(result);
		
		
		log.debug("이용권구매페이지출력!");
		
		return "product/purchase";
	}
	
	//이용권상세보기 & 결제페이지 출력
	@GetMapping("/detail")
	public String PurchaseDetailGET(@RequestParam(value = "pno") int pno,Model model) {
		
		PurchaseDTO result = purchaseService.purchaseDetail(pno);
		model.addAttribute("detail", result);
		
		PurchaseDTO result2 = purchaseService.purchaseDetailCancel();
		model.addAttribute("detailcancel", result2);
		
		log.debug("이용권구매상세보기출력");
		return"product/purchasedetail";
	}
	
	
	//성공 후 상태변경 --> 보류중
	
	@GetMapping("/success")
	public String paymentSuccessGET(@RequestParam(value = "id") int id,@RequestParam(value="orderId") String orderId, @RequestParam(value="paymentKey") String paymentKey, @RequestParam(value="amount") int amount,@RequestParam(value="pno") int pno) {
		purchaseService.insertHistory(id, orderId, paymentKey, amount,pno);
	    purchaseService.statusUpdate(id);
	    
	    //업데이트될때 pno 값에따라서 기간정해지는 업데이트 메서드 호출!
	    // 1개월 -> pno = 1 , 3개월 -> pno =2  , 6개월 -> pno =3 , 12개월 -> pno=4 
	    scheduler.updateStatus();
	    return "product/success"; // 성공 페이지를 반환합니다.
	      
	    
	}
	
	
	
	//결제취소컨트롤러
	// http://localhost:80/purchase/cancel
	@GetMapping("/cancel")
	public String paymentCancelGET(@RequestParam("paymentKey") String paymentKey, Model model) {
		
		model.addAttribute("paymentKey", paymentKey);
		return "product/cancel";
	}
	
	
	
	
	
	
	
	
	
	
}
