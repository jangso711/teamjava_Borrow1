package org.kosta.borrow.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.kosta.borrow.exception.BalanceShortageException;
import org.kosta.borrow.model.ItemDAO;
import org.kosta.borrow.model.ItemVO;
import org.kosta.borrow.model.MemberDAO;
import org.kosta.borrow.model.MemberVO;
import org.kosta.borrow.model.RentalDetailVO;

public class ItemRentalController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session=request.getSession();
		MemberVO user= (MemberVO)(session.getAttribute("user"));
		String id=user.getId();	
		String rentalDate = request.getParameter("rentalDate");
		String returnDate = request.getParameter("returnDate");	
		String item_no=request.getParameter("item_no");	
		RentalDetailVO vo = new RentalDetailVO();
		vo.setRentalDate(rentalDate);
		vo.setReturnDate(returnDate);
		vo.setItemVO(new ItemVO(item_no));
		vo.setMemberVO(new MemberVO(id));
		int originalPoint =MemberDAO.getInstance().getPointByMemberId(id);
		try {
		ItemDAO.getInstance().itemRental(vo);
		}catch(BalanceShortageException e){  //금액 부족시
			e.printStackTrace();
			request.setAttribute("message", "포인트 부족!!");
			return "item/item_rental_fail.jsp";
		}
		String rental_no = vo.getRentalNo();
		return "redirect:front?command=ItemRentDetail&rental_no="+rental_no+"&originalPoint="+originalPoint;
	}

}
