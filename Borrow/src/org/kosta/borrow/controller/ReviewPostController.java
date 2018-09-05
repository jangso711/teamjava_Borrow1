package org.kosta.borrow.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kosta.borrow.model.ReviewDAO;
import org.kosta.borrow.model.ReviewVO;

public class ReviewPostController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		/*HttpSession session=request.getSession(false);
		if(session==null||session.getAttribute("user")==null){
			return "redirect:index.jsp";
		}*/
		int no=Integer.parseInt(request.getParameter("reviewNo"));
		/*@SuppressWarnings("unchecked")
		ArrayList<Integer> noList=(ArrayList<Integer>) session.getAttribute("noList");
		if(noList.contains(no)==false) {
			ReviewDAO.getInstance().updateHit(no);
			noList.add(no);
		}*/
		// 개별 게시물 조회  
		ReviewVO rvo = ReviewDAO.getInstance().getPostingByNo(no);	
		request.setAttribute("rvo", rvo);
		request.setAttribute("url", "/review/review_post.jsp");
		return "/template/layout.jsp";
	}
}
