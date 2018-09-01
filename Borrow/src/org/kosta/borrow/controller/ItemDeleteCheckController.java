package org.kosta.borrow.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kosta.borrow.model.ItemDAO;

public class ItemDeleteCheckController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String itemNo = request.getParameter("itemNo");
		boolean del = ItemDAO.getInstance().deleteCheck(itemNo);
		
		request.setAttribute("responsebody", del);
		return	"/AjaxView";
	}

}
