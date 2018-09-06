package org.kosta.borrow.model;

public class PagingBean {

	 private int nowPage = 1;

	 private int postCountPerPage = 5;

	 private int pageCountPerPageGroup = 4;

	 private int totalPostCount;

	 public PagingBean() {
	 }

	 public PagingBean(int totalPostCount) {
	  this.totalPostCount = totalPostCount;
	 }

	 public PagingBean(int totalPostCount, int nowPage) {
	  this.totalPostCount = totalPostCount;
	  this.nowPage = nowPage;
	 }
	 
	 
	 	
	 public PagingBean(int nowPage, int postCountPerPage, int totalPostCount) {
		super();
		this.nowPage = nowPage;
		this.postCountPerPage = postCountPerPage;
		this.totalPostCount = totalPostCount;
	}

	public int getNowPage() {
	  return nowPage;
	 }

	 public int getStartRowNumber() {
	  return (nowPage-1)*postCountPerPage+1;
	 }

	 public int getEndRowNumber() {
		 int endRowNumber=nowPage*postCountPerPage;
		 if(totalPostCount<endRowNumber) {
			 endRowNumber=totalPostCount;
		 }
	  return endRowNumber;
	 }

	 private int getTotalPage() {  
		 int num=totalPostCount%postCountPerPage;
		 int totalPage=0;
		 if(num==0) {
			 totalPage=totalPostCount/postCountPerPage;
		 }else {
			 totalPage=totalPostCount/postCountPerPage+1;
		 }
	  return totalPage;
	 }

	 private int getTotalPageGroup() { 
		 int num=getTotalPage()%pageCountPerPageGroup;
		 int totalPageGroup=0;
		 if(num==0) {
			 totalPageGroup=getTotalPage()/pageCountPerPageGroup;
		 }else {
			 totalPageGroup=getTotalPage()/pageCountPerPageGroup+1;
		 }
	  return totalPageGroup;
	 }

	 private int getNowPageGroup() {
		 int num=nowPage%pageCountPerPageGroup;
		 int nowPageGroup=0;
		 if(num==0) {
			 nowPageGroup=nowPage/pageCountPerPageGroup;
		 }else {
			 nowPageGroup=nowPage/pageCountPerPageGroup+1;
		 }
	  return nowPageGroup;
	 }

	 public int getStartPageOfPageGroup() {  
	  return pageCountPerPageGroup*(getNowPageGroup()-1)+1;
	 }

	 public int getEndPageOfPageGroup() {
	  int num=getNowPageGroup()*pageCountPerPageGroup;
	  if(num>getTotalPage()) {
		  num=getTotalPage();
	  }
	  return num;
	 }

	 public boolean isPreviousPageGroup() {
	  boolean flag = false;
	  if(getNowPageGroup()>1) {
		  flag=true;
	  }
	  return flag;
	 }

	 public boolean isNextPageGroup() {
	  boolean flag = false;
	  if(getTotalPageGroup()>getNowPageGroup()) {
		  flag=true;
	  }
	  return flag;
	 }
}
