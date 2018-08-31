package org.kosta.borrow.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kosta.borrow.model.ItemDAO;
import org.kosta.borrow.model.ItemVO;

public class ItemDeleteController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String item_status = request.getParameter("item_status");
		ItemVO vo=new ItemVO();
		vo.setItemStatus(item_status);
		ItemDAO.getInstance().ItemDelete(vo);
		
		
		return "${pageContext.request.contextPath}/item_delete_result.jsp";
	}

}

