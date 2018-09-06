package org.kosta.borrow.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.kosta.borrow.model.MemberVO;
import org.kosta.borrow.model.PagingBean;
import org.kosta.borrow.model.ReviewDAO;
import org.kosta.borrow.model.ReviewListVO;
import org.kosta.borrow.model.ReviewVO;

public class ReviewMyListController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session=request.getSession();
		MemberVO mvo=(MemberVO) session.getAttribute("user");
		String id=mvo.getId();
		int pageNo=Integer.parseInt(request.getParameter("pageNo"));
		int totalPostCount=ReviewDAO.getInstance().getTotalPostCount();
		PagingBean pagingBean=new PagingBean(totalPostCount, pageNo);
		ArrayList<ReviewVO> list=ReviewDAO.getInstance().getPostingMyList(pagingBean,id);
		ReviewListVO rvo=new ReviewListVO(list, pagingBean);
		
		request.setAttribute("url", "/review/review_mylist.jsp");
		request.setAttribute("rvo", rvo);
		return "/template/layout.jsp";
	}

}
