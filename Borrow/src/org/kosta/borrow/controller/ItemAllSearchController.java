package org.kosta.borrow.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kosta.borrow.model.ItemDAO;
import org.kosta.borrow.model.ItemVO;
import org.kosta.borrow.model.PagingBean;

public class ItemAllSearchController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int totalPostCount = ItemDAO.getInstance().getTotalItemCount();
		String nowPage = request.getParameter("pageNum");
		PagingBean pagingBean = null;
		if(nowPage == null)
			pagingBean = new PagingBean(totalPostCount);
		else
			pagingBean = new PagingBean(totalPostCount, Integer.parseInt(nowPage));
		ArrayList<ItemVO> allItemList = ItemDAO.getInstance().getAllItemList(pagingBean);
		request.setAttribute("allItemList", allItemList);
		request.setAttribute("pagingBean", pagingBean);
		
		request.setAttribute("url", "/item/item_all_search_result.jsp");
		return "template/layout.jsp";
	}

}
