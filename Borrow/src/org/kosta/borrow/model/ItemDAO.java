package org.kosta.borrow.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import javax.sql.DataSource;

import org.kosta.borrow.exception.BalanceShortageException;

public class ItemDAO {
	private static ItemDAO instance = new ItemDAO();
	private DataSource dataSource;
	private ItemDAO() {
		this.dataSource= DataSourceManager.getInstance().getDataSource();
	}
	public static ItemDAO getInstance() {
		return instance;
	}
	public Connection getConnection() throws SQLException {
		return dataSource.getConnection();
	}
	private void closeAll(PreparedStatement pstmt, Connection con) throws SQLException {
		if(pstmt!=null)pstmt.close();
		if(con!=null)con.close();
	}
	private void closeAll(ResultSet rs, PreparedStatement pstmt, Connection con) throws SQLException {
		if(rs!=null)rs.close();
		if(pstmt!=null)pstmt.close();
		if(con!=null)con.close();
	}

	public void deleteItem(ItemVO vo,String flag) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ArrayList<String> picList= null;
		try {
			con=getConnection();
			String sql="";
			if(flag.equals("true")) {
				sql = "update item set item_status=0,item_expdate=to_char(sysdate,'YYYY-MM-DD') where item_no=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(vo.getItemNo()));
				pstmt.executeUpdate();
				// 180905 JB 상품삭제시 후기 삭제 추가
				pstmt.close();
				sql = "delete from review where item_no = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(vo.getItemNo()));
			}else {
				sql = "update item set item_status=0,item_expdate=? where item_no=?"; 
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, flag);
				pstmt.setInt(2, Integer.parseInt(vo.getItemNo()));
				pstmt.executeUpdate();
				// 180905 JB 상품삭제시 후기 삭제 추가
				pstmt.close();
				sql = "delete from review where item_no = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(vo.getItemNo()));
			}
			pstmt.executeUpdate();	
		}finally {
			closeAll(pstmt, con);
		}

	}
	
	public RentalDetailVO itemRental(RentalDetailVO vo) throws SQLException, java.text.ParseException, BalanceShortageException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;	
		try {
			int buyerPoint=MemberDAO.getInstance().getPointByMemberId(vo.getMemberVO().getId()) ; //대여자 보유 포인트
			int dDate = calDateBetweenAandB(vo.getRentalDate(), vo.getReturnDate());
			int price= getDetailItemByNo(vo.getItemVO().getItemNo()).getItemPrice();
			int requiredPoint= dDate*price;  //구매에 필요한 포인트
			if(buyerPoint<requiredPoint) {
				//잔액 부족시 exception 발생
				throw new BalanceShortageException();				
			}
			int totalDate = calDateBetweenAandB(vo.getRentalDate(), vo.getReturnDate());
			int totalPayment = price*totalDate;
			System.out.println(totalPayment);
			
			con=getConnection();
			pstmt = con.prepareStatement("select item_regdate, item_expdate from item");
			String sql = "INSERT INTO rental_details (rental_no, item_no, id, rental_date, return_date, total_payment) VALUES (rental_no_seq.nextval, ?, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getItemVO().getItemNo());
			pstmt.setString(2, vo.getMemberVO().getId());
			pstmt.setString(3, vo.getRentalDate());
			pstmt.setString(4, vo.getReturnDate());
			pstmt.setInt(5, totalPayment);
			pstmt.executeUpdate();
			pstmt.close();
			pstmt=con.prepareStatement("select rental_no_seq.currval from dual");
			rs = pstmt.executeQuery();
			if(rs.next()) {
				vo.setRentalNo(rs.getString(1));
			}
			rs.close();
			pstmt.close();
			
			//송금 작업			
			String receiverId = getProductOwnerId(vo.getItemVO().getItemNo());
			String senderId =vo.getMemberVO().getId();
			MemberDAO.getInstance().transferPoint(receiverId, senderId, requiredPoint);
			//
			
			String sql2 = "update item_add set rental_count = RENTAL_count +1 where item_no = ?";
			pstmt = con.prepareStatement(sql2);
			pstmt.setString(1, vo.getItemVO().getItemNo());
			pstmt.executeUpdate();
		}finally {
			
			closeAll(pstmt, con);
		}
		return vo;
	}
	
   /**
    * itemNo에 해당하는 등록자의 Id를 반환
    * 주인이 없으면 null반환
    * @param itemId
    * @return
 * @throws SQLException 
    */
	public String getProductOwnerId(String itemNo) throws SQLException {
		PreparedStatement pstmt=null;
		ResultSet rs= null;
		Connection con=null;
		String ownerId=null;
		try {
			con=dataSource.getConnection();
			String sql="select id from 	item where item_no=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, itemNo);	
			rs=pstmt.executeQuery();
			if(rs.next()) {
				ownerId=rs.getString(1);
			}			
		}finally {
			closeAll(rs, pstmt, con);			
		}		
		return ownerId;		
	}
	
	/**
	 * 180905 MIRI 진행중
	 * Item table에 있는 item의 총 개수를 반환한다.
	 * @param itemNo
	 * @return
	 * @throws SQLException 
	 */
	public int getTotalItemCount(String exceptId) throws SQLException {
		int totItemCnt = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			String sql="select count(*) from item where item_status=1 and item_expdate>sysdate and id!=?";
			pstmt = con.prepareStatement(sql);
			if(exceptId==null) {
				pstmt.setString(1, "admin");
			}else {
				pstmt.setString(1, exceptId);
			}
			
			rs = pstmt.executeQuery();
			if(rs.next())
				totItemCnt = rs.getInt(1);
			System.out.println(totItemCnt);
		} finally {
			closeAll(rs, pstmt, con);
		}
		return totItemCnt;
	}
	
	
	public int getTotalItemCountById(String id) throws SQLException {
		int totItemCnt = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			String sql="select count(*) from item where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next())
				totItemCnt = rs.getInt(1);
		} finally {
			closeAll(rs, pstmt, con);
		}
		return totItemCnt;
	}

	/**
	 * 180831 MIRI 진행중
	 * 180903 MIRI 완료
	 * Item table에서 이름 중에 검색어(searchtext)포함하는 상품들을 전부 찾아서 ArrayList로 반환한다 
	 * @param searchtext
	 * @return
	 * @throws SQLException 
	 */
 	public ArrayList<ItemVO> getAllItemListByName(String searchtext, PagingBean pagingBean) throws SQLException {
		ArrayList<String> picList = null;
		ArrayList<ItemVO> list = new ArrayList<ItemVO>();
		ItemVO itemVO = new ItemVO();
		MemberVO memberVO = null;
		StringBuilder sb = new StringBuilder();
		searchtext = "%"+searchtext+"%";
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			sb.append(" select r.id, r.item_no, r.item_name, r.item_expl, r.item_price");
			sb.append(" from(");
			sb.append(" select row_number() over(order by item_no desc) as rnum,");
			sb.append(" id, item_no, item_name, item_expl, item_price");
			sb.append(" from item");
			sb.append(" where item_status=1 and item_name like ?");
			sb.append(" ) r");
			sb.append(" where r.rnum between ? and ?");
			sb.append(" order by item_no desc");	//180904 MIRI 내림차순으로 변경
			pstmt = con.prepareStatement(sb.toString());
			pstmt.setString(1, searchtext);
			pstmt.setInt(2, pagingBean.getStartRowNumber());
			pstmt.setInt(3, pagingBean.getEndRowNumber());
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				memberVO = new MemberVO();
				memberVO.setId(rs.getString(1));
				itemVO = new ItemVO(rs.getString(2), rs.getString(3), rs.getString(4), rs.getInt(5), memberVO);
				//180903 MIRI 해당 상품번호에 맞는 사진이 있으면 리스트를 전부 불러와 set 시킴
				picList = getPictureList(rs.getString(2));
				if(picList != null) 
					itemVO.setPicList(picList);
				list.add(itemVO);
			}
		}finally {
			closeAll(rs, pstmt, con);
		}
		return list;
	}
 	
 	/**
 	 * 180906 MIRI 완료
 	 * 아이템 이름 검색시 토탈 카운트
 	 * @param searchtext
 	 * @return
 	 * @throws SQLException
 	 */
 	public int getAllItemListCountByName(String searchtext) throws SQLException {
		StringBuilder sb = new StringBuilder();
		int count = 0;
		searchtext = "%"+searchtext+"%";
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			sb.append(" select count(*) from item");
			sb.append(" where item_status=1 and item_name like ?");
			pstmt = con.prepareStatement(sb.toString());
			pstmt.setString(1, searchtext);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}finally {
			closeAll(rs, pstmt, con);
		}
		return count;
	}    
	
	/**
	 * 180831 MIRI 진행중
	 * 180901 MIRI 완료
	 * itemNo를 이용해 해당 상품의 상세 정보를 반환한다.
	 * @param itemno
	 * @return
	 * @throws SQLException 
	 */
	public ItemVO getDetailItemByNo(String itemno) throws SQLException {
		ItemVO itemVO = null;
		MemberVO memberVO = null;
		ArrayList<String> picList = null;
		ArrayList<CategoryVO> catList = null;
		StringBuilder sb = new StringBuilder();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			sb.append(" select i.id, i.item_name, i.item_brand, i.item_model, i.item_price, to_char(i.item_regdate, 'yyyy-MM-dd') as item_regdate,");
			sb.append(" to_char(i.item_expdate, 'yyyy-MM-dd') as item_expdate, i.item_expl, round(a.grade,2),i.item_status from item i, item_add a ");
			sb.append(" where (i.item_no=a.item_no and i.item_status=1 or (item_status=0 and item_expdate>sysdate) )and i.item_no=?"); //180904 MIRI 불필요한 정렬 삭제
			pstmt = con.prepareStatement(sb.toString());
			pstmt.setString(1, itemno);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				memberVO = new MemberVO();
				memberVO.setId(rs.getString(1));
				//180901 MIRI 해당 상품번호에 맞는 카테고리가 있으면 리스트를 전부 불러와 set 시킴
				catList = getCategoryList(itemno);
				if(catList != null) {
					picList = getPictureList(itemno);
					itemVO = new ItemVO(itemno, rs.getString(2), rs.getString(3), rs.getString(4), rs.getInt(5), 
							rs.getString(6), rs.getString(7), "1", rs.getString(8), memberVO, picList, catList);
					ItemAddVO itemAddVO=new ItemAddVO();
					itemAddVO.setGrade(rs.getDouble(9));
					itemVO.setItemStatus(rs.getString(10));
					itemVO.setItemAddVO(itemAddVO);
					System.out.println("check1");
				}
				System.out.println("check2");
			}
		}finally {
			closeAll(rs, pstmt, con);
		}
		return itemVO;
	}
	/**
	 * 180831 MIRI 진행 중
	 * 180901 MIRI 완료
	 * Item table에 저장되어 있는 모든 상품들을 찾아서 ArrayList로 반환한다.
	 * @return
	 * @throws SQLException 
	 */
	public ArrayList<ItemVO> getAllItemList(PagingBean pagingBean,MemberVO user) throws SQLException {
		ArrayList<String> picList = null;
		ArrayList<ItemVO> list = new ArrayList<ItemVO>();
		ItemVO itemVO = new ItemVO();
		MemberVO memberVO = null;
		StringBuilder sb = new StringBuilder();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			sb.append(" select r.item_no, r.item_name, r.item_expl, r.item_price, r.id, round(r.grade,2)");
			sb.append(" from (");			
			sb.append(" select row_number() over(order by item_regdate desc) as rnum, i.item_no, i.item_name, i.item_expl, i.item_price, i.id, round(a.grade,2) as grade");
			if(user!=null) {	//로그인 상태인 경우
				sb.append(" from item i , item_add a where i.item_no=a.item_no and i.id!=? and item_status=1) r");		
			}else {//로그인 x인 경우
				sb.append(" from item i , item_add a where i.item_no=a.item_no and item_status=1) r");		
			}
			sb.append(" where r.rnum between ? and ?");
			pstmt = con.prepareStatement(sb.toString());
			
			if(user!=null) {	//로그인 상태인 경우
				System.out.println("로그인상태");
				pstmt.setString(1,user.getId());
				pstmt.setInt(2, pagingBean.getStartRowNumber());
				pstmt.setInt(3, pagingBean.getEndRowNumber());
			}else {
				pstmt.setInt(1, pagingBean.getStartRowNumber());
				pstmt.setInt(2, pagingBean.getEndRowNumber());
			}

			rs = pstmt.executeQuery();

			while(rs.next()) {
				memberVO = new MemberVO();
				memberVO.setId(rs.getString(5));
				itemVO = new ItemVO(rs.getString(1), rs.getString(2), rs.getString(3), rs.getInt(4),  memberVO);
				ItemAddVO itemAddVO= new ItemAddVO();
				itemAddVO.setGrade(rs.getDouble(6));
				itemVO.setItemAddVO(itemAddVO);
				picList = getPictureList(rs.getString(1));
				if(picList != null) 
					itemVO.setPicList(picList);
				list.add(itemVO);
			}
		}finally {
			closeAll(rs, pstmt, con);
		}
		return list;
	}
	
	public ArrayList<ItemVO> getAllItemListById(String id, PagingBean pagingBean,boolean flag) throws SQLException {
		ArrayList<String> picList = null;
		ArrayList<ItemVO> list = new ArrayList<ItemVO>();
		ItemVO itemVO = new ItemVO();
		MemberVO memberVO = null;
		StringBuilder sb = new StringBuilder();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			sb.append(" select r.rnum, r.item_no, r.item_name, r.item_expl, r.item_price, r.id");
			sb.append(" from (");
			sb.append(" select row_number() over(order by item_regdate desc) as rnum, item_no, item_name, item_expl, item_price, id");
			if(flag) {
				sb.append(" from item where id=? and item_status=1 or(item_status=0 and item_expdate>sysdate)) r, member m");
			}else {
				sb.append(" from item where id=? and item_status=1) r, member m");
			}
			sb.append(" where r.rnum between ? and ? and r.id=m.id");
			sb.append(" order by item_no desc");
			pstmt = con.prepareStatement(sb.toString());
			pstmt.setString(1, id);
			pstmt.setInt(2, pagingBean.getStartRowNumber());
			pstmt.setInt(3, pagingBean.getEndRowNumber());
			rs = pstmt.executeQuery();

			while(rs.next()) {
				memberVO = new MemberVO();
				memberVO.setId(rs.getString(5));
				itemVO = new ItemVO(rs.getString(2), rs.getString(3), rs.getString(4), rs.getInt(5),  memberVO);
				picList = getPictureList(rs.getString(2));
				if(picList != null) 
					itemVO.setPicList(picList);
				list.add(itemVO);
			}
		}finally {
			closeAll(rs, pstmt, con);
		}
		return list;
	}
	
	/**
	 * 180831 MIRI 진행 중
	 * 180901 MIRI 완료
	 * Item No를 이용해 해당 상품에 맞는 사진 이름 리스트를 반환한다.
	 * @param itemNo
	 * @return
	 * @throws SQLException 
	 */
	public ArrayList<String> getPictureList(String itemNo) throws SQLException {
		//180901 MIRI 상품에 맞는 사진이 여러장일 수 있으니 ArrayList로 반환하도록 수정
		ArrayList<String> picList = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			String sql = "select picture_path from picture where item_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, itemNo);
			rs = pstmt.executeQuery();
			
			picList = new ArrayList<String>();
			while(rs.next())
				picList.add(rs.getString(1));
			//180902 yosep 사진이 없을경우 기존 jsp에 있던 코드들 전부 주석처리하고 여기서 진행
			//180904 MIRI 사진 없으면 업로드 X
			/*if(picList.isEmpty())
				picList.add("디폴트.png");*/
		} finally {
			closeAll(rs, pstmt, con);
		}
		return picList;
	}
	
	/**
	 * 180901 MIRI 완료
	 * Item No를 이용해 해당 상품에 맞는 카테고리 리스트를 반환한다.
	 * @param itemNo
	 * @return
	 * @throws SQLException 
	 */
	public ArrayList<CategoryVO> getCategoryList(String itemNo) throws SQLException {
		//180901 MIRI 상품에 맞는 카테고리를 다수로 받기 위해 ArrayList로 반환 타입 지정
		ArrayList<CategoryVO> catList = null;
		StringBuilder sb = new StringBuilder();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			sb.append(" select c.cat_no, c.cat_name");
			sb.append(" from item_category ic, category c");
			sb.append(" where ic.cat_no=c.cat_no and ic.item_no=?");
			pstmt = con.prepareStatement(sb.toString());
			pstmt.setString(1, itemNo);
			rs = pstmt.executeQuery();
			
			catList = new ArrayList<CategoryVO>();
			while(rs.next())
				catList.add(new CategoryVO(rs.getString(1), rs.getString(2)));
		} finally {
			closeAll(rs, pstmt, con);
		}
		return catList;
	}
	
	/**
	 * 180903 MIRI 완료
	 * Main 화면에서 카테고리를 클릭하면 해당 카테고리로 등록된 상품들의 itemNo를 찾아서 ArrayList로 반환한다 
	 * @param catno
	 * @return
	 * @throws SQLException 
	 */
	public ArrayList<ItemVO> getItemNoListByCategory(String catno, PagingBean pagingBean, String exceptId) throws SQLException {
		ArrayList<String> picList = null;
		ArrayList<ItemVO> list = new ArrayList<ItemVO>();
		ItemVO itemVO = new ItemVO();
		MemberVO memberVO = null;
		StringBuilder sb = new StringBuilder();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			sb.append(" select r.id, r.item_no, r.item_name, r.item_expl, r.item_price, r.cat_name, round(r.grade,2)" );
			sb.append(" from (");
			sb.append(" select row_number() over(order by i.item_regdate desc) as rnum, ");
			sb.append(" i.id, i.item_no, i.item_name, i.item_expl, i.item_price, c.cat_name, round(a. grade,2) as grade ");
			sb.append(" from item i, item_category ic, category c, item_add a ");
			sb.append(" where i.item_expdate>sysdate and i.item_no=a.item_no and i.item_status=1 and i.item_no=ic.item_no and ic.cat_no=c.cat_no and ic.cat_no=? and i.id!=?");
			sb.append(" ) r");
			sb.append(" where r.rnum between ? and ?");
			pstmt = con.prepareStatement(sb.toString());
			pstmt.setString(1, catno);
			if(exceptId==null) {
				pstmt.setString(2, "admin");
			}else{
				pstmt.setString(2, exceptId);
			}
			pstmt.setInt(3, pagingBean.getStartRowNumber());
			pstmt.setInt(4, pagingBean.getEndRowNumber());
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				memberVO = new MemberVO();
				memberVO.setId(rs.getString(1));
				itemVO = new ItemVO(rs.getString(2), rs.getString(3), rs.getString(4), rs.getInt(5), memberVO);
				ItemAddVO itemAddVO= new ItemAddVO();
				itemAddVO.setGrade(rs.getDouble(7));
				itemVO.setItemAddVO(itemAddVO);
				picList = getPictureList(rs.getString(2));
				if(picList != null) 
					itemVO.setPicList(picList);
				list.add(itemVO);
			}
		}finally {
			closeAll(rs, pstmt, con);
		}
		return list;
	}
	
	/**
	 * 180906 MIRI 완료
	 * 카테고리 검색시 토탈 카운트
	 * @param catno
	 * @param object 
	 * @return
	 * @throws SQLException
	 */
	public int getItemNoListCountByCategory(String catno, String exceptId) throws SQLException {
		StringBuilder sb = new StringBuilder();
		int count = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			sb.append(" select count(*)");
			sb.append(" from item i, item_category ic, category c");
			sb.append(" where i.item_status=1 and i.item_no=ic.item_no and ic.cat_no=c.cat_no and i.item_expdate>sysdate and ic.cat_no=? and i.id!=?");
			pstmt = con.prepareStatement(sb.toString());
			pstmt.setString(1, catno);
			if(exceptId==null) {
				pstmt.setString(2, "admin");
			}else {
				pstmt.setString(2, exceptId);
			}
			rs = pstmt.executeQuery();
			
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}finally {
			closeAll(rs, pstmt, con);
		}
		return count;
	}
	
	/**
	 * 180903 MIRI 완료
	 * catNo를 이용해 catName을 찾은 뒤 CategoryVO를 반환한다.
	 * @return
	 * @throws SQLException 
	 */
	public CategoryVO getCatNameByCatNo(String catno) throws SQLException {
		CategoryVO categoryVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			String sql = "select cat_name from category where cat_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, catno);
			rs = pstmt.executeQuery();
			
			if(rs.next())
				categoryVO = new CategoryVO(catno, rs.getString(1));
		} finally {
			closeAll(rs, pstmt, con);
		}
		return categoryVO;
	}
	
	/**
	 * 180831-소정
	 * @return
	 * @throws SQLException
	 */
	public ArrayList<CategoryVO> getAllCategories() throws SQLException {
		ArrayList<CategoryVO> list = new ArrayList<CategoryVO>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			String sql="select cat_no,cat_name from category";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				list.add(new CategoryVO(Integer.toString(rs.getInt(1)),rs.getString(2)));
			}
		}finally {
			closeAll(rs,pstmt,con);
		}
		
		return list;
	}

	public RentalDetailVO itemRentDetail(RentalDetailVO vo) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt =null;
		ResultSet rs = null;
		RentalDetailVO rvo = null;
		ItemVO ivo = null;
		MemberVO mvo = null;		
		try {
			con = getConnection();
			StringBuilder sql = new StringBuilder();
			sql.append("select m.id, ");
			sql.append("i.item_name, i.item_brand, i.item_model, i.item_price, i.item_no, ");
			sql.append("r.rental_no, to_char(r.rental_date,'yyyy-MM-DD'), to_char(r.return_date,'yyyy-MM-DD'),r.total_payment ");
			sql.append("from member m, item i, rental_details r ");
			sql.append("where m.id = i.id ");
			sql.append("and i.item_no = r.item_no ");
			sql.append("and rental_no=? ");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, vo.getRentalNo());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				rvo = new RentalDetailVO();
				ivo = new ItemVO();
				mvo = new MemberVO();
				mvo.setId(rs.getString(1));
				rvo.setMemberVO(mvo);
				ivo.setItemName(rs.getString(2));
				ivo.setItemBrand(rs.getString(3));
				ivo.setItemModel(rs.getString(4));
				ivo.setItemPrice(rs.getInt(5));
				ivo.setItemNo(rs.getString(6));	//180905 SOJEONG 추가
				ivo.setPicList(getPictureList(rs.getString(6)));
				System.out.println(ivo);
				rvo.setItemVO(ivo);
				rvo.setRentalNo(rs.getString(7));
				rvo.setRentalDate(rs.getString(8));
				rvo.setReturnDate(rs.getString(9));
				rvo.setTotalPayment(rs.getInt(10));
				
				
			}
		}finally {
			closeAll(rs, pstmt, con);
		}
		return rvo;
	}

	public int registerItem(MemberVO mvo,ItemVO ivo, String[] cats,String expl,int month) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt =null;
		ResultSet rs = null;
		int itemNo=0;
		try {
			con = getConnection();
			StringBuilder sql = new StringBuilder();
			sql.append("insert into item(item_no, id, item_name, item_brand, item_model, item_price, item_regdate, item_expdate, item_status, item_expl)"
										+ " values(item_no_seq.nextval,?,?,?,?,?,sysdate,add_months(sysdate,?),1,?)");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, mvo.getId());
			pstmt.setString(2, ivo.getItemName());
			pstmt.setString(3,ivo.getItemBrand());
			pstmt.setString(4, ivo.getItemModel());
			pstmt.setInt(5, ivo.getItemPrice());
			pstmt.setInt(6, month);// default 3개월
			pstmt.setString(7,expl);
			pstmt.executeUpdate();
			pstmt.close();
			
			sql = new StringBuilder();
			sql.append("select item_no_seq.currval from dual");
			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				itemNo = rs.getInt(1);
			}
			pstmt.close();
			
			sql = new StringBuilder();
			sql.append("insert into item_add(item_no) values(?)");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, itemNo);
			pstmt.executeUpdate();
			pstmt.close();
			
			for(int i=0;i<cats.length;i++) {
				sql = new StringBuilder();
				sql.append("insert into item_category(item_no,cat_no) values(?,?)");
				pstmt = con.prepareStatement(sql.toString());
				pstmt.setInt(1, itemNo);
				pstmt.setInt(2, Integer.parseInt(cats[i]));
				pstmt.executeUpdate();
				pstmt.close();
			}
			//picture 저장
			for(int i=0;i<ivo.getPicList().size();i++) {
				sql = new StringBuilder();
				sql.append("insert into picture(item_no,picture_path) values(?,?)");
				pstmt=con.prepareStatement(sql.toString());
				pstmt.setInt(1, itemNo);
				pstmt.setString(2, ivo.getPicList().get(i));
				pstmt.executeUpdate();
			}
			
		}finally {
			closeAll(rs,pstmt,con);
		}
		return itemNo;
	}
	
	/**
	 * 180831 yosep 진행중
	 * 로그인되어있는 자신의 id로 대여 내역을 조회해 리스트로 반환한다.
	 * Item 테이블과 Rental_details 테이블을 조인함. 
	 * @param id
	 * @return
	 * @throws SQLException 
	 */
	public ArrayList<RentalDetailVO> getAllRentalListById(String id, PagingBean pagingBean) throws SQLException {
		ArrayList<RentalDetailVO> list = new ArrayList<RentalDetailVO>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			String sql="select rental_no, item_no, item_name, id, rental_date, return_date, review_status, total_payment \r\n" + 
					"from( select row_number() over(order by r.rental_no desc) as rnum, r.rental_no, i.item_no, i.item_name, i.id,  to_char(r.rental_date,'yyyy-MM-DD') as rental_date, to_char(r.return_date,'yyyy-MM-DD') as return_date, r.review_status, r.total_payment \r\n" + 
					"from rental_details r, item i where r.item_no=i.item_no and r.id=?)  where rnum between ? and ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, pagingBean.getStartRowNumber());
			pstmt.setInt(3, pagingBean.getEndRowNumber());
			rs = pstmt.executeQuery();			
			while(rs.next()) {
				RentalDetailVO rentalDetailVo= new RentalDetailVO();
				rentalDetailVo.setRentalNo(rs.getString(1));
				ItemVO item= new ItemVO();			
				item.setItemNo(rs.getString(2));
				item.setPicList(getPictureList(rs.getString(2)));					
				item.setItemName(rs.getString(3));				
				item.getMemberVO().setId(rs.getString(4));	
				rentalDetailVo.setItemVO(item);
				rentalDetailVo.setRentalDate(rs.getString(5));
				rentalDetailVo.setReturnDate(rs.getString(6));	
				rentalDetailVo.setReview_status(rs.getInt(7));
				rentalDetailVo.setTotalPayment(rs.getInt(8));
				list.add(rentalDetailVo);			
			}
				
		}finally {
			closeAll(rs,pstmt,con);
		}		
		return list;

	}
	
	public int getAllRentalListCountById(String id) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int totalCount=0;
		try {
			con = getConnection();
			String sql="select count(*) " + 
					"from rental_details r, item i \r\n" + 
					"where r.item_no=i.item_no and r.id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();			
			if(rs.next()) {
				totalCount=rs.getInt(1);
			}				
		}finally {
			closeAll(rs,pstmt,con);
		}		
		return totalCount;
	}    
	

	public String deleteCheck(String itemNo) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String result = null;
		try {
			con=getConnection();
			String sql = "select sysdate,max(return_date) from rental_details where item_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, itemNo);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				Date today = rs.getDate(1);
				Date returnDate = rs.getDate(2);
				if(returnDate!=null && today.before(returnDate)) {
					result = returnDate.toString();
				}else {
					result="true";
				}
			}
		}finally {
			closeAll(pstmt, con);
		}
		return result;
}
	/**
	 * 180901 yosep 진행중
	 * 주어진 id로 등록 물품을 조회해 리스트로 반환한다.(대여 해준 것만)
	 * 
	 * @param id
	 * @return
	 * @throws SQLException 
	 */	 
	public ArrayList<RentalDetailVO> getAllRegisterListById(String id, PagingBean pagingBean) throws SQLException {
		ArrayList<RentalDetailVO> list = new ArrayList<RentalDetailVO>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			StringBuilder sql = new StringBuilder();
			sql.append("select rental_no, item_no, item_name, id, rental_date, return_date, review_status ");
			sql.append("from( select row_number() over(order by r.rental_no desc) as rnum, r.rental_no, r.id, ");
			sql.append("i.item_no, i.item_name, to_char(r.rental_date,'yyyy-MM-DD') as rental_date,  ");
			sql.append("to_char(r.return_date,'yyyy-MM-DD') as return_date, r.review_status ");
			sql.append("from rental_details r, item i, member m  ");
			sql.append("where m.id = i.id and r.item_no=i.item_no and m.id = ?) ");
			sql.append("where rnum between ? and ? ");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			pstmt.setInt(2, pagingBean.getStartRowNumber());
			pstmt.setInt(3, pagingBean.getEndRowNumber());
			rs = pstmt.executeQuery();			
			while(rs.next()) {
				RentalDetailVO rentalDetailVo= new RentalDetailVO();
				rentalDetailVo.setRentalNo(rs.getString(1));
				ItemVO item= new ItemVO();
				item.setPicList(getPictureList(rs.getString(2)));				
				item.setItemName(rs.getString(3));
				item.getMemberVO().setId(rs.getString(4));				
				rentalDetailVo.setItemVO(item);
				rentalDetailVo.setRentalDate(rs.getString(5));
				rentalDetailVo.setReturnDate(rs.getString(6));		
				rentalDetailVo.setReview_status(rs.getInt(7));
				list.add(rentalDetailVo);			
			}
		}finally {
			closeAll(rs,pstmt,con);
		}		
		return list;

	}
	/**
	 * 180905 정빈 진행중
	 * id에 해당하는 사용자가 대여하고있는 상품의 수를 반환(대여 해준 것만)
	 * 
	 * @param id
	 * @return
	 * @throws SQLException 
	 */	 
	public int getAllRegisterListCountById(String id) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int totalCount = 0;
		try {
			con = getConnection();
			StringBuilder sql = new StringBuilder();
			sql.append("select count(*) ");
			sql.append("from rental_details r, member m, item i ");
			sql.append("where m.id = i.id and i.item_no = r.item_no ");
			sql.append("and m.id = ? ");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();			
			if(rs.next()) {
				totalCount=rs.getInt(1);
			}
			
			System.out.println(totalCount);
			
		}finally {
			closeAll(rs,pstmt,con);
		}		
		return totalCount;

	}
	
	/**
	 * 180902 yosep 진행중
	 *  유저의 id를 받아 등록한 모든 물품을 조회해 리스트로 반환한다.(대여 안한 것도 전부)
	 * 
	 * @param id
	 * @return
	 * @throws SQLException 
	 */
	public ArrayList<ItemVO> getAllItemListById(String id) throws SQLException {
		ArrayList<String> picList = null;
		ArrayList<ItemVO> list = new ArrayList<ItemVO>();
		ItemVO itemVO = new ItemVO();
		MemberVO memberVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			String sql = "select item_no, item_name, item_expl, item_price, id from item where item_status=1 and id=? order by item_regdate desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			while(rs.next()) {
				memberVO = new MemberVO();
				memberVO.setId(rs.getString(5));
				itemVO = new ItemVO(rs.getString(1), rs.getString(2), rs.getString(3), rs.getInt(4),  memberVO);
				picList = getPictureList(rs.getString(1));
				if(picList != null) 
					itemVO.setPicList(picList);
				list.add(itemVO);
			}
		}finally {
			closeAll(rs, pstmt, con);
		}
		
		return list;
	}
	

	public int calDateBetweenAandB(String rentalDate, String returnDate) throws java.text.ParseException
	{
	 
	     // String Type을 Date Type으로 캐스팅하면서 생기는 예외로 인해 여기서 예외처리 해주지 않으면 컴파일러에서 에러가 발생해서 컴파일을 할 수 없다.
	        SimpleDateFormat format = new SimpleDateFormat("yyyymmdd");
	        // date1, date2 두 날짜를 parse()를 통해 Date형으로 변환.
	        Date FirstDate = format.parse(rentalDate);
	        System.out.println(returnDate);
	        Date SecondDate = format.parse(returnDate);
	        
	        // Date로 변환된 두 날짜를 계산한 뒤 그 리턴값으로 long type 변수를 초기화 하고 있다.
	        // 연산결과 -950400000. long type 으로 return 된다.
	        long calDate = FirstDate.getTime() - SecondDate.getTime(); 
	        
	        // Date.getTime() 은 해당날짜를 기준으로1970년 00:00:00 부터 몇 초가 흘렀는지를 반환해준다. 
	        // 이제 24*60*60*1000(각 시간값에 따른 차이점) 을 나눠주면 일수가 나온다.
	        long calDateDays = calDate / ( 24*60*60*1000); 
	 
	        calDateDays = Math.abs(calDateDays);
	        
	        System.out.println("두 날짜의 날짜 차이: "+calDateDays);
	        
	        return (int) calDateDays;
	}
	public void updateItem(ItemVO ivo,String dirPath) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
	
			String sql = "update item set item_name=?, item_brand=?,item_model=?,item_price=?,item_expdate=?,item_expl=? where item_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, ivo.getItemName());
			pstmt.setString(2, ivo.getItemBrand());
			pstmt.setString(3,ivo.getItemModel());
			pstmt.setInt(4, ivo.getItemPrice());
			pstmt.setString(5, ivo.getItemExpDate());
			pstmt.setString(6, ivo.getItemExpl());
			pstmt.setInt(7, Integer.parseInt(ivo.getItemNo()));
			pstmt.executeUpdate();
			pstmt.close();
			
			/*ArrayList<String> picList = getPictureList(ivo.getItemNo());
			for(String fileName:picList) {
				String path = dirPath+File.separator+fileName;
				File f = new File(path);
				f.delete();
			}*/
			
			sql = "delete from item_category where item_no = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(ivo.getItemNo()));
			pstmt.executeUpdate();
			pstmt.close();
			
			sql = "delete from picture where item_no = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(ivo.getItemNo()));
			pstmt.executeUpdate();
			pstmt.close();
			
			ArrayList<CategoryVO> cats=ivo.getCatList();
			for(int i=0;i<cats.size();i++) {
			
				sql="insert into item_category(item_no,cat_no) values(?,?)";
				pstmt = con.prepareStatement(sql.toString());
				pstmt.setInt(1, Integer.parseInt(ivo.getItemNo()));
				pstmt.setInt(2, Integer.parseInt(cats.get(i).getCatNo()));
				pstmt.executeUpdate();
				pstmt.close();
			}
			//picture 저장
			ArrayList<String>pics = ivo.getPicList();
			for(int i=0;i<pics.size();i++) {
				sql="insert into picture(item_no,picture_path) values(?,?)";
				pstmt=con.prepareStatement(sql.toString());
				pstmt.setInt(1, Integer.parseInt(ivo.getItemNo()));
				pstmt.setString(2, pics.get(i));
				pstmt.executeUpdate();
				pstmt.close();
			}

			
			
			
			
			
		}finally{
			closeAll(rs,pstmt,con);
		}
		
	}

	public ArrayList<String> getRentalUnavailableDateList(String itemNo) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<String> list = new ArrayList<String>();
		try {
			con = getConnection();
			String sql = "select to_char(rental_date,'yyyymmdd'),to_char(return_date,'yyyymmdd') from rental_details where item_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, itemNo);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int rentalDate = Integer.parseInt(rs.getString(1));
				int returnDate = Integer.parseInt(rs.getString(2));
				while(rentalDate<=returnDate) {
					list.add(Integer.toString(rentalDate++));	
				}
			}
		}finally {
			
		}
		return list;
}
	public void itemEarlyReturn(String rentalNo) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con=getConnection();
			String sql = "update rental_details set return_date=sysdate where rental_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, rentalNo);
			pstmt.executeUpdate();
		}finally {
			closeAll(pstmt, con);
		}

		

	}

	public RentalDetailVO rentalCancel(String rentalNo, String point) throws SQLException, ParseException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		RentalDetailVO rentalTime = null;
		String currentTime = null;
		Date rDate = null;
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREA);
		Date time = new Date();
		Date cDate = new Date();
		currentTime = dateFormat.format(time);
		MemberVO withdrawId = new MemberVO();
		MemberVO depositId = new MemberVO();
		try {
			con = getConnection();
			String sql = "select rental_date from RENTAL_DETAILS where rental_no = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, rentalNo);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				rentalTime = new RentalDetailVO();
				rentalTime.setRentalDate(rs.getString(1));
				rDate = dateFormat.parse(rentalTime.getRentalDate());
				cDate = dateFormat.parse(currentTime);
				int compare = cDate.compareTo(rDate);
				pstmt.close();
				if(compare<0) {
					StringBuilder sql2 = new StringBuilder();
					sql2.append("select i.id, r.id ");
					sql2.append("from item i, rental_details r, member m ");
					sql2.append("where m.id = r.id and i.item_no = r.item_no ");
					sql2.append("and rental_no = ? ");
					pstmt = con.prepareStatement(sql2.toString());
					pstmt.setString(1, rentalNo);
					rs2 = pstmt.executeQuery();
					if(rs2.next()) {
						depositId.setId(rs2.getString(1));
						withdrawId.setId(rs2.getString(2));
					}
					MemberDAO.getInstance().depositPoint(withdrawId.getId(), Integer.parseInt(point));//빌린자
					MemberDAO.getInstance().withdrawPoint(depositId.getId(), Integer.parseInt(point));//빌려준자
					pstmt.close();
					pstmt = con.prepareStatement("delete from rental_details where rental_no = ? ");
					pstmt.setString(1, rentalNo);
					pstmt.executeUpdate();
					return rentalTime;
				}
			}
		}finally {
			closeAll(rs,pstmt,con);
		}
		return null;
	}

	 


}
