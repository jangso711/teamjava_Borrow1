package org.kosta.borrow.model;

public class ReviewVO {
	private String reviewNo;
	private String reviewTitle;
	private String reviewContent;
	private double reviewGrade;
	private int reviewHit;
	private String reviewRegdate;
	private MemberVO memberVO;
	private RentalDetailVO rentalDetailVO;
	public ReviewVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public ReviewVO(RentalDetailVO rentalDetailVO) {
		super();
		this.rentalDetailVO = rentalDetailVO;
	}

	public ReviewVO(String reviewNo, String reviewTitle, String reviewContent, int reviewGrade, int reviewHit,
			String reviewRegdate, MemberVO memberVO, RentalDetailVO rentalDetailVO) {
		super();
		this.reviewNo = reviewNo;
		this.reviewTitle = reviewTitle;
		this.reviewContent = reviewContent;
		this.reviewGrade = reviewGrade;
		this.reviewHit = reviewHit;
		this.reviewRegdate = reviewRegdate;
		this.memberVO = memberVO;
		this.rentalDetailVO = rentalDetailVO;
	}
	public String getReviewNo() {
		return reviewNo;
	}
	public void setReviewNo(String reviewNo) {
		this.reviewNo = reviewNo;
	}
	public String getReviewTitle() {
		return reviewTitle;
	}
	public void setReviewTitle(String reviewTitle) {
		this.reviewTitle = reviewTitle;
	}
	public String getReviewContent() {
		return reviewContent;
	}
	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}
	public double getReviewGrade() {
		return reviewGrade;
	}
	public void setReviewGrade(double reviewGrade) {
		this.reviewGrade = reviewGrade;
	}
	public int getReviewHit() {
		return reviewHit;
	}
	public void setReviewHit(int reviewHit) {
		this.reviewHit = reviewHit;
	}
	public String getReviewRegdate() {
		return reviewRegdate;
	}
	public void setReviewRegdate(String reviewRegdate) {
		this.reviewRegdate = reviewRegdate;
	}
	public MemberVO getMemberVO() {
		return memberVO;
	}
	public void setMemberVO(MemberVO memberVO) {
		this.memberVO = memberVO;
	}
	public RentalDetailVO getRentalDetailVO() {
		return rentalDetailVO;
	}
	public void setRentalDetailVO(RentalDetailVO rentalDetailVO) {
		this.rentalDetailVO = rentalDetailVO;
	}
	
}
