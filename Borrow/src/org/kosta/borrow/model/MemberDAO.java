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

	public void closeAll(PreparedStatement pstmt,Connection con) throws SQLException {
		if(pstmt!=null)
			pstmt.close();
		if(con!=null)
			con.close();
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
	
	public MemberVO memberDetail(String id) throws SQLException {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		MemberVO vo=null;
		try {
			con=getConnection();
			String sql="select id,name,address,tel,point from member where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				vo=new MemberVO(rs.getString(1),null,rs.getString(2),rs.getString(3),rs.getString(4),rs.getInt(5));
			}
				
		}finally {
			closeAll(rs, pstmt, con);
		}
		
		return vo;
	}
	public void registerMember(MemberVO memberVO) throws SQLException {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			con=dataSource.getConnection();
			String sql="insert into member(id,pwd,name,address,tel) values(?,?,?,?,?) ";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, memberVO.getId());
			pstmt.setString(2, memberVO.getPwd());
			pstmt.setString(3, memberVO.getName());
			pstmt.setString(4, memberVO.getAddress());
			pstmt.setString(5, memberVO.getTel());
			pstmt.executeQuery();
		}finally {
			closeAll(rs, pstmt, con);
		}
	}
	public boolean idCheck(String id) throws SQLException {
		boolean flag=false;
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			con=dataSource.getConnection();
			String sql="select count(*) from member where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1,id);
			rs=pstmt.executeQuery();
			if(rs.next()&&(rs.getInt(1)>0))
			flag=true;			
		}finally {
			closeAll(rs, pstmt, con);
		}
		return flag;
	}
	public void updateMember(MemberVO memberVO) throws SQLException {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			con=dataSource.getConnection();
			String sql="update member set pwd=?,name=?,address=?,tel=? where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, memberVO.getPwd());
			pstmt.setString(2, memberVO.getName());
			pstmt.setString(3, memberVO.getAddress());
			pstmt.setString(4, memberVO.getTel());
			pstmt.setString(5, memberVO.getId());
			pstmt.executeQuery();
		}finally {
			closeAll(rs, pstmt, con);
		}		
	}
	/**
	 * 180903 성열 완료
	 * id에 해당하는 사용자에게 point를 입금
	 * @param id
	 * @param point
	 * @throws SQLException 
	 */
	public void depositPoint(String id, int point) throws SQLException {
		Connection con=null;
		PreparedStatement pstmt=null;
		try {
			con=getConnection();
			String sql="update member set point=point+? where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, point);
			pstmt.setString(2, id);
			pstmt.executeUpdate();
				
		}finally {
			closeAll(pstmt, con);
		}
		
	}

	/**
	 * 180903 yosep
	 * memberId에 해당하는 사용자의 point반환
	 * @param memberId
	 * @return
	 * @throws SQLException 
	 */
	public int getPointByMemberId(String memberId) throws SQLException {
		PreparedStatement pstmt=null;
		ResultSet rs= null;
		Connection con=null;
		int point=0;
		try {
			con=dataSource.getConnection();
			String sql="select point from 	member where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, memberId);	
			rs=pstmt.executeQuery();
			if(rs.next()) {
				point=rs.getInt(1);
			}
		}finally {
			closeAll(rs, pstmt, con);			
		}		
		return point;	
	}
	
	
	/**
	 * 180903 yosep 진행중
	 * senderId에 해당하는 사용자의 point를
	 * receiverId에 해당하는 사용자에게 송금
	 * @param receiverId
	 * @param senderId
	 * @param point
	 */
	public void transferPoint(String receiverId, String senderId, int point) {
		try {
			//구매자 출금
			withdrawPoint(senderId, point);		
			//판매자 입금
			depositPoint(receiverId, point);
		} catch (SQLException e) {
			e.printStackTrace();
		}		
	}		
	/**
	 *  180903 성열 진행중
	 * id에 해당하는 사용자에게 point를 출금
	 * @param id
	 * @param point
	 * @throws SQLException 
	 */
	public void withdrawPoint(String id, int point) throws SQLException {
		PreparedStatement pstmt=null;
		Connection con=null;		
		try {
			con=dataSource.getConnection();
			String sql="update member set point=point-? where id=?";

			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, point);
			pstmt.setString(2, id);			
			pstmt.executeUpdate();				
		}finally {
			closeAll(pstmt, con);			
		}		
	}
	public MemberVO findPwd(String id,String name, String tel) throws SQLException {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		MemberVO vo=null;
		try {
			con=dataSource.getConnection();
			String sql="select pwd from member where id=? and name=? and tel=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, name);
			pstmt.setString(3, tel);
			rs=pstmt.executeQuery();
			if(rs.next())
				vo=new MemberVO(id,rs.getString(1),name,tel,null,0);
		}finally {
			closeAll(rs, pstmt, con);
		}
		return vo;
	}
	
	
}

