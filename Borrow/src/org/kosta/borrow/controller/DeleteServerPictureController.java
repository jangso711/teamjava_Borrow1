package org.kosta.borrow.controller;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DeleteServerPictureController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String fileName = request.getParameter("fileName");
		String path =request.getServletContext().getRealPath("upload")+File.separator+fileName;
		System.out.println(path);
		File file = new File(path);
		file.delete();
		request.setAttribute("responsebody", "delete Success");
		return "AjaxView";
	}

}
