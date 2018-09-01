package org.kosta.borrow.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;



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

	public void ItemDelete(ItemVO vo) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con=getConnection();
			String sql = "UPDATE item SET item_status = 0 WHERE item_no = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getItemNo());
			pstmt.executeUpdate();
		}finally {
			closeAll(pstmt, con);
		}
	}
	
	public void itemRental(RentalDetailVO vo) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con=getConnection();
			String sql = "INSERT INTO rental_details (rental_no, item_no, id, rental_date, return_date) VALUES (rental_no_seq.nextval, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getItemVO().getItemNo());
			pstmt.setString(2, vo.getMemberVO().getId());
			pstmt.setString(3, vo.getRentalDate());
			pstmt.setString(4, vo.getReturnDate());
			pstmt.executeUpdate();
			pstmt.close();
			String sql2 = "update item_add set rental_count = RENTAL_count +1 where item_no = ?";
			pstmt = con.prepareStatement(sql2);
			pstmt.setString(1, vo.getItemVO().getItemNo());
			pstmt.executeUpdate();
		}finally {
			closeAll(pstmt, con);
		}
	}

	
	
	/**
	 * 180831 MIRI 진행중
	 * Item table에서 이름 중에 검색어(searchtext)포함하는 
	 * 상품들을 전부 찾아서 ArrayList로 반환한다 
	 * @param searchtext
	 * @return
	 * @throws SQLException 
	 */
	public ArrayList<ItemVO> getAllItemListByName(String searchtext) throws SQLException {
		ArrayList<ItemVO> list = new ArrayList<ItemVO>();
		MemberVO memberVO = null;
		StringBuilder sb = new StringBuilder();
		searchtext = "%"+searchtext+"%";
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		/*try {
			con = getConnection();
			sb.append(" select i.id, i.item_no, i.item_name, i.item_expl, i.item_price, p.picture_path");
			sb.append(" from item i, picture p");
			sb.append(" where i.item_status=1 and i.item_no=p.item_no and i.item_name like ?");
			sb.append(" order by i.item_no asc");
			pstmt = con.prepareStatement(sb.toString());
			pstmt.setString(1, searchtext);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				memberVO = new MemberVO();
				memberVO.setId(rs.getString(1));
				list.add(new ItemVO(rs.getString(2), rs.getString(3), rs.getString(4), rs.getInt(5), 
						memberVO));
			}
		}finally {
			closeAll(rs, pstmt, con);
		}*/
		return list;
	}
	
	/**
	 * 180831 MIRI 진행중
	 * 180901 MIRI 완료
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
			sb.append(" select id, item_name, item_brand, item_model, item_price, to_char(item_regdate, 'yyyy-MM-dd') as item_regdate,");
			sb.append(" to_char(item_expdate, 'yyyy-MM-dd') as item_expdate, item_expl from item");
			sb.append(" where item_status=1 and item_no=? order by item_no asc");
			pstmt = con.prepareStatement(sb.toString());
			pstmt.setString(1, itemno);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				memberVO = new MemberVO();
				memberVO.setId(rs.getString(1));
				//180901 MIRI 해당 상품번호에 맞는 카테고리가 있으면 리스트를 전부 불러와 set 시킴
				catList = getCategoryList(itemno);
				if(catList != null) {
					//180901 MIRI 해당 상품번호에 맞는 사진이 있으면 리스트를 전부 불러와 set 시킴
					picList = getPictureList(itemno);
					itemVO = new ItemVO(itemno, rs.getString(2), rs.getString(3), rs.getString(4), rs.getInt(5), 
							rs.getString(6), rs.getString(7), "1", rs.getString(8), memberVO, picList, catList);
				}
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
	public ArrayList<ItemVO> getAllItemList() throws SQLException {
		ArrayList<String> picList = null;
		ArrayList<ItemVO> list = new ArrayList<ItemVO>();
		ItemVO itemVO = new ItemVO();
		MemberVO memberVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			String sql = "select item_no, item_name, item_expl, item_price, id from item where item_status=1 order by item_no asc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while(rs.next()) {
				memberVO = new MemberVO();
				memberVO.setId(rs.getString(5));
				itemVO = new ItemVO(rs.getString(1), rs.getString(2), rs.getString(3), rs.getInt(4),  memberVO);
				//180901 MIRI 해당 상품번호에 맞는 사진이 있으면 리스트를 전부 불러와 set 시킴
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
			
			while(rs.next()) {
				picList.add(rs.getString(1));
			}
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
			
			while(rs.next()) {
				catList.add(new CategoryVO(rs.getString(1), rs.getString(2)));
			}
		} finally {
			closeAll(rs, pstmt, con);
		}
		
		return catList;
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
	public int registerItem(MemberVO mvo,ItemVO ivo, String[] cats, PictureVO pvo,String expl) throws SQLException {
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
			pstmt.setInt(6, 3);// default 3개월
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
			sql = new StringBuilder();
			sql.append("insert into picture values(?,?)");
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setInt(1, itemNo);
			pstmt.setString(2, pvo.getPicturePath());
			pstmt.executeUpdate();
			
		}finally {
			closeAll(rs,pstmt,con);
		}
		return itemNo;
	}
	
	/**
	 * 180831 yosep 완료
	 * 로그인되어있는 자신의 id로 대여 내역을 조회해 리스트로 반환한다.
	 * Item 테이블과 Rental_details 테이블을 조인함. 
	 * @param id
	 * @return
	 * @throws SQLException 
	 */
	public ArrayList<RentalDetailVO> getAllRentalDetailById(String id) throws SQLException {
		ArrayList<RentalDetailVO> list = new ArrayList<RentalDetailVO>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			String sql="select r.rental_no, i.item_name, i.id, r.rental_date, r.return_date \r\n" + 
					"from rental_details r, item i \r\n" + 
					"where r.item_no=i.item_no and r.id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();			
			while(rs.next()) {
				RentalDetailVO rentalDetailVo= new RentalDetailVO();
				rentalDetailVo.setRentalNo(rs.getString(1));
				ItemVO item= new ItemVO();
				item.setItemName(rs.getString(2));
				item.getMemberVO().setId(rs.getString(3));
				rentalDetailVo.setItemVO(item);
				rentalDetailVo.setRentalDate(rs.getString(4));
				rentalDetailVo.setReturnDate(rs.getString(5));			
				list.add(rentalDetailVo);			
			}
				
		}finally {
			closeAll(rs,pstmt,con);
		}		
		return list;
	}
}
