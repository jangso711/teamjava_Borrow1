package org.kosta.borrow.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kosta.borrow.model.ItemDAO;
import org.kosta.borrow.model.MemberDAO;
import org.kosta.borrow.model.MemberVO;
import org.kosta.borrow.model.RentalDetailVO;

public class ItemRentDetailController implements Controller {
	
	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String rental_no = request.getParameter("rental_no");
		String originalPoint = request.getParameter("originalPoint");
		String memberId=((MemberVO)(request.getSession().getAttribute("user"))).getId();
		String newPoint = Integer.toString(MemberDAO.getInstance().getPointByMemberId(memberId));
		RentalDetailVO vo = new RentalDetailVO();
		vo.setRentalNo(rental_no);
		RentalDetailVO result = ItemDAO.getInstance().itemRentDetail(vo);
		request.setAttribute("rvo", result);
		request.setAttribute("originalPoint", originalPoint);
		request.setAttribute("newPoint", newPoint);		
		request.setAttribute("url", "/item/item_rental_detail.jsp");		
		return "template/layout.jsp";
	}

}
