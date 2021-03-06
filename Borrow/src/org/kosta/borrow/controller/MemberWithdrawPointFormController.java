package org.kosta.borrow.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MemberWithdrawPointFormController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//int existingPoint=Integer.parseInt(request.getParameter("existingPoint"));
		String existingPoint=request.getParameter("existingPoint");
		request.setAttribute("existingPoint", existingPoint);
		request.setAttribute("url", "/member/member_withdraw_point_form.jsp");
		return "/template/layout.jsp";
	}

}
