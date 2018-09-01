package org.kosta.borrow.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kosta.borrow.model.ItemDAO;
import org.kosta.borrow.model.ItemVO;

public class ItemAllSearchController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ArrayList<ItemVO> allItemList = ItemDAO.getInstance().getAllItemList();
		request.setAttribute("allItemList", allItemList);

		request.setAttribute("url", "/item/item_all_search_result.jsp");
		return "template/layout.jsp";
	}

}
