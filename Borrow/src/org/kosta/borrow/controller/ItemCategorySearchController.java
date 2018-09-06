package org.kosta.borrow.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.kosta.borrow.model.CategoryVO;
import org.kosta.borrow.model.ItemDAO;
import org.kosta.borrow.model.ItemVO;
import org.kosta.borrow.model.MemberVO;
import org.kosta.borrow.model.PagingBean;

public class ItemCategorySearchController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String categoryNo = request.getParameter("categoryNo");
		PagingBean pagingBean = null;
		String nowPage = request.getParameter("pageNum");
		HttpSession session=request.getSession();
		MemberVO mvo= (MemberVO) session.getAttribute("user");
		int totalPostCount=0;
		if(mvo==null) {
			totalPostCount = ItemDAO.getInstance().getItemNoListCountByCategory(categoryNo,null);
		}else {
			totalPostCount = ItemDAO.getInstance().getItemNoListCountByCategory(categoryNo,mvo.getId());
		}
		
		
		
		if(nowPage == null)
			pagingBean = new PagingBean(1, 6, totalPostCount);
		else
			pagingBean = new PagingBean(Integer.parseInt(nowPage), 6, totalPostCount);
		ArrayList<ItemVO> itemCategorySearchList = ItemDAO.getInstance().getItemNoListByCategory(categoryNo, pagingBean);
		
		//180906 MIRI 로그인 했을시에 자신이 등록한 상품은 카테고리에서 검색 불가 (아예 없을 시에 검색 결과 없다고 창띄우기)
	/*	HttpSession session = request.getSession(false);
		MemberVO sessionMemberVO = ((MemberVO)(session.getAttribute("user")));
		Iterator<ItemVO> iterator = itemCategorySearchList.iterator();
		while(iterator.hasNext()) {
			ItemVO vo= iterator.next();
			//세션 아이디와 ArrayList 아이디가 같으면 삭제
		    if(sessionMemberVO != null && vo.getMemberVO().getId().equals(sessionMemberVO.getId())) {
		        iterator.remove();
		    }
		}*/
		
		CategoryVO categoryVO = ItemDAO.getInstance().getCatNameByCatNo(categoryNo);
		request.setAttribute("itemCategorySearchList", itemCategorySearchList);
		request.setAttribute("categoryVO", categoryVO);
		request.setAttribute("pagingBean", pagingBean);
		
		request.setAttribute("url", "/item/item_category_search_result.jsp");		
		return "template/layout.jsp";
	}
}
