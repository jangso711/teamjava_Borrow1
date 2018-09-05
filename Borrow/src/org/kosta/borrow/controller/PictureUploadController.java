package org.kosta.borrow.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class PictureUploadController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//180831 MIRI Test 후 주석 수정

	
		// 파일 크기 10MB로 제한
		int sizeLimit = 1024*1024*10;	
		String workPath=System.getProperty("user.home")+"\\git\\teamjava_Borrow1\\Borrow\\WebContent\\upload";
		MultipartRequest multi = new MultipartRequest(request, workPath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
		//String savePath = request.getServletContext().getRealPath("upload");
		//MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
		
		
		String fileName = multi.getFilesystemName("img");
		String orgName = multi.getOriginalFileName("img");
		JSONObject result = new JSONObject();
		result.put("fileName", fileName);
		result.put("orgName", orgName);
		request.setAttribute("responsebody", result);
		return "AjaxView";
	}

}
