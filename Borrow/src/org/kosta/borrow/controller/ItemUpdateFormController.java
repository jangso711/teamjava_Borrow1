package org.kosta.borrow.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.kosta.borrow.model.CategoryVO;
import org.kosta.borrow.model.ItemDAO;
import org.kosta.borrow.model.ItemVO;

public class ItemUpdateFormController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String itemNo = request.getParameter("itemNo");
		ItemVO ivo = ItemDAO.getInstance().getDetailItemByNo(itemNo);
		ArrayList<CategoryVO> list = ItemDAO.getInstance().getAllCategories();
		JSONArray clist = new JSONArray(ivo.getCatList());
		request.setAttribute("catList", list);
		request.setAttribute("itemInfo", ivo);
		request.setAttribute("clist", clist);
		request.setAttribute("url", "/item/item_update_form.jsp");
		return "/template/layout.jsp";
	}

}
