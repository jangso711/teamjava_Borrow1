package org.kosta.borrow.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kosta.borrow.model.PagingBean;
import org.kosta.borrow.model.ReviewDAO;
import org.kosta.borrow.model.ReviewListVO;
import org.kosta.borrow.model.ReviewVO;

public class ReviewListController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int pageNo=Integer.parseInt(request.getParameter("pageNo"));
		int totalPostCount=ReviewDAO.getInstance().getTotalPostCount();
		PagingBean pagingBean=new PagingBean(totalPostCount, pageNo);
		ArrayList<ReviewVO> list=ReviewDAO.getInstance().getPostingList(pagingBean);
		ReviewListVO rvo=new ReviewListVO(list, pagingBean);
	
		request.setAttribute("url", "/review/review_list.jsp");
		request.setAttribute("rvo", rvo);
		return "/template/layout.jsp";
	}

}
