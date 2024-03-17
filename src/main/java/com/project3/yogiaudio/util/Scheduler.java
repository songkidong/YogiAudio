package com.project3.yogiaudio.util;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.project3.yogiaudio.service.PurchaseService;

@Component
public class Scheduler {
	
	@Autowired
    private PurchaseService purchaseService;

	@Scheduled(cron = "0 0 0 * * *")
	public void updateStatus() {
		int id = 0;
	    // pno에 따라서 다른 기간을 설정하여 상태를 변경합니다.
	    List<Integer> pnos = Arrays.asList(1, 2, 3, 4); // 처리할 pno 목록
	    for (int pno : pnos) {
	        int months = 0;
	        switch (pno) {
	            case 1:
	                months = 1;
	                break;
	            case 2:
	                months = 3;
	                break;
	            case 3:
	                months = 6;
	                break;
	            case 4:
	                months = 12;
	                break;
	        }
	        LocalDateTime currentTime = LocalDateTime.now();
	        LocalDateTime targetTime = currentTime.plusMonths(months); // 해당 pno에 해당하는 기간 후의 시간 계산
	        purchaseService.resetUpdate(pno, targetTime,id);
	    }
	}
	
	
}
