package org.kosta.borrow.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kosta.borrow.model.ItemDAO;
import org.kosta.borrow.model.ItemVO;

public class ItemRegisterAllListController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		String id=request.getParameter("memberId");		
		ArrayList<ItemVO> allItemList = ItemDAO.getInstance().getAllItemListById(id);
		request.setAttribute("allItemList", allItemList);
		request.setAttribute("url", "/item/item_register_all_list.jsp");
		return "template/layout.jsp";
	}

}
