package org.kosta.borrow.model;

public class PictureVO {
	private String picturePath;
	private ItemVO itemVO;
	
	public PictureVO() {
		
	}

	public PictureVO(String picturePath, ItemVO itemVO) {
		super();
		this.picturePath = picturePath;
		this.itemVO = itemVO;
	}

	public String getPicturePath() {
		return picturePath;
	}

	public void setPicturePath(String picturePath) {
		this.picturePath = picturePath;
	}

	public ItemVO getItemVO() {
		return itemVO;
	}

	public void setItemVO(ItemVO itemVO) {
		this.itemVO = itemVO;
	}

	@Override
	public String toString() {
		return "PictureVO [picturePath=" + picturePath + ", itemVO=" + itemVO + "]";
	}
	
}
