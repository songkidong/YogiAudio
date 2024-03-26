package com.project3.yogiaudio.handler;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.project3.yogiaudio.handler.exception.AdminPageException;
import com.project3.yogiaudio.repository.entity.User;
import com.project3.yogiaudio.util.Define;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

// 1. HandlerInterceptor 구현하기
// AuthInterceptor --> new -->
// implements 는 오버라이드
@Component // IoC 대상
public class AdminAuthInterceptor implements HandlerInterceptor{

	// preHandle
	// 컨트롤러 들어오기 전에 동작 
	// true -> 컨트롤러 안으로 들어감
	// false -> 안들어감
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		System.out.println("인터셉터 동작확인 - 111111111");
		
		// 인증검사
		HttpSession session = request.getSession();
		User principal = (User) session.getAttribute(Define.PRINCIPAL);
		
		//response.sendRedirect("/user/sign-in"); // 예외처리
		if(principal == null || principal.getRole().equals("USER")) { // equals로 비교
			throw new AdminPageException("접근 권한이 없습니다", HttpStatus.UNAUTHORIZED); 
		}
		return true;
	}
	
	// postHandle
	// 뷰가 렌더링 되기 전에 호출되는 메서드(뷰 : jsp)
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
	}
	
	// 요청처리가 완료된 후, 뷰 렌더링이 완료된 후 호출된다.
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		HandlerInterceptor.super.afterCompletion(request, response, handler, ex);
	}
}
