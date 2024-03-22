package com.project3.yogiaudio.dto.music;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PurchaseDTO {

	private long id;
	private Integer pno;
	private String purchasename;
	private String purchasedetail;
	private Integer price;
	private String paymentKey;
	private String cancelYn;
	private String filepath;
	private List<MultipartFile> files; // 파일 url

	
}
