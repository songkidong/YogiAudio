package com.project3.yogiaudio.filedb.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.project3.yogiaudio.filedb.entity.Filedb;
import com.project3.yogiaudio.filedb.service.FiledbService;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
@RequestMapping("/filedb")
public class FiledbController {
	
	
	@Autowired
	FiledbService filedbService;
	
    // 다운로드 URL에 따라 자동으로 첨부파일 다운로드 받게 해주는 함수(자동 실행)
    // 예) <img src="url"/ > => 이미지 자동 다운로드해서 화면에 이미지 표시됨
    @GetMapping("/get-file/{uuid}")
    public ResponseEntity<byte[]> findByIdDownloading(@PathVariable(value="uuid") String uuid) {
        try {
            Filedb file = filedbService.findByUuid(uuid);
            HttpHeaders headers = new HttpHeaders();
            // header 추가 240317 - audio태그 currentTime 적용 위한 헤더 추가
            headers.add("Accept-Ranges", "bytes");
            return ResponseEntity.ok()
//           Todo : header() : 헤더 (1)첨부파일로 전송한다고 표시, (2) 첨부파일명 표시
//                  HttpHeaders.CONTENT_DISPOSITION : 첨부파일 표시
//                  "attachment; filename=\"" + projectImages.getFileName() + "\"" : 첨부파일명 표시
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + file.getOriginalFileName() + "\"")
                    // header 추가 240317
                    .headers(headers)
//           TODO : body() : 바디 - 실제 이미지 전송(리액트)
                    .body(file.getFileData());    // 첨부파일
        } catch (Exception e) {
            log.info(e.getMessage());
            return ResponseEntity.internalServerError().build();
        }
    }
		
	
}
