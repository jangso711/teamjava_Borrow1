package org.kosta.borrow.model;

public class CategoryVO {
	private String catNo;
	private String catName;
	public CategoryVO() {
		
	}
	public CategoryVO(String catNo, String catName) {
		super();
		this.catNo = catNo;
		this.catName = catName;
	}
	public String getCatNo() {
		return catNo;
	}
	public void setCatNo(String catNo) {
		this.catNo = catNo;
	}
	public String getCatName() {
		return catName;
	}
	public void setCatName(String catName) {
		this.catName = catName;
	}
	@Override
	public String toString() {
		return "CategoryVO [catNo=" + catNo + ", catName=" + catName + "]";
	}
	
}
