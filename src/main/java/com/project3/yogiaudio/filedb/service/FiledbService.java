package com.project3.yogiaudio.filedb.service;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.project3.yogiaudio.filedb.entity.Filedb;
import com.project3.yogiaudio.filedb.repository.FiledbRepository;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class FiledbService {
		
	@Autowired
	FiledbRepository filedbRepository;
	
		
	/**
	 * 여러 파일 저장
	 * @param uuid
	 * @param files
	 * @return String filePath
	 */
	@Transactional
	public String saveFiles(List<MultipartFile> files) {
	
		String filePath = ""; // filePath 에 넣을 String 값

		for (MultipartFile file : files) {
			try {

				// 저장 실행
				// 1) DB에 이미지 저장
				// 2) DB에 이미지를 다운로드 할 수 있는 url 저장 (다운로드 URL 만들기 필요)
				// 3) 파일명(중복이 안되는) : uuid(기본키) 사용(유일값)

				// TODO : 1) uuid 만들기
				String tmpUuid = UUID.randomUUID().toString().replace("-", "");

				// TODO : 2) 다운로드 url 만들기
				String fileDownloadUri = ServletUriComponentsBuilder.fromCurrentContextPath().path("/filedb/get-file/")
						.path(tmpUuid).toUriString();
				// 최종 url 예 : localhost/filedb/get-file/xxxxiiiii

				// TODO : 3) 위의 정보를 파일 객체에 저장 후 DB save 함수 실행
				Filedb filedb = Filedb.builder().uuid(tmpUuid).originalFileName(file.getOriginalFilename())
						.fileData(file.getBytes()).build();

				// 저장하기
				int result = filedbRepository.saveFiledb(filedb);
				

				filePath += fileDownloadUri + ",";
			} catch (Exception e) {
				log.debug(e.getMessage());
			}
		}

		if (!filePath.isEmpty()) { // filePath가 비어있는 경우 실행안되게 코드 수정
		    filePath = filePath.substring(0, filePath.length() - 1); // 마지막 , 제거
		} 
		return filePath;
	}

	/**
	 * 단일 파일 
	 * @param file
	 * @return
	 */
	@Transactional
	public String saveFiles(MultipartFile file) {
		

		String filePath = ""; // filePath 에 넣을 String 값
		// 저장 실행
		// 1) DB에 이미지 저장
		// 2) DB에 이미지를 다운로드 할 수 있는 url 저장 (다운로드 URL 만들기 필요)
		// 3) 파일명(중복이 안되는) : uuid(기본키) 사용(유일값)

		try {
			// TODO : 1) uuid 만들기
			String tmpUuid = UUID.randomUUID().toString().replace("-", "");

			// TODO : 2) 다운로드 url 만들기
			String fileDownloadUri = ServletUriComponentsBuilder.fromCurrentContextPath().path("/filedb/get-file/")
					.path(tmpUuid).toUriString();
			// 최종 url 예 : localhost/filedb/get-file/xxxxiiiii

			// TODO : 3) 위의 정보를 파일 객체에 저장 후 DB save 함수 실행
			Filedb filedb = Filedb.builder().uuid(tmpUuid).originalFileName(file.getOriginalFilename())
					.fileData(file.getBytes()).build();

			// 저장하기
			int result = filedbRepository.saveFiledb(filedb);
			
			filePath = fileDownloadUri;
		} catch (Exception e) {
			log.debug(e.getMessage());
		}
		return filePath;
	}

	// 상세 조회
	public Filedb findByUuid(String uuid) {
		return filedbRepository.findByUuid(uuid);
	}
	
}
