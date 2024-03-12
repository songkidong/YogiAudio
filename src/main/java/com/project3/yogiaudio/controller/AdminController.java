package com.project3.yogiaudio.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project3.yogiaudio.dto.admin.AdminCriteria;
import com.project3.yogiaudio.dto.admin.AdminPageVO;
import com.project3.yogiaudio.repository.entity.User;
import com.project3.yogiaudio.service.AdminService;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	AdminService adminService;

	// 인덱스
	@GetMapping("/index")
	public String indexPage() {

		return "admin/index";
	}

	// 유저 목록
	// Criteria 쿼리문에서 이용하기 위해 매개변수 선언
	@GetMapping("/userList")
	public String userListPage(Model model, AdminCriteria cri) {
		
		List<User> userList = adminService.findAllUser(cri);
		log.info("userList" + userList);
		model.addAttribute("userList", userList);
		
		// 화면에 출력하기 위한 페이징 로직
		AdminPageVO pageVO = new AdminPageVO();
		// 페이지 번호 클릭할 때 파라미터 보낸 것을 AdminCriteria 매개변수로 받아서 set
		pageVO.setCri(cri);
		pageVO.setTotalCount(adminService.countAllUser());
		model.addAttribute("pageVO", pageVO);
		 
		return "admin/userList";
	}
	
	// 유저 삭제
	// @PathVariable("id")
	@GetMapping("/deleteUser/{id}")
	public String deleteUser(@PathVariable("id") Long id) {
		
		log.info("id : " + id);
		adminService.deleteUser(id);
		
		return "redirect:/admin/userList";
	}
}
