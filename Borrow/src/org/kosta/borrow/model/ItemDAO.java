package org.kosta.borrow.model;

import java.sql.Connection;
import java.util.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.sql.DataSource;

import org.kosta.borrow.exception.BalanceShortageException;

import com.sun.org.apache.xerces.internal.impl.xpath.regex.ParseException;



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
			String sql = "update item set item_status=0,item_expdate=to_char(sysdate,'YYYY-MM-DD') where item_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(vo.getItemNo()));
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
			
			
			con=getConnection();
			pstmt = con.prepareStatement("select item_regdate, item_expdate from item");
			String sql = "INSERT INTO rental_details (rental_no, item_no, id, rental_date, return_date) VALUES (rental_no_seq.nextval, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getItemVO().getItemNo());
			pstmt.setString(2, vo.getMemberVO().getId());
			pstmt.setString(3, vo.getRentalDate());
			pstmt.setString(4, vo.getReturnDate());
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
	 * 180831 MIRI 진행중
	 * 180903 MIRI 완료
	 * Item table에서 이름 중에 검색어(searchtext)포함하는 상품들을 전부 찾아서 ArrayList로 반환한다 
	 * @param searchtext
	 * @return
	 * @throws SQLException 
	 */
 	public ArrayList<ItemVO> getAllItemListByName(String searchtext) throws SQLException {
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
			sb.append(" select id, item_no, item_name, item_expl, item_price");
			sb.append(" from item");
			sb.append(" where item_status=1 and item_name like ?");
			sb.append(" order by item_no asc");
			pstmt = con.prepareStatement(sb.toString());
			pstmt.setString(1, searchtext);
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
			//180902 yosep 기존 jsp 주석처리하고 여기서 진행
			if(picList.isEmpty())  //사진이 없으면
				picList.add("디폴트.png");
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
			sql.append("select m.name, ");
			sql.append("i.item_name, i.item_brand, i.item_model, i.item_price, i.item_no, ");
			sql.append("r.rental_no, r.rental_date, r.return_date ");
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
				mvo.setName(rs.getString(1));
				rvo.setMemberVO(mvo);
				ivo.setItemName(rs.getString(2));
				ivo.setItemBrand(rs.getString(3));
				ivo.setItemModel(rs.getString(4));
				ivo.setItemPrice(rs.getInt(5));
				ivo.setPicList(getPictureList(rs.getString(6)));
				System.out.println(ivo);
				rvo.setItemVO(ivo);
				rvo.setRentalNo(rs.getString(7));
				rvo.setRentalDate(rs.getString(8));
				rvo.setReturnDate(rs.getString(9));
				
				
			}
		}finally {
			closeAll(rs, pstmt, con);
		}
		return rvo;
	}

	public int registerItem(MemberVO mvo,ItemVO ivo, String[] cats,String expl) throws SQLException {
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
	public ArrayList<RentalDetailVO> getAllRentalDetailById(String id) throws SQLException {
		ArrayList<RentalDetailVO> list = new ArrayList<RentalDetailVO>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			String sql="select r.rental_no, i.item_no, i.item_name, i.item_price, i.id,  to_char(r.rental_date,'yyyy-MM-DD'), to_char(r.return_date,'yyyy-MM-DD') \r\n" + 
					"from rental_details r, item i \r\n" + 
					"where r.item_no=i.item_no and r.id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();			
			while(rs.next()) {
				RentalDetailVO rentalDetailVo= new RentalDetailVO();
				rentalDetailVo.setRentalNo(rs.getString(1));
				ItemVO item= new ItemVO();			
				item.setPicList(getPictureList(rs.getString(2)));					
				item.setItemName(rs.getString(3));
				item.setItemPrice(rs.getInt(4));
				item.getMemberVO().setId(rs.getString(5));				
				rentalDetailVo.setItemVO(item);
				rentalDetailVo.setRentalDate(rs.getString(6));
				rentalDetailVo.setReturnDate(rs.getString(7));			
				list.add(rentalDetailVo);			
			}
				
		}finally {
			closeAll(rs,pstmt,con);
		}		
		return list;

	}

	public boolean deleteCheck(String itemNo) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean result = false;
		try {
			con=getConnection();
			String sql = "select sysdate,max(return_date) from rental_details where item_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, itemNo);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				Date today = rs.getDate(1);
				Date returnDate = rs.getDate(2);
				if(today.before(returnDate)) {
					result = false;
				}else result = true;
			}
		}finally {
			closeAll(pstmt, con);
		}
		return result;
}
	/**
	 * 180901 yosep 진행중
	 * 로그인되어있는 자신의 id로 등록 물품을 조회해 리스트로 반환한다.(대여 해준 것만)
	 * 
	 * @param id
	 * @return
	 * @throws SQLException 
	 */	 
	public ArrayList<RentalDetailVO> getAllRegisterListById(String id) throws SQLException {
		ArrayList<RentalDetailVO> list = new ArrayList<RentalDetailVO>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			String sql=" select r.rental_no, r.item_no, i.item_name, r.id, i.item_price, to_char(r.rental_date,'yyyy-MM-DD'), to_char(r.return_date, 'yyyy-MM-DD')" + 
					"from Rental_details r,(select i.item_no from item i where i.id=?) a, item i " + 
					"where r.item_no=a.item_no and r.item_no=i.item_no";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();			
			while(rs.next()) {
				RentalDetailVO rentalDetailVo= new RentalDetailVO();
				rentalDetailVo.setRentalNo(rs.getString(1));
				ItemVO item= new ItemVO();
				item.setPicList(getPictureList(rs.getString(2)));				
				item.setItemName(rs.getString(3));
				item.getMemberVO().setId(rs.getString(4));
				item.setItemPrice(rs.getInt(5));
				rentalDetailVo.setItemVO(item);
				rentalDetailVo.setRentalDate(rs.getString(6));
				rentalDetailVo.setReturnDate(rs.getString(7));						
				list.add(rentalDetailVo);			
			}
				
		}finally {
			closeAll(rs,pstmt,con);
		}		
		return list;

	}
	
	/**
	 * 180902 yosep 진행중
	 * 로그인되어있는 자신의 id로 등록 물품을 조회해 리스트로 반환한다.(대여 안한 것도 전부)
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
			String sql = "select item_no, item_name, item_expl, item_price, id from item where item_status=1 and id=? order by item_no asc";
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
	        SimpleDateFormat format = new SimpleDateFormat("yyyy-mm-dd");
	        // date1, date2 두 날짜를 parse()를 통해 Date형으로 변환.
	        Date FirstDate = format.parse(rentalDate);
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
	        




}
