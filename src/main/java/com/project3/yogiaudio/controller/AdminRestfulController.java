package com.project3.yogiaudio.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.project3.yogiaudio.service.AdminService;

import lombok.extern.log4j.Log4j2;

@Log4j2
@RestController
@RequestMapping("/admin")
public class AdminRestfulController {

	@Autowired
	AdminService adminService;
	
	// 유저 삭제
	@DeleteMapping("/user/{id}")
	public ResponseEntity<?> deleteUser(@PathVariable("id") Long id) {
		
		boolean result = adminService.deleteUser(id);
		
		return new ResponseEntity<Boolean>(result, HttpStatus.OK);
	}
	
	// 음악 삭제 / music entity의 musicNo 타입이 int인데, Integer로 해도 상관없음
	@DeleteMapping("/music/{musicNo}")
	public ResponseEntity<?> deleteMusic(@PathVariable("musicNo") Integer musicNo) {
		
		//log.info("musicNo : " + musicNo);
		boolean result = adminService.deleteMusic(musicNo);
		
		return new ResponseEntity<Boolean>(result, HttpStatus.OK);
	}
	
	// 공지사항 삭제
	@DeleteMapping("/notice/{id}")
	public ResponseEntity<?> deleteNotice(@PathVariable("id") Integer id) {
		
		boolean result = adminService.deleteNotice(id);
		
		return new ResponseEntity<Boolean>(result, HttpStatus.OK);
	}
}
