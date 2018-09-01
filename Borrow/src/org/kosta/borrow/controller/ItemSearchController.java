package org.kosta.borrow.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kosta.borrow.model.ItemDAO;
import org.kosta.borrow.model.ItemVO;
import org.kosta.borrow.model.PictureVO;

public class ItemSearchController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String searchtext= request.getParameter("searchtext");
		ArrayList<ItemVO> itemList = ItemDAO.getInstance().getAllItemListByName(searchtext);
		/*ArrayList<PictureVO> pictureList = new ArrayList<PictureVO>();
		if(itemList != null) {
			for (ItemVO itemVO : itemList) {
				pictureList.add(new PictureVO(ItemDAO.getInstance().getPicturePath(itemVO.getItemNo()), itemVO));
			}
		}
		request.setAttribute("itemSearchList", pictureList);*/
		request.setAttribute("url", "/item/item_search_result.jsp");		
		return "template/layout.jsp";
	}

}
