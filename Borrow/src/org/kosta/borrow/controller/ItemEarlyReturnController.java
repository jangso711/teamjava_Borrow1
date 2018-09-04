package org.kosta.borrow.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kosta.borrow.model.ItemDAO;
import org.kosta.borrow.model.RentalDetailVO;

public class ItemEarlyReturnController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String rentalNo=request.getParameter("rentalNo");
		ItemDAO.getInstance().itemEarlyReturn(rentalNo);
		return "redirect:front?command=ItemRentalList";
	}

}
