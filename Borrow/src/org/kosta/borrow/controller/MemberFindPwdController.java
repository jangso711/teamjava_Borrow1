package org.kosta.borrow.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kosta.borrow.model.MemberDAO;
import org.kosta.borrow.model.MemberVO;

public class MemberFindPwdController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id=request.getParameter("id");
		String name=request.getParameter("name");
		String tel=request.getParameter("tel");
		MemberVO vo=MemberDAO.getInstance().findPwd(id,name,tel);
		String result=null;
		if(vo==null)
			result="회원정보가 틀립니다";
		else
			result="비밀번호 : "+vo.getPwd();
		request.setAttribute("responsebody",result);
		return "AjaxView";
	}

}
