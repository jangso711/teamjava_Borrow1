package org.kosta.borrow.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kosta.borrow.model.ItemDAO;
import org.kosta.borrow.model.ItemVO;
import org.kosta.borrow.model.PictureVO;

public class ItemAllSearchController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ArrayList<ItemVO> itemList = ItemDAO.getInstance().getAllItemList();
		ArrayList<PictureVO> pictureList = new ArrayList<PictureVO>();
		if(itemList != null) {
			for (ItemVO itemVO : itemList) {
				pictureList.add(new PictureVO(ItemDAO.getInstance().getPicturePath(itemVO.getItemNo()), itemVO));
			}
			request.setAttribute("allItemList", pictureList);
		}
		request.setAttribute("url", "/item/item_all_search_result.jsp");		
		return "template/layout.jsp";
	}

}
