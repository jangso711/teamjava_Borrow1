package org.kosta.borrow.model;

public class RentalDetailVO {
	private String rentalNo;
	private String rentalDate;
	private String returnDate;
	private ItemVO itemVO;
	private MemberVO memberVO;
	int totalPayment;
	public RentalDetailVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public RentalDetailVO(String rentalNo, String rentalDate, String returnDate, ItemVO itemVO, MemberVO memberVO,
			int totalPayment) {
		super();
		this.rentalNo = rentalNo;
		this.rentalDate = rentalDate;
		this.returnDate = returnDate;
		this.itemVO = itemVO;
		this.memberVO = memberVO;
		this.totalPayment = totalPayment;
	}
	public String getRentalNo() {
		return rentalNo;
	}
	public void setRentalNo(String rentalNo) {
		this.rentalNo = rentalNo;
	}
	public String getRentalDate() {
		return rentalDate;
	}
	public void setRentalDate(String rentalDate) {
		this.rentalDate = rentalDate;
	}
	public String getReturnDate() {
		return returnDate;
	}
	public void setReturnDate(String returnDate) {
		this.returnDate = returnDate;
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
	public int getTotalPayment() {
		return totalPayment;
	}
	public void setTotalPayment(int totalPayment) {
		this.totalPayment = totalPayment;
	}
	@Override
	public String toString() {
		return "RentalDetailVO [rentalNo=" + rentalNo + ", rentalDate=" + rentalDate + ", returnDate=" + returnDate
				+ ", itemVO=" + itemVO + ", memberVO=" + memberVO + ", totalPayment=" + totalPayment + "]";
	}
	
}
