package org.kosta.borrow.model;

public class MemberVO {
	private String id;
	private String pwd;
	private String name;
	private String address;
	private String tel;
	private int point;
	public MemberVO() {
		
	}
	public MemberVO(String id, String pwd, String name, String address, String tel, int point) {
		super();
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.address = address;
		this.tel = tel;
		this.point = point;
	}
	public MemberVO(String id) {
		this.id=id;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	@Override
	public String toString() {
		return "MemberVO [id=" + id + ", pwd=" + pwd + ", name=" + name + ", address=" + address + ", tel=" + tel
				+ ", point=" + point + "]";
	}
	
}
