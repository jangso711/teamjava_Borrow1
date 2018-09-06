package org.kosta.borrow.controller;

import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kosta.borrow.model.ItemDAO;
import org.kosta.borrow.model.RentalDetailVO;

public class rentalCancelController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws SQLException, ParseException{
		String rentalNo = request.getParameter("rentalNo");	
		String point = request.getParameter("point");
		String result = null;
		RentalDetailVO rental = ItemDAO.getInstance().rentalCancel(rentalNo, point);
		if(rental == null) {
			result = "fail";
		}else {
			result = "ok";
		}
		request.setAttribute("responsebody", point);
		return "AjaxView";
	}

}
