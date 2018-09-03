package org.kosta.borrow.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kosta.borrow.model.CategoryVO;
import org.kosta.borrow.model.ItemVO;

public class ItemUpdateController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ItemVO ivo = new ItemVO();
		String itemName = request.getParameter("itemName");
		String itemBrand = request.getParameter("itemBrand");
		String itemModel = request.getParameter("itemModel");
		String itemPrice = request.getParameter("itemPrice");
		String itemExpDate = request.getParameter("itemExpDate");
		String cats[] = request.getParameterValues("category");
		String itemExpl = request.getParameter("itemExpl");
		String[] pics = request.getParameterValues("pics");
		for(int i=0;i<pics.length;i++) {
			ivo.getPicList().add(pics[i]);
		}
		for(int i=0;i<cats.length;i++) {
			CategoryVO cvo = new CategoryVO();
			cvo.setCatNo(cats[i]);
			ivo.getCatList().add(cvo);
		}
		ivo.setItemName(itemName);
		ivo.setItemBrand(itemBrand);
		ivo.setItemModel(itemModel);
		ivo.setItemExpDate(itemExpDate);
		ivo.setItemExpl(itemExpl);
		ivo.setItemPrice(Integer.parseInt(itemPrice));
		
		return "redirect:index.jsp";
	}

}
