package org.kosta.borrow.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kosta.borrow.model.ReviewDAO;
import org.kosta.borrow.model.ReviewVO;

public class ReviewPostController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {

		int no=Integer.parseInt(request.getParameter("reviewNo"));
		
		/*if(cookies.length>) {
			ReviewDAO.getInstance().updateHit(no);
			
		} */
		ReviewVO rvo = ReviewDAO.getInstance().getPostingByNo(no);	
		request.setAttribute("rvo", rvo);
		request.setAttribute("url", "/review/review_post.jsp");
		return "/template/layout.jsp";
	}
}
