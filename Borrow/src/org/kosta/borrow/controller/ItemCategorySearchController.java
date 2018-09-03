package org.kosta.borrow.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kosta.borrow.model.CategoryVO;
import org.kosta.borrow.model.ItemDAO;
import org.kosta.borrow.model.ItemVO;

public class ItemCategorySearchController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String categoryNo = request.getParameter("categoryNo");
		ArrayList<ItemVO> itemCategorySearchList = ItemDAO.getInstance().getItemNoListByCategory(categoryNo);
		CategoryVO categoryVO = ItemDAO.getInstance().getCatNameByCatNo(categoryNo);
		request.setAttribute("itemCategorySearchList", itemCategorySearchList);
		request.setAttribute("categoryVO", categoryVO);
		
		request.setAttribute("url", "/item/item_category_search_result.jsp");		
		return "template/layout.jsp";
	}
}
