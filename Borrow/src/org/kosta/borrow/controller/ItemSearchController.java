package org.kosta.borrow.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kosta.borrow.model.ItemDAO;
import org.kosta.borrow.model.ItemVO;

public class ItemSearchController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String searchtext= request.getParameter("searchtext");
		ArrayList<ItemVO> itemList = ItemDAO.getInstance().getAllItemListByName(searchtext);
		request.setAttribute("itemList", itemList);
		request.setAttribute("url", "/item/item_search_result.jsp");		
		return "template/layout.jsp";
	}

}
