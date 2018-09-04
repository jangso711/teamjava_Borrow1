package org.kosta.borrow.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kosta.borrow.model.ItemDAO;
import org.kosta.borrow.model.ItemVO;

public class ItemDetailController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ItemVO itemVO = ItemDAO.getInstance().getDetailItemByNo(request.getParameter("itemNo"));
		if(itemVO != null) {
			request.setAttribute("itemDetail", itemVO);
		}
		request.setAttribute("url", "/item/item_detail.jsp");		
		return "template/layout.jsp";
	}

}
