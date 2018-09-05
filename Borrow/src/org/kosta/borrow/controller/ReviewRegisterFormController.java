package org.kosta.borrow.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ReviewRegisterFormController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession(false);
		if(session!=null && session.getAttribute("user")!=null) {
			request.setAttribute("rentalNo",request.getParameter("rentalNo"));
			request.setAttribute("url", "/review/review_register_form.jsp");
		}else {
			//세션만료는 로그인 창으로 다시가기
			return "redirect:front?command=LoginForm";
		}
		return "/template/layout.jsp";
	}

}
