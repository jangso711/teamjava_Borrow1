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
