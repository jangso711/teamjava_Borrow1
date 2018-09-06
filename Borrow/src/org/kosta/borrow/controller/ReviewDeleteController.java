package org.kosta.borrow.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.kosta.borrow.model.ItemDAO;
import org.kosta.borrow.model.ItemVO;
import org.kosta.borrow.model.MemberVO;
import org.kosta.borrow.model.ReviewDAO;

public class ReviewDeleteController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession(false);
		MemberVO user = null;
		if(session!=null&&(user=(MemberVO)session.getAttribute("user"))!=null) {
			String reviewNo = request.getParameter("reviewNo");
			String itemNo = request.getParameter("itemNo");
			ReviewDAO.getInstance().deleteReview(reviewNo,itemNo);
			return "redirect:front?command=MemberMypage";
		}else {
			//세션만료시 로그인폼으로 이동
			return "redirect:front?command=LoginForm";
		}
		 
	}

}
