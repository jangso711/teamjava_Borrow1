package org.kosta.borrow.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.kosta.borrow.model.ItemDAO;
import org.kosta.borrow.model.ItemVO;
import org.kosta.borrow.model.PagingBean;
import org.kosta.borrow.model.ReviewDAO;
import org.kosta.borrow.model.ReviewListVO;
import org.kosta.borrow.model.ReviewVO;

public class ItemDetailController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String itemNo = request.getParameter("itemNo");
		String pageNosting=request.getParameter("pageNo");
		int pageNoint=0;
		if(pageNosting==null) {
			pageNoint=1;
		}else {
			pageNoint=Integer.parseInt(pageNosting);
		}
		//int pageNo=Integer.parseInt();
		int pageNo=1;
		int totalPostCount=ReviewDAO.getInstance().getItemNoPostCount(itemNo);
		PagingBean pagingBean=new PagingBean(totalPostCount, pageNoint);
		ArrayList<ReviewVO> list=ReviewDAO.getInstance().getPostingMyItemNoList(pagingBean, itemNo);
		ReviewListVO rvo=new ReviewListVO(list, pagingBean);
		request.setAttribute("rvo", rvo);
		
		
		ItemVO itemVO = ItemDAO.getInstance().getDetailItemByNo(itemNo);
		
		//180904 SOJEONG - 대여 중인 날짜 반환 함수
		ArrayList<String> rentalDetails = ItemDAO.getInstance().getRentalUnavailableDateList(itemNo);
		JSONArray dateList = new JSONArray(rentalDetails);
		request.setAttribute("dateList", dateList);
		//180904 SOJEONG

		if(itemVO != null) {
			request.setAttribute("itemDetail", itemVO);
		}
		
		request.setAttribute("url", "/item/item_detail.jsp");		
		return "/template/layout.jsp";
	}

}
