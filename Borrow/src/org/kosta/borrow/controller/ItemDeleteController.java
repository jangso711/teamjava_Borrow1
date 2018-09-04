package org.kosta.borrow.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kosta.borrow.model.ItemDAO;
import org.kosta.borrow.model.ItemVO;

public class ItemDeleteController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String itemNo = request.getParameter("itemNo");
		String flag = request.getParameter("flag");
		ItemVO vo=new ItemVO();
		vo.setItemNo(itemNo);
<<<<<<< HEAD
		//yosep - 180904 주석처리, 파일 경로 삭제 불필요
		//String dirPath = request.getServletContext().getRealPath("upload");
		String dirPath=null;
		ItemDAO.getInstance().deleteItem(vo,dirPath);
=======
		//String dirPath = request.getServletContext().getRealPath("upload");
		
			ItemDAO.getInstance().deleteItem(vo,flag);
		
>>>>>>> branch 'master' of https://github.com/jangso711/teamjava_Borrow1.git
		
		request.setAttribute("url", "/item/item_delete_result.jsp");
		return "redirect:template/layout.jsp";
	}

}

