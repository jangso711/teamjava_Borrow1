package org.kosta.borrow.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kosta.borrow.model.ItemDAO;
import org.kosta.borrow.model.ItemVO;
import org.kosta.borrow.model.PagingBean;

public class ItemRegisterAllListController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id=null;		
		id=request.getParameter("memberId");
		int totalPostCount = ItemDAO.getInstance().getTotalItemCountById(id);
		String nowPage = request.getParameter("pageNo");
		PagingBean pagingBean = null;
		if(nowPage == null)
			pagingBean = new PagingBean(1,3,totalPostCount);
		else
			pagingBean = new PagingBean(Integer.parseInt(nowPage), 3,totalPostCount);		
		
		ArrayList<ItemVO> allItemList = ItemDAO.getInstance().getAllItemListById(id, pagingBean);
		request.setAttribute("allItemList", allItemList);
		request.setAttribute("pagingBean", pagingBean);
		request.setAttribute("memberId", id);
		request.setAttribute("url", "/item/item_register_all_list.jsp");
		return "template/layout.jsp";
	}

}
