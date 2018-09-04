package org.kosta.borrow.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kosta.borrow.model.ItemDAO;
import org.kosta.borrow.model.ItemVO;

public class ItemDeleteController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String itemNo = request.getParameter("itemNo");
		ItemVO vo=new ItemVO();
		vo.setItemNo(itemNo);
		//yosep - 180904 주석처리, 파일 경로 삭제 불필요
		//String dirPath = request.getServletContext().getRealPath("upload");
		String dirPath=null;
		ItemDAO.getInstance().deleteItem(vo,dirPath);
		
		request.setAttribute("url", "/item/item_delete_result.jsp");
		return "template/layout.jsp";
	}

}

