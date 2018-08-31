package org.kosta.borrow.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kosta.borrow.model.ItemDAO;
import org.kosta.borrow.model.ItemVO;

public class ItemDetailController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ArrayList<ItemVO> itemDetail = ItemDAO.getInstance().getDetailItemByNo(request.getParameter("itemSearchId"));
		request.setAttribute("itemDetail", itemDetail);
		request.setAttribute("url", "/item/item_detail.jsp");		
		return "template/layout.jsp";
	}

}
