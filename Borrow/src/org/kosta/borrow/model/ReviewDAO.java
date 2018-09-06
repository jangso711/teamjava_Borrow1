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
						",r.review_hit,m.id,m.name,i.item_no,i.item_name,r.review_grade\r\n" + 
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
					rvo.setReviewGrade(rs.getInt(9));
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
						"to_char(r.review_regdate,'yyyy-MM-DD'),m.id,m.name,i.item_no,i.item_name,r.review_grade\r\n" + 
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
					rvo.setReviewGrade(rs.getInt(10));	// 180905 review_grade 저장 추가 SOJEONG 
					RentalDetailVO rv = new RentalDetailVO();
					rv.setItemVO(ivo);
					rvo.setRentalDetailVO(rv);
				}
			}finally{
				closeAll(rs,pstmt,con);
			}
			return rvo;
		}
		public int registerReview(ReviewVO review) throws SQLException {
			Connection con = null;
			PreparedStatement pstmt =null;
			ResultSet rs = null;
			int reviewNo = 0;
			double avg = 0;
			try {
				con = getConnection();
				String sql = "insert into review(review_no,review_title,review_content,review_grade,review_hit,review_regdate,item_no,id,rental_no) values(review_no_seq.nextval,?,?,?,0,sysdate,?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1,review.getReviewTitle());
				pstmt.setString(2, review.getReviewContent());
				pstmt.setInt(3, review.getReviewGrade());
				pstmt.setInt(4, Integer.parseInt(review.getRentalDetailVO().getItemVO().getItemNo()));
				pstmt.setString(5, review.getMemberVO().getId());
				pstmt.setInt(6, Integer.parseInt(review.getRentalDetailVO().getRentalNo()));
				pstmt.executeUpdate();
				pstmt.close();
				
				sql = "select review_no_seq.currval from dual";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					reviewNo = rs.getInt(1);
				}
				rs.close();
				pstmt.close();
				sql = "select avg(review_grade) from review where item_no=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(review.getRentalDetailVO().getItemVO().getItemNo()));
				rs = pstmt.executeQuery();
				if(rs.next()) {
					avg = rs.getDouble(1);
				}
				sql = "update item_add set grade=? where item_no=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setDouble(1, avg);
				pstmt.setInt(2, Integer.parseInt(review.getRentalDetailVO().getItemVO().getItemNo()));
				pstmt.executeUpdate();
				pstmt.close();
				
				sql="update rental_details set review_status=1 where rental_no=?"	;	
				String rentalNo = review.getRentalDetailVO().getRentalNo();
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, rentalNo);
				pstmt.executeUpdate();
				
			}finally {
				closeAll(rs,pstmt,con);
			}
			return reviewNo;
		}
		public void updateReview(String title, String contents,String reviewNo) throws SQLException {
			Connection con = null;
			PreparedStatement pstmt = null;
			try {
				con = getConnection();
				String sql = "update review set review_title=?,review_content=? where review_no=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, title);
				pstmt.setString(2, contents);
				pstmt.setInt(3, Integer.parseInt(reviewNo));
				pstmt.executeUpdate();
			}finally {
				closeAll(pstmt,con);
			}
			
		}
		public void deleteReview(String reviewNo,String itemNo) throws NumberFormatException, SQLException {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			double avg = 0;		
			try {					
				con=getConnection();
				String sql = "update rental_details set review_status=0 where rental_no=(select rental_no from review where review_no=?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(reviewNo));			
				pstmt.executeUpdate();
				pstmt.close();
				
				sql = "delete from review where review_no=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(reviewNo));
				pstmt.executeUpdate();
				pstmt.close();
				
				sql = "select avg(review_grade) from review where item_no=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(itemNo));
				rs = pstmt.executeQuery();
				if(rs.next()) {
					avg = rs.getDouble(1);
				}
				pstmt.close();
				
				sql = "update item_add set grade=? where item_no=?";	
				pstmt = con.prepareStatement(sql);
				pstmt.setDouble(1, avg);
				pstmt.setInt(2, Integer.parseInt(itemNo));
				pstmt.executeUpdate();
			}finally {
				closeAll(rs,pstmt,con);
			}
			
		}
		public ArrayList<ReviewVO> getPostingMyList(PagingBean pagingBean, String id) throws SQLException {
			ArrayList<ReviewVO> list=new ArrayList<ReviewVO>();
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			try{
				con=dataSource.getConnection(); 
				StringBuilder sql=new StringBuilder();
				sql.append("SELECT r.review_no,r.review_title,to_char(review_regdate,'YYYY.MM.DD') ");
				sql.append(",r.review_hit,m.name,i.item_no,i.item_name,r.review_grade ");
				sql.append("FROM(select row_number() over(ORDER BY review_no DESC) ");
				sql.append("as rnum,review_no,review_title,to_char(review_regdate,'YYYY.MM.DD') ");
				sql.append(",review_hit FROM review where id=?) rn, review r, member m, item i  ");
				sql.append("WHERE r.id=m.id and r.item_no=i.item_no and rn.review_no=r.review_no AND ");
				sql.append("rnum BETWEEN ? AND ? ORDER BY review_no DESC ");
				pstmt=con.prepareStatement(sql.toString());	
				pstmt.setString(1, id);
				pstmt.setInt(2, pagingBean.getStartRowNumber());
				pstmt.setInt(3, pagingBean.getEndRowNumber());
				rs=pstmt.executeQuery();	
				while(rs.next()){		
					ReviewVO rvo=new ReviewVO();
					rvo.setReviewNo(rs.getString(1));
					rvo.setReviewTitle(rs.getString(2));
					rvo.setReviewRegdate(rs.getString(3));
					rvo.setReviewHit(rs.getInt(4));
					rvo.setReviewGrade(rs.getInt(8));
					MemberVO mvo=new MemberVO();
					mvo.setName(rs.getString(5));
					rvo.setMemberVO(mvo);
					ItemVO ivo = new ItemVO();
					ivo.setItemNo(rs.getString(6));
					ivo.setItemName(rs.getString(7));
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

		public ArrayList<ReviewVO> getPostingMyItemNoList(PagingBean pagingBean, String itemNo) throws SQLException {
			ArrayList<ReviewVO> list=new ArrayList<ReviewVO>();
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			try{
				con=getConnection(); 
				StringBuilder sql=new StringBuilder();
				sql.append("SELECT r.review_no,r.review_title,to_char(review_regdate,'YYYY.MM.DD')\r\n" + 
						",r.review_hit,m.name,i.item_no,i.item_name,r.review_grade\r\n" + 
						"FROM(select row_number() over(ORDER BY review_no DESC)\r\n" + 
						"as rnum,review_no,review_title,to_char(review_regdate,'YYYY.MM.DD')\r\n" + 
						",review_hit FROM review) rn, review r, member m, item i\r\n" + 
						"WHERE r.id=m.id and r.item_no=i.item_no and rn.review_no=r.review_no and i.item_no=? AND\r\n" + 
						"rnum BETWEEN ? AND ? ORDER BY r.review_no DESC");
				pstmt=con.prepareStatement(sql.toString());	
				pstmt.setString(1, itemNo);
				pstmt.setInt(2, pagingBean.getStartRowNumber());
				pstmt.setInt(3, pagingBean.getEndRowNumber());
				rs=pstmt.executeQuery();	
				while(rs.next()){		
					ReviewVO rvo=new ReviewVO();
					rvo.setReviewNo(rs.getString(1));
					rvo.setReviewTitle(rs.getString(2));
					rvo.setReviewRegdate(rs.getString(3));
					rvo.setReviewHit(rs.getInt(4));
					rvo.setReviewGrade(rs.getInt(8));
					MemberVO mvo=new MemberVO();
					mvo.setName(rs.getString(5));
					rvo.setMemberVO(mvo);
					ItemVO ivo = new ItemVO();
					ivo.setItemNo(rs.getString(6));
					ivo.setItemName(rs.getString(7));
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
		public int getItemNoPostCount(String itemNo) throws SQLException {
			int totalCount=0;
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			try {
				con=getConnection();
				String sql="SELECT count(*)\r\n" + 
						"FROM(select row_number() over(ORDER BY review_no DESC)\r\n" + 
						"as rnum,review_no,review_title,to_char(review_regdate,'YYYY.MM.DD')\r\n" + 
						",review_hit FROM review) rn, review r, member m, item i\r\n" + 
						"WHERE r.id=m.id and r.item_no=i.item_no and rn.review_no=r.review_no and i.item_no=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, itemNo);
				rs=pstmt.executeQuery();
				if(rs.next()) {
					totalCount=rs.getInt(1);
				}
			}finally {
				closeAll(rs, pstmt, con);
			}
			return totalCount;
		}
		
		
		
		

		public String getReviewNoByRentalNo(String rentalNo) throws SQLException {
			
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			String reviewNo=null;
			try{
				con=dataSource.getConnection(); 
				StringBuilder sql=new StringBuilder();
				sql.append("select review_no from review where rental_no=?");				
				pstmt=con.prepareStatement(sql.toString());
				pstmt.setString(1, rentalNo);				
				rs=pstmt.executeQuery();	
				if(rs.next()){		
					reviewNo=rs.getString(1);										
				}			
			}finally{
				closeAll(rs,pstmt,con);
			}			
			return reviewNo;
		} 
	}
