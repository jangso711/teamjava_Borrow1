package org.kosta.borrow.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.kosta.borrow.model.ItemDAO;
import org.kosta.borrow.model.ItemVO;
import org.kosta.borrow.model.MemberVO;
import org.kosta.borrow.model.RentalDetailVO;

public class ItemRentalListController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session=request.getSession();
		MemberVO user=(MemberVO) session.getAttribute("user");
		String id=user.getId();		
		
		ArrayList<RentalDetailVO> rentallist = ItemDAO.getInstance().getAllRentalDetailById(id);
		request.setAttribute("rentallist", rentallist);
		
		System.out.println(rentallist);
		
		request.setAttribute("url", "/item/item_rental_list.jsp");
		
		return "template/layout.jsp";
	}

}
