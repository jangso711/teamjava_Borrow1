package org.kosta.borrow.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

	public class ReviewDAO {
		private static ReviewDAO dao=new ReviewDAO();	
		private DataSource dataSource;
		private ReviewDAO(){
			dataSource=DataSourceManager.getInstance().getDataSource();
		}
		public static ReviewDAO getInstance(){
			return dao;
		}
		public Connection getConnection() throws SQLException{
			return dataSource.getConnection();
		}
		public void closeAll(PreparedStatement pstmt,Connection con) throws SQLException{
			if(pstmt!=null)
				pstmt.close();
			if(con!=null)
				con.close(); 
		}
		public void closeAll(ResultSet rs,PreparedStatement pstmt,Connection con) throws SQLException{
			if(rs!=null)
				rs.close();
			closeAll(pstmt,con);
		}	
		
		public ArrayList<ReviewVO> getPostingList(PagingBean pagingBean) throws SQLException{
			ArrayList<ReviewVO> list=new ArrayList<ReviewVO>();
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			try{
				con=getConnection(); 
				StringBuilder sql=new StringBuilder();
				sql.append("SELECT r.review_no,r.review_title,to_char(review_regdate,'YYYY.MM.DD')\r\n" + 
						",r.review_hit,m.id,m.name,i.item_no,i.item_name\r\n" + 
						"FROM(select row_number() over(ORDER BY review_no DESC)\r\n" + 
						"as rnum,review_no,review_title,to_char(review_regdate,'YYYY.MM.DD')\r\n" + 
						",review_hit FROM review) rn, review r, member m, item i\r\n" + 
						"WHERE r.id=m.id and r.item_no=i.item_no and rn.review_no=r.review_no AND\r\n" + 
						"rnum BETWEEN ? AND ? ORDER BY review_no DESC");
				pstmt=con.prepareStatement(sql.toString());	
				pstmt.setInt(1, pagingBean.getStartRowNumber());
				pstmt.setInt(2, pagingBean.getEndRowNumber());
				rs=pstmt.executeQuery();	
				while(rs.next()){		
					ReviewVO rvo=new ReviewVO();
					rvo.setReviewNo(rs.getString(1));
					rvo.setReviewTitle(rs.getString(2));
					rvo.setReviewRegdate(rs.getString(3));
					rvo.setReviewHit(rs.getInt(4));
					MemberVO mvo=new MemberVO();
					mvo.setId(rs.getString(5));
					mvo.setName(rs.getString(6));
					rvo.setMemberVO(mvo);
					ItemVO ivo = new ItemVO();
					ivo.setItemNo(rs.getString(7));
					ivo.setItemName(rs.getString(8));
					RentalDetailVO rv = new RentalDetailVO();
					rv.setItemVO(ivo);
					rvo.setRentalDetailVO(rv);
					list.add(rvo);
				}			
			}finally{
				closeAll(rs,pstmt,con);
			}
			return list;
		} 
		 
		public int getTotalPostCount() throws SQLException {
			int totalCount=0;
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			try {
				con=getConnection();
				String sql="select count(*) from review";
				pstmt=con.prepareStatement(sql);
				rs=pstmt.executeQuery();
				if(rs.next()) {
					totalCount=rs.getInt(1);
				}
			}finally {
				closeAll(rs, pstmt, con);
			}
			return totalCount;
		}
		public void updateHit(int no) throws SQLException {
			Connection con=null;
			PreparedStatement pstmt=null;
			try{
				con=getConnection(); 
				String sql="update review set review_hit=review_hit+1 where review_no=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, no);	
				pstmt.executeUpdate();			
			}finally{
				closeAll(pstmt,con);
			}
		}
		public ReviewVO getPostingByNo(int no) throws SQLException {
			ReviewVO rvo=null;
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			try{
				con=getConnection();
				StringBuilder sql=new StringBuilder();
				sql.append("select r.review_no,r.review_title,r.review_content,r.review_hit,\r\n" + 
						"to_char(r.review_regdate,'yyyy-MM-DD'),m.id,m.name,i.item_no,i.item_name\r\n" + 
						"from review r, member m, item i\r\n" + 
						"where r.id=m.id and r.item_no=i.item_no and r.review_no=?");		
				pstmt=con.prepareStatement(sql.toString());
				pstmt.setInt(1, no);
				rs=pstmt.executeQuery();
				if(rs.next()){
					rvo=new ReviewVO();
					rvo.setReviewNo(rs.getString(1));
					rvo.setReviewTitle(rs.getString(2));
					rvo.setReviewContent(rs.getString(3));				
					rvo.setReviewHit(rs.getInt(4));
					rvo.setReviewRegdate(rs.getString(5));
					MemberVO mvo=new MemberVO();
					mvo.setId(rs.getString(6));
					mvo.setName(rs.getString(7));
					rvo.setMemberVO(mvo);
					//ItemVO ivo=new RentalDetailVO().getItemVO();
					ItemVO ivo = new ItemVO();
					ivo.setItemNo(rs.getString(8));
					ivo.setItemName(rs.getString(9));
					RentalDetailVO rv = new RentalDetailVO();
					rv.setItemVO(ivo);
					rvo.setRentalDetailVO(rv);
				}
			}finally{
				closeAll(rs,pstmt,con);
			}
			return rvo;
		}
	}
