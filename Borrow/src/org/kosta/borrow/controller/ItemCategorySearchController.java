package org.kosta.borrow.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kosta.borrow.model.CategoryVO;
import org.kosta.borrow.model.ItemDAO;
import org.kosta.borrow.model.ItemVO;
import org.kosta.borrow.model.PagingBean;

public class ItemCategorySearchController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		PagingBean pagingBean = null;
		String categoryNo = request.getParameter("categoryNo");
		String nowPage = request.getParameter("pageNum");
		int totalPostCount = ItemDAO.getInstance().getTotalItemCount();
		if(nowPage == null)
			pagingBean = new PagingBean(totalPostCount);
		else
			pagingBean = new PagingBean(totalPostCount, Integer.parseInt(nowPage));
		ArrayList<ItemVO> itemCategorySearchList = ItemDAO.getInstance().getItemNoListByCategory(categoryNo, pagingBean);
		CategoryVO categoryVO = ItemDAO.getInstance().getCatNameByCatNo(categoryNo);
		request.setAttribute("itemCategorySearchList", itemCategorySearchList);
		request.setAttribute("categoryVO", categoryVO);
		request.setAttribute("pagingBean", pagingBean);
		
		request.setAttribute("url", "/item/item_category_search_result.jsp");		
		return "template/layout.jsp";
	}
}
