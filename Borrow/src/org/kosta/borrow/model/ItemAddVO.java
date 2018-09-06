package org.kosta.borrow.model;

public class ItemAddVO {
	private int rentalCount;
	private double grade;
	public ItemAddVO() {
		
	}
	public ItemAddVO(int rentalCount, double grade, ItemVO itemVO) {
		super();
		this.rentalCount = rentalCount;
		this.grade = grade;
	}
	public int getRentalCount() {
		return rentalCount;
	}
	public void setRentalCount(int rentalCount) {
		this.rentalCount = rentalCount;
	}
	public double getGrade() {
		return grade;
	}
	public void setGrade(double grade) {
		this.grade = grade;
	}
	@Override
	public String toString() {
		return "ItemAddVO [rentalCount=" + rentalCount + ", grade=" + grade + "]";
	}
	 
}
