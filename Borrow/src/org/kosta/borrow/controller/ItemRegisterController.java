package org.kosta.borrow.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.kosta.borrow.model.ItemDAO;
import org.kosta.borrow.model.ItemVO;
import org.kosta.borrow.model.MemberVO;
import org.kosta.borrow.model.PictureVO;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class ItemRegisterController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub

		//180831 MIRI Test 후 주석 수정
		String workspacePath="C:\\Users\\kosta\\git\\teamjava_Borrow1\\Borrow\\WebContent\\upload\\";
//		String savePath = request.getServletContext().getRealPath("upload");
//		MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());

		// 파일 크기 10MB로 제한
		int sizeLimit = 1024*1024*10;	
		//String workspacePath="C:\\Users\\kosta\\git\\teamjava_Borrow1\\Borrow\\WebContent\\upload\\";
		//MultipartRequest multi = new MultipartRequest(request, workspacePath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
		String savePath = request.getServletContext().getRealPath("upload");
		MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
		
			
		String fileName = multi.getFilesystemName("img");
		
		System.out.println("fileName:"+fileName);
		ItemVO ivo = new ItemVO();
		int itemNo;
		String name = multi.getParameter("itemName");
		String brand = multi.getParameter("itemBrand");
		String model = multi.getParameter("itemModel");
		int price = Integer.parseInt(multi.getParameter("itemPrice"));
		String[] cats= multi.getParameterValues("category");
		String expl = multi.getParameter("itemExpl");
		
		ivo.setItemName(name);
		ivo.setItemBrand(brand);
		ivo.setItemModel(model);
		ivo.setItemPrice(price);
		ivo.getPicList().add(fileName);
		HttpSession session = request.getSession(false);
		
		
		
		if(session!=null&&session.getAttribute("user")!=null) {
			MemberVO mvo = (MemberVO)session.getAttribute("user");
			itemNo=ItemDAO.getInstance().registerItem(mvo,ivo,cats,expl);
		}else {
			//세션만료
		}
		 
		
		
		//return "redirect:front?command=ItemDetail&";
		return "redirect:index.jsp";
	}

}
