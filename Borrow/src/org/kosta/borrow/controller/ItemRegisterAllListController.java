package org.kosta.borrow.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.kosta.borrow.model.ItemDAO;
import org.kosta.borrow.model.ItemVO;
import org.kosta.borrow.model.MemberVO;
import org.kosta.borrow.model.PagingBean;

public class ItemRegisterAllListController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id=request.getParameter("memberId");//null일 경우는 자신이 등록한 물품
		boolean flag = false;
		if(id==null) {
			HttpSession session = request.getSession(false);
			MemberVO user= null;
			if(session!=null && (user=(MemberVO) session.getAttribute("user"))!=null ) {
				id = user.getId();
				flag=true;
			}else {
				//자신의 등록물품 검색 시 세션 만료된 경우
				return "redirect:front?command=LoginForm";
			}
		}
		int totalPostCount = ItemDAO.getInstance().getTotalItemCountById(id,flag);
		String nowPage = request.getParameter("pageNo");
		PagingBean pagingBean = null;
		if(nowPage == null)
			pagingBean = new PagingBean(1,3,totalPostCount);
		else
			pagingBean = new PagingBean(Integer.parseInt(nowPage), 3,totalPostCount);		
		
		ArrayList<ItemVO> allItemList = ItemDAO.getInstance().getAllItemListById(id, pagingBean,flag);
		request.setAttribute("allItemList", allItemList);
		request.setAttribute("pagingBean", pagingBean);
		request.setAttribute("memberId", id);
		request.setAttribute("url", "/item/item_register_all_list.jsp");
		return "template/layout.jsp";
	}

}
