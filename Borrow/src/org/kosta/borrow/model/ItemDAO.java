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
	 */
	public ArrayList<ItemVO> getAllItemListByName(String searchtext) {
		ArrayList<ItemVO> list= new ArrayList<ItemVO>();
		
		
		
		
		return list;
	}
	
	/**
	 * 180831 MIRI 완료
	 * @param itemno
	 * @return
	 * @throws SQLException 
	 */
	public ArrayList<ItemVO> getDetailItemByNo(String itemno) throws SQLException {
		ArrayList<ItemVO> list = new ArrayList<ItemVO>();
		MemberVO memberVO = null;
		CategoryVO categoryVO = null;
		StringBuilder sb = new StringBuilder();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			sb.append(" select i.id, i.item_name, i.item_brand, i.item_model, i.item_price,");
			sb.append(" to_char(i.item_regdate, 'yyyy-MM-dd') as item_regdate, to_char(i.item_expdate, 'yyyy-MM-dd') as item_expdate, ic.cat_no, c.cat_name");
			sb.append(" from item i, category c, item_category ic");
			sb.append(" where i.item_status=1 and i.item_no=? and i.item_no=ic.item_no and ic.cat_no=c.cat_no");
			pstmt = con.prepareStatement(sb.toString());
			pstmt.setString(1, itemno);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				memberVO = new MemberVO();
				memberVO.setId(rs.getString(1));
				categoryVO = new CategoryVO();
				categoryVO.setCatNo(rs.getString(8));
				categoryVO.setCatName(rs.getString(9));
				list.add(new ItemVO(itemno, rs.getString(2), rs.getString(3), rs.getString(4), rs.getInt(5), 
						rs.getString(6), rs.getString(7), "1", memberVO, categoryVO));
			}
		}finally {
			closeAll(rs, pstmt, con);
		}
		return list;
	}
	/**
	 * 180831 MIRI 완료
	 * Item table에 있는 모든 상품들을 찾아서 ArrayList로 반환한다
	 * @return
	 * @throws SQLException 
	 */
	public ArrayList<ItemVO> getAllItemList() throws SQLException {
		ArrayList<ItemVO> list = new ArrayList<ItemVO>();
		MemberVO memberVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			String sql="select item_no, item_name, item_price, id from item where item_status=1";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				memberVO = new MemberVO();
				memberVO.setId(rs.getString(4));
				list.add(new ItemVO(rs.getString(1), rs.getString(2), rs.getInt(3), memberVO));
			}
		}finally {
			closeAll(rs, pstmt, con);
		}
		return list;
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
}
