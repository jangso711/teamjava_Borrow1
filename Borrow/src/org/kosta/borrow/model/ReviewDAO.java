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
		
		public ArrayList<ReviewVO> getPostingList() throws SQLException{
			ArrayList<ReviewVO> list=new ArrayList<ReviewVO>();
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			try{
				con=getConnection(); 
				StringBuilder sql=new StringBuilder();
				sql.append("SELECT r.review_no,r.review_title,to_char(review_regdate,'YYYY.MM.DD ') as review_regdate,r.review_hit,m.id,m.name ");
				sql.append("FROM review r , member m ");
				sql.append("WHERE r.id=m.id ");		
				sql.append("order by review_no desc");
				pstmt=con.prepareStatement(sql.toString());		
				rs=pstmt.executeQuery();	
				//목록에서 게시물 content는 필요없으므로 null로 setting
				//select no,title,time_posted,hits,id,name
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
					list.add(rvo);
				}			
			}finally{
				closeAll(rs,pstmt,con);
			}
			return list;
		} 
		 /**
	     * Sequence 글번호로 게시물을 검색하는 메서드 
	     * @param no
	     * @return
	     * @throws SQLException
	     */
		/*public ReviewVO getPostingByNo(int no) throws SQLException{
			ReviewVO rvo=null;
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			try{
				con=getConnection();
				StringBuilder sql=new StringBuilder();
				sql.append("select b.title,to_char(b.time_posted,'YYYY.MM.DD  HH24:MI:SS') as time_posted");
				sql.append(",b.content,b.hits,b.id,m.name");
				sql.append(" from board_inst b,board_member m");
				sql.append(" where b.id=m.id and b.no=?");		
				pstmt=con.prepareStatement(sql.toString());
				pstmt.setInt(1, no);
				rs=pstmt.executeQuery();
			
				if(rs.next()){
					rvo=new ReviewVO();
					rvo.setNo(no);
					rvo.setTitle(rs.getString("title"));
					rvo.setContent(rs.getString("content"));				
					rvo.setHits(rs.getInt("hits"));
					rvo.setTimePosted(rs.getString("time_posted"));
					MemberVO mvo=new MemberVO();
					mvo.setId(rs.getString("id"));
					mvo.setName(rs.getString("name"));
					rvo.setMemberVO(mvo);
				}
				//System.out.println("dao getContent:"+pvo);
			}finally{
				closeAll(rs,pstmt,con);
			}
			return pvo;
		}
		
		*//**
		 * 조회수 증가 
		 * @param no
		 * @throws SQLException
		 *//*
		public void updateHit(int no) throws SQLException{
			Connection con=null;
			PreparedStatement pstmt=null;
			try{
				con=getConnection(); 
				String sql="update board_inst set hits=hits+1 where no=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, no);	
				pstmt.executeUpdate();			
			}finally{
				closeAll(pstmt,con);
			}
		}
		*//**
		 * 게시물 등록 메서드  
		 * 게시물 등록 후 생성된 시퀀스를 BoardVO에 setting 한다. 
		 * @param vo
		 * @throws SQLException
		 *//*
		public void posting(ReviewVO vo) throws SQLException{
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			try{
				con=getConnection();
				//insert into board_inst(no,title,content,id,time_posted) values(board_inst_seq.nextval,?,?,?,sysdate)
				StringBuilder sql=new StringBuilder();
				sql.append("insert into board_inst(no,title,content,id,time_posted)");
				sql.append(" values(board_inst_seq.nextval,?,?,?,sysdate)");			
				pstmt=con.prepareStatement(sql.toString());
				pstmt.setString(1, vo.getTitle());
				pstmt.setString(2, vo.getContent());
				pstmt.setString(3, vo.getMemberVO().getId());
				pstmt.executeUpdate();			
				pstmt.close();
				pstmt=con.prepareStatement("select board_inst_seq.currval from dual");
				rs=pstmt.executeQuery();
				if(rs.next())
				vo.setNo(rs.getInt(1));			
			}finally{
				closeAll(rs,pstmt,con);
			}
		}	

		*//**
		 * 글번호에 해당하는 게시물을 삭제하는 메서드
		 * @param no
		 * @throws SQLException
		 *//*
		public void deletePosting(int no) throws SQLException{
			Connection con=null;
			PreparedStatement pstmt=null;
			try{
				con=getConnection(); 
				pstmt=con.prepareStatement("delete from board_inst where no=?");
				pstmt.setInt(1, no);		
				pstmt.executeUpdate();			
			}finally{
				closeAll(pstmt,con);
			}
		}
		*//**
		 * 게시물 정보 업데이트하는 메서드 
		 * @param vo
		 * @throws SQLException
		 *//*
		public void updatePosting(ReviewVO vo) throws SQLException{
			Connection con=null;
			PreparedStatement pstmt=null;
			try{
				con=getConnection();
				pstmt=con.prepareStatement("update board_inst set title=?,content=? where no=?");
				pstmt.setString(1, vo.getTitle());
				pstmt.setString(2, vo.getContent());
				pstmt.setInt(3, vo.getNo());	
				pstmt.executeUpdate();			
			}finally{
				closeAll(pstmt,con);
			}
		}*/
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
	}
