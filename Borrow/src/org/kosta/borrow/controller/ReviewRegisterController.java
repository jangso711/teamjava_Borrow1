package org.kosta.borrow.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.kosta.borrow.model.ItemDAO;
import org.kosta.borrow.model.MemberVO;
import org.kosta.borrow.model.RentalDetailVO;
import org.kosta.borrow.model.ReviewDAO;
import org.kosta.borrow.model.ReviewVO;
/**
 * 180905
 * 후기 등록 컨트롤러
 * @author kosta TeamJAVA SOJEONG
 * 수정 중
 */
public class ReviewRegisterController implements Controller {

	@Override
	public String handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession(false);
		MemberVO user=null;
		if(session!=null && (user = (MemberVO)(session.getAttribute("user")))!=null) {
			String title = request.getParameter("reviewTitle");
			String contents= request.getParameter("reviewContents");
			String grade= request.getParameter("grade");
			String rentalNo = request.getParameter("rentalNo");
			ReviewVO review = new ReviewVO();
			RentalDetailVO rvo = new RentalDetailVO();
			rvo.setRentalNo(request.getParameter("rentalNo"));
			review.setReviewTitle(title);
			review.setReviewContent(contents);
			review.setMemberVO(user);
			review.setReviewGrade(Integer.parseInt(grade));
			review.setRentalDetailVO(ItemDAO.getInstance().itemRentDetail(rvo));
			int reviewNo = ReviewDAO.getInstance().registerReview(review);
			//정상등록 시 후기 상세보기 페이지로 이동
			//등록 뒤 상세보기 페이지 방문 시에는 조회수 올리지 않기 처리 추가필요!!!!!!!!
			return "redirect:front?command=ReviewPostByReviewNo&reviewNo="+reviewNo;
		}else {
			//세션만료는 로그인 창으로 다시가기
			return "redirect:front?command=LoginForm";
		}

		
	}

}
