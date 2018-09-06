package org.kosta.borrow.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kosta.borrow.model.ReviewDAO;
import org.kosta.borrow.model.ReviewVO;

public class ReviewPostByRentalNoController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String rentalNo=request.getParameter("rentalNo");		
		String num=ReviewDAO.getInstance().getReviewNoByRentalNo(rentalNo);	
		if(num==null)
			return "redirect:index.jsp";		
		int no=Integer.parseInt(num);
		//String num=request.getParameter("reviewNo");
		
		boolean isGet=false;
		  Cookie[] cookies=request.getCookies();
		  if(cookies!=null){
		   for(Cookie c: cookies){
		    if(c.getName().equals(num)){
		     isGet=true; 
		    }
		   }
		 
		   if(!isGet) {
		    Cookie c1 = new Cookie(num, num); 
		    c1.setMaxAge(1*24*60*60);
		    response.addCookie(c1);
		    ReviewDAO.getInstance().updateHit(no);
		   }
		  }

		ReviewVO rvo = ReviewDAO.getInstance().getPostingByNo(no);	
		request.setAttribute("rvo", rvo);
		request.setAttribute("url", "/review/review_post.jsp");
		return "/template/layout.jsp";
	}

}
