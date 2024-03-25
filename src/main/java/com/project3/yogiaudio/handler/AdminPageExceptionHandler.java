package com.project3.yogiaudio.handler;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

import com.project3.yogiaudio.handler.exception.AdminPageException;

/**
 * view 렌더링을 위해
 * ModelView 객체를 반환 하도록 설정되어 있다.
 * 예외처리 Page를 리턴할 때 사용한다.
 */



@ControllerAdvice
public class AdminPageExceptionHandler {

	// CustomPageException <-- 발생 되면 이 함수를 동작 시켜! // AdminPageException 으로 수정
	@ExceptionHandler
	public ModelAndView handlerRuntionException(AdminPageException e) {
		//System.out.println("여기 에러 확인~~~~~~");
		//System.out.println(HttpStatus.NOT_FOUND.value());
		
		ModelAndView modelAndView = new ModelAndView("admin/errorPage"); // errorPage.jsp
		modelAndView.addObject("statusCode", HttpStatus.NOT_FOUND.value()); // 404
		modelAndView.addObject("message", e.getMessage()); // AdminPageException
		
		return modelAndView; //페이지 반환 + 데이터 내려 줌
	}
}
