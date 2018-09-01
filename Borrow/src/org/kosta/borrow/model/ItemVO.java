package org.kosta.borrow.model;

import java.util.ArrayList;

public class ItemVO {
	private String itemNo;
	private String itemName;
	private String itemBrand;
	private String itemModel;
	private int itemPrice;
	private String itemRegDate;
	private String itemExpDate;
	private String itemStatus;
	private String itemExpl;
	private MemberVO memberVO;
	private ArrayList<String> picList ;
	private ArrayList<CategoryVO> catList;
	//private CategoryVO categoryVO;
	public ItemVO() {
		memberVO=new MemberVO();
		picList = new ArrayList<String>();
		catList = new ArrayList<CategoryVO>();
	}
	
	public ItemVO(String itemNo, String itemName, String itemExpl, int itemPrice, MemberVO memberVO) {
		super();
		this.itemNo = itemNo;
		this.itemName = itemName;
		this.itemExpl = itemExpl;
		this.itemPrice = itemPrice;
		this.memberVO = memberVO;
		picList = new ArrayList<String>();
		catList = new ArrayList<CategoryVO>();
	}
	
	public ItemVO(String itemNo, String itemName, String itemBrand, String itemModel, int itemPrice, String itemRegDate,
			String itemExpDate, String itemStatus, String itemExpl, MemberVO memberVO, ArrayList<String> picList,
			ArrayList<CategoryVO> catList) {
		super();
		this.itemNo = itemNo;
		this.itemName = itemName;
		this.itemBrand = itemBrand;
		this.itemModel = itemModel;
		this.itemPrice = itemPrice;
		this.itemRegDate = itemRegDate;
		this.itemExpDate = itemExpDate;
		this.itemStatus = itemStatus;
		this.itemExpl = itemExpl;
		this.memberVO = memberVO;
		this.picList = picList;
		this.catList = catList;
	}

	public ItemVO(String itemNo) {
		this.itemNo = itemNo;
	}
	public String getItemNo() {
		return itemNo;
	}
	public void setItemNo(String itemNo) {
		this.itemNo = itemNo;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public String getItemBrand() {
		return itemBrand;
	}
	public void setItemBrand(String itemBrand) {
		this.itemBrand = itemBrand;
	}
	public String getItemModel() {
		return itemModel;
	}
	public void setItemModel(String itemModel) {
		this.itemModel = itemModel;
	}
	public int getItemPrice() {
		return itemPrice;
	}
	public void setItemPrice(int itemPrice) {
		this.itemPrice = itemPrice;
	}
	public String getItemRegDate() {
		return itemRegDate;
	}
	public void setItemRegDate(String itemRegDate) {
		this.itemRegDate = itemRegDate;
	}
	public String getItemExpDate() {
		return itemExpDate;
	}
	public void setItemExpDate(String itemExpDate) {
		this.itemExpDate = itemExpDate;
	}
	public String getItemStatus() {
		return itemStatus;
	}
	public void setItemStatus(String itemStatus) {
		this.itemStatus = itemStatus;
	}
	public MemberVO getMemberVO() {
		return memberVO;
	}
	public void setMemberVO(MemberVO memberVO) {
		this.memberVO = memberVO;
	}
	
	public ArrayList<String> getPicList() {
		return picList;
	}

	public void setPicList(ArrayList<String> picList) {
		this.picList = picList;
	}

	public ArrayList<CategoryVO> getCatList() {
		return catList;
	}

	public void setCatList(ArrayList<CategoryVO> catList) {
		this.catList = catList;
	}

	public String getItemExpl() {
		return itemExpl;
	}
	public void setItemExpl(String itemExpl) {
		this.itemExpl = itemExpl;
	}

	@Override
	public String toString() {
		return "ItemVO [itemNo=" + itemNo + ", itemName=" + itemName + ", itemBrand=" + itemBrand + ", itemModel="
				+ itemModel + ", itemPrice=" + itemPrice + ", itemRegDate=" + itemRegDate + ", itemExpDate="
				+ itemExpDate + ", itemStatus=" + itemStatus + ", itemExpl=" + itemExpl + ", memberVO=" + memberVO
				+ ", picList=" + picList + ", catList=" + catList + "]";
	}

	
}
