package org.kosta.borrow.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kosta.borrow.model.ItemDAO;
import org.kosta.borrow.model.ItemVO;
import org.kosta.borrow.model.PictureVO;

public class ItemDetailController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ItemVO itemVO = ItemDAO.getInstance().getDetailItemByNo(request.getParameter("itemSearchId"));
		PictureVO itemDetail = new PictureVO();
		if(itemVO != null) {
			itemDetail = new PictureVO(ItemDAO.getInstance().getPicturePath(itemVO.getItemNo()), itemVO);
			request.setAttribute("itemDetail", itemDetail);
		}
		request.setAttribute("url", "/item/item_detail.jsp");		
		return "template/layout.jsp";
	}

}
