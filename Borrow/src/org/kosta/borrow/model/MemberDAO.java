package org.kosta.borrow.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

public class MemberDAO {
	private static MemberDAO instance = new MemberDAO();
	private DataSource dataSource;
	private MemberDAO() {
		this.dataSource= DataSourceManager.getInstance().getDataSource();
	}
	public static MemberDAO getInstance() {
		return instance;
	}
	public Connection getConnection() throws SQLException {
		return dataSource.getConnection();
	}
	private void closeAll(ResultSet rs, PreparedStatement pstmt, Connection con) throws SQLException {
		if(rs!=null)rs.close();
		if(pstmt!=null)pstmt.close();
		if(con!=null)con.close();
	}
	public MemberVO login(String id, String pwd) throws SQLException {
		MemberVO user = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			String sql = "select name from member where id=? and pwd=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				user = new MemberVO();
				user.setId(id);
				user.setPwd(pwd);
				user.setName(rs.getString(1));
			}
		}finally {
			closeAll(rs,pstmt,con);
		}
		return user;
	}
}
