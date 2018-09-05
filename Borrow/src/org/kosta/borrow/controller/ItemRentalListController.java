package org.kosta.borrow.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.kosta.borrow.model.ItemDAO;
import org.kosta.borrow.model.ItemVO;
import org.kosta.borrow.model.MemberVO;
import org.kosta.borrow.model.PagingBean;
import org.kosta.borrow.model.RentalDetailVO;

public class ItemRentalListController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session=request.getSession();
		MemberVO user=(MemberVO) session.getAttribute("user");
		String id=user.getId();		
		int nowPage= Integer.parseInt(request.getParameter("nowPage"));
		PagingBean pagingBean= new PagingBean(ItemDAO.getInstance().getAllRentalListCountById(id), nowPage);
		ArrayList<RentalDetailVO> rentallist = ItemDAO.getInstance().getAllRentalListById(id,pagingBean);
		request.setAttribute("rentallist", rentallist);
		request.setAttribute("pagingBean", pagingBean);
				
		request.setAttribute("url", "/item/item_rental_list.jsp");
		
		return "template/layout.jsp";
	}

}
