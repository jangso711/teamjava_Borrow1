package org.kosta.borrow.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.kosta.borrow.model.ItemDAO;
import org.kosta.borrow.model.ItemVO;
import org.kosta.borrow.model.MemberVO;

public class ItemRegisterAllListController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session=request.getSession();
		MemberVO user=(MemberVO) session.getAttribute("user");
		String id=user.getId();		
		ArrayList<ItemVO> allItemList = ItemDAO.getInstance().getAllItemListById(id);
		request.setAttribute("allItemList", allItemList);
		request.setAttribute("url", "/item/item_register_all_list.jsp");
		return "template/layout.jsp";
	}

}
