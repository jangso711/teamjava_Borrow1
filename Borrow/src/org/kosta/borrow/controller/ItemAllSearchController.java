package org.kosta.borrow.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.kosta.borrow.model.ItemDAO;
import org.kosta.borrow.model.ItemVO;
import org.kosta.borrow.model.MemberVO;
import org.kosta.borrow.model.PagingBean;

public class ItemAllSearchController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String nowPage = request.getParameter("pageNum");
		HttpSession session= request.getSession(false);
		MemberVO user= null;
		int totalPostCount=0;
		if(session!=null && (user=(MemberVO) session.getAttribute("user"))!=null ) {
			//로그인 상태일 경우 자신의 아이템은 제외하고 검색하기
			totalPostCount = ItemDAO.getInstance().getTotalItemCount(user.getId());
		}else {
			totalPostCount = ItemDAO.getInstance().getTotalItemCount(null);
		}
		PagingBean pagingBean = null;
		if(nowPage == null) {
			pagingBean = new PagingBean(1, 6, totalPostCount);
		}else {
			pagingBean = new PagingBean(Integer.parseInt(nowPage), 6, totalPostCount);
		}
		
		ArrayList<ItemVO> allItemList = ItemDAO.getInstance().getAllItemList(pagingBean,user);
		
		//180906 MIRI 로그인 했을시에 자신이 등록한 상품은 검색 불가 (아예 없을 시에 검색 결과 없다고 창띄우기)
//		HttpSession session = request.getSession(false);
//		MemberVO sessionMemberVO = ((MemberVO)(session.getAttribute("user")));
//		Iterator<ItemVO> iterator = allItemList.iterator();
//		while(iterator.hasNext()) {
//			ItemVO vo= iterator.next();
//			//세션 아이디와 ArrayList 아이디가 같으면 삭제
//		    if(sessionMemberVO != null && vo.getMemberVO().getId().equals(sessionMemberVO.getId())) {
//		        iterator.remove();
//		    }
//		}
		
		request.setAttribute("allItemList", allItemList);
		request.setAttribute("pagingBean", pagingBean);
		
		request.setAttribute("url", "/item/item_all_search_result.jsp");
		return "template/layout.jsp";
	}

}
