package org.kosta.borrow.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kosta.borrow.model.MemberDAO;

public class MemberIdCheckController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		boolean flag = MemberDAO.getInstance().idCheck(id);
		String result = null;
		if (flag) 
			result = "fail";
		 else 
			result = "ok";
		
		request.setAttribute("responsebody", result);
		return "AjaxView";
	}

}
