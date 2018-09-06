package org.kosta.borrow.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kosta.borrow.model.PagingBean;
import org.kosta.borrow.model.ReviewDAO;
import org.kosta.borrow.model.ReviewListVO;
import org.kosta.borrow.model.ReviewVO;

public class ReviewFindItemNameController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String itemName = request.getParameter("itemName");
		String pageNostring=request.getParameter("pageNo");
		int pageNoint=0;
		if(pageNostring==null) {
			pageNoint=1;
		}else {
			pageNoint=Integer.parseInt(pageNostring);
		}
		int totalPostCount=ReviewDAO.getInstance().getItemNamePostCount(itemName);
		PagingBean pagingBean=new PagingBean(totalPostCount, pageNoint);
		ArrayList<ReviewVO> list=ReviewDAO.getInstance().getPostingMyItemNameList(pagingBean, itemName);
		ReviewListVO rvo=new ReviewListVO(list, pagingBean);
		request.setAttribute("rvo", rvo);

		request.setAttribute("url", "/review/reivew_item_no_list.jsp");		
		return "/template/layout.jsp";
	}

}
