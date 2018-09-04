package org.kosta.borrow.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kosta.borrow.model.ItemDAO;
import org.kosta.borrow.model.ItemVO;

public class ItemDeleteController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String itemNo = request.getParameter("itemNo");
		String flag = request.getParameter("flag");
		ItemVO vo=new ItemVO();
		vo.setItemNo(itemNo);
		//String dirPath = request.getServletContext().getRealPath("upload");
		
			ItemDAO.getInstance().deleteItem(vo,flag);
		
		
		request.setAttribute("url", "/item/item_delete_result.jsp");
		return "redirect:template/layout.jsp";
	}

}

