package org.kosta.borrow.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kosta.borrow.model.ItemDAO;
import org.kosta.borrow.model.ItemVO;
import org.kosta.borrow.model.PagingBean;

public class ItemSearchController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String searchtext= request.getParameter("searchtext");
		PagingBean pagingBean = null;
		String nowPage = request.getParameter("pageNum");
		int totalPostCount = ItemDAO.getInstance().getAllItemListCountByName(searchtext);
		if(nowPage == null)
			pagingBean = new PagingBean(1, 6, totalPostCount);
		else
			pagingBean = new PagingBean(Integer.parseInt(nowPage), 6, totalPostCount);
		
		ArrayList<ItemVO> itemSearchList = ItemDAO.getInstance().getAllItemListByName(searchtext, pagingBean);
		request.setAttribute("itemSearchList", itemSearchList);
		request.setAttribute("pagingBean", pagingBean);
		
		request.setAttribute("url", "/item/item_search_result.jsp");		
		return "template/layout.jsp";
	}

}
