package org.kosta.borrow.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.kosta.borrow.model.MemberDAO;
import org.kosta.borrow.model.MemberVO;

public class MemberUpdateController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		HttpSession session=request.getSession(false);
		MemberVO user=null;
		if(session!=null&(user=(MemberVO)session.getAttribute("user"))!=null) {
			String id = user.getId();
			String pwd=request.getParameter("pwd");
			String name=request.getParameter("name");
			String address=request.getParameter("address");
			String tel=request.getParameter("tel");
			MemberVO vo=new MemberVO(id, pwd, name, address, tel, 0);
			MemberDAO.getInstance().updateMember(vo);		 	
			 return "front?command=MemberDetail";
		}else {
			//세션만료
			return "front?command=LoginForm";
		}
		//String id=((MemberVO)(session.getAttribute("user"))).getId();
		
	}

}
