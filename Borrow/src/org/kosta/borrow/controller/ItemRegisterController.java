package org.kosta.borrow.controller;

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
		HttpSession session = request.getSession(false);
		MemberVO user = null;
		if(session!=null&&(user=(MemberVO)session.getAttribute("user"))!=null) {
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
			
			
			itemNo=ItemDAO.getInstance().registerItem(user,ivo,cats,expl,month);
			return "redirect:front?command=ItemDetail&itemNo="+itemNo;//0903 동규 물품등록시 상품 상세정보로이동하게 수정
		}else {
			//세션만료시 로그인폼으로 이동
			return "redirect:front?command=LoginForm";
		}
		 
		
		
		//return "redirect:front?command=ItemDetail&itemNo="+itemNo;
		//return "redirect:index.jsp";
	}

}
