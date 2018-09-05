package org.kosta.borrow.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.kosta.borrow.model.MemberVO;
import org.kosta.borrow.model.ReviewDAO;

public class ReviewUpdateController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession(false);
		MemberVO user = null;
		if(session!=null&&(user=(MemberVO)session.getAttribute("user"))!=null) {
			
			String reviewNo = request.getParameter("reviewNo");
			String title = request.getParameter("reviewTitle");
			String contents = request.getParameter("reviewContents");
			System.out.println(reviewNo);
			ReviewDAO.getInstance().updateReview(title,contents,reviewNo);
			return "redirect:front?command=ReviewPost&reviewNo="+reviewNo;
		}else {
			//세션만료시 로그인폼으로 이동
			return "redirect:front?command=LoginForm";
		}
	}

}
