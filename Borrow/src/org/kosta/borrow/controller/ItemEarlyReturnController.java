package org.kosta.borrow.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kosta.borrow.model.ItemDAO;

public class ItemEarlyReturnController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String rentalNo=request.getParameter("rentalNo");
		ItemDAO.getInstance().itemEarlyReturn(rentalNo);
		return "redirect:front?command=ItemRentalList&nowPage=1";
	}

}
