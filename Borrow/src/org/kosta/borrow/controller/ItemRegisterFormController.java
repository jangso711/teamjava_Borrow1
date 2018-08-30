package org.kosta.borrow.controller;


import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kosta.borrow.model.CategoryVO;
import org.kosta.borrow.model.ItemDAO;

public class ItemRegisterFormController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setAttribute("url","/item/item_register_form.jsp");
		ArrayList<CategoryVO> list = ItemDAO.getInstance().getAllCategories();
		System.out.println(list);
		request.setAttribute("catList", list);
		return "/template/layout.jsp";
	}

}
