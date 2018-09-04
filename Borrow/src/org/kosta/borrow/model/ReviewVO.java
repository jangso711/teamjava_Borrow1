package org.kosta.borrow.model;

public class ReviewVO {
	String itemNo;
	String reviewTitle;
	String reviewContent;
	int reviewGrade;
	int reviewHit;
	String reviewRegdate;
	ItemVO itemVO;
	MemberVO memberVO;
	RentalDetailVO rentalDetailVO;
	public ReviewVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ReviewVO(String itemNo, String reviewTitle, String reviewContent, int reviewGrade, int reviewHit,
			String reviewRegdate, ItemVO itemVO, MemberVO memberVO, RentalDetailVO rentalDetailVO) {
		super();
		this.itemNo = itemNo;
		this.reviewTitle = reviewTitle;
		this.reviewContent = reviewContent;
		this.reviewGrade = reviewGrade;
		this.reviewHit = reviewHit;
		this.reviewRegdate = reviewRegdate;
		this.itemVO = itemVO;
		this.memberVO = memberVO;
		this.rentalDetailVO = rentalDetailVO;
	}
	public String getItemNo() {
		return itemNo;
	}
	public void setItemNo(String itemNo) {
		this.itemNo = itemNo;
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
	public int getReviewGrade() {
		return reviewGrade;
	}
	public void setReviewGrade(int reviewGrade) {
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
	public ItemVO getItemVO() {
		return itemVO;
	}
	public void setItemVO(ItemVO itemVO) {
		this.itemVO = itemVO;
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
	@Override
	public String toString() {
		return "ReviewVO [itemNo=" + itemNo + ", reviewTitle=" + reviewTitle + ", reviewContent=" + reviewContent
				+ ", reviewGrade=" + reviewGrade + ", reviewHit=" + reviewHit + ", reviewRegdate=" + reviewRegdate
				+ ", itemVO=" + itemVO + ", memberVO=" + memberVO + ", rentalDetailVO=" + rentalDetailVO + "]";
	}
	
}
