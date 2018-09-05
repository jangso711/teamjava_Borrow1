package org.kosta.borrow.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.kosta.borrow.model.ItemDAO;
import org.kosta.borrow.model.ItemVO;
import org.kosta.borrow.model.MemberVO;
import org.kosta.borrow.model.ReviewDAO;

public class ReviewUpdateFormController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession(false);
		MemberVO user = null;
		if(session!=null&&(user=(MemberVO)session.getAttribute("user"))!=null) {
			//review_post.jsp에서 reviewNo 넘겨주기
			int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
			request.setAttribute("reviewDetail", ReviewDAO.getInstance().getPostingByNo(reviewNo));
			request.setAttribute("url", "/review/review_update_form.jsp");
			return "/template/layout.jsp";
		}else {
			//세션만료시 로그인폼으로 이동
			return "redirect:front?command=LoginForm";
		}
		
	
	}

}
