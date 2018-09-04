package org.kosta.borrow.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.kosta.borrow.model.ItemDAO;
import org.kosta.borrow.model.ItemVO;
import org.kosta.borrow.model.MemberVO;

public class ItemRegisterController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		ItemVO ivo = new ItemVO();
		int itemNo=0;
		String name = request.getParameter("itemName");
		String brand = request.getParameter("itemBrand");
		String model = request.getParameter("itemModel");
		int price = Integer.parseInt(request.getParameter("itemPrice"));
		String[] cats= request.getParameterValues("category");
		String expl = request.getParameter("itemExpl");
		int month = Integer.parseInt(request.getParameter("duration"));
		
		ivo.setItemName(name);
		ivo.setItemBrand(brand);
		ivo.setItemModel(model);
		ivo.setItemPrice(price);
		//pictureList 받아오는 코드 추가
		String[] pics = request.getParameterValues("pics");
		for(int i=0;i<pics.length;i++) {
			ivo.getPicList().add(pics[i]);
		}
		
		HttpSession session = request.getSession(false);

		if(session!=null&&session.getAttribute("user")!=null) {
			MemberVO mvo = (MemberVO)session.getAttribute("user");
			itemNo=ItemDAO.getInstance().registerItem(mvo,ivo,cats,expl,month);
		}else {
			//세션만료
		}
		 
		
		
		return "redirect:front?command=ItemDetail&itemNo="+itemNo;
		//return "redirect:index.jsp";
	}

}
