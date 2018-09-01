package org.kosta.borrow.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kosta.borrow.model.ItemDAO;
import org.kosta.borrow.model.RentalDetailVO;

public class ItemRentDetailController implements Controller {
	
	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String rental_no = request.getParameter("rental_no");
		RentalDetailVO vo = new RentalDetailVO();
		vo.setRentalNo(rental_no);
		RentalDetailVO result = ItemDAO.getInstance().itemRentDetail(vo);
		request.setAttribute("rvo", result);
		return "item/item_rental_detail.jsp";
	}

}
