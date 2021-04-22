package gagebu;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class GagebuDao {
	public Connection conn = null;
	public PreparedStatement pstmt = null;
	public ResultSet rs = null;
	
	String sql = "";
	
	GagebuVo vo = null;
	
	// 생성자를 통한 데이터베이스 연결
	public GagebuDao() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/works";
			String user = "green";
			String password = "1234";
			conn = DriverManager.getConnection(url, user, password);
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 검색 실패!!!");
		} catch (Exception e) {
			System.out.println("데이터베이스 연동실패!!");
		}
	}
	
	// 데이터베이스 Close(Connection객체 Close)
	public void dbClose() {
		if(conn != null)
			try {
				conn.close();
			} catch (Exception e) {}
	}
	
	// PreparedStatement객체 Close
	public void pstmtClose() {
		if(pstmt != null)
			try {
				pstmt.close();
			} catch (Exception e) {}
	}
	
	// ResultSet객체 Close
	public void rsClose() {
		if(rs != null)
			try {
				rs.close();
				if(pstmt != null) pstmt.close();
			} catch (Exception e) {}
	}

	// 가계부 입력처리
	public void gInput(GagebuVo vo) {
		int balance;
		try {
			// 기존의 잔고를 읽어온다.
			sql = "select balance from gagyebu order by idx desc limit 1";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) balance = rs.getInt("balance");
			else balance = 0;
			if(pstmt != null) pstmt.close();
			
			// '수입/지출'인지를 판별하여 잔액을 계산한다.
			if(vo.getgCode().equals("+")) balance += vo.getPrice();
			else balance -= vo.getPrice();
			
			// 입력된 자료를 가계부테이블에 등록한다.
			sql = "insert into gagyebu values (default,default,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getgCode());
			pstmt.setInt(2, vo.getPrice());
			pstmt.setString(3, vo.getContent());
			pstmt.setInt(4, balance);
			pstmt.executeUpdate();
			System.out.println("자료가 입력되었습니다.");
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		
	}

	/*
	public ArrayList<GagebuVo> gList() {
		ArrayList<GagebuVo> vos = new ArrayList<GagebuVo>();
		
		try {
			sql = "select * from gagyebu order by idx desc";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new GagebuVo();
				
				vo.setIdx(rs.getInt("idx"));
				vo.setwDate(rs.getString("wDate"));
				vo.setgCode(rs.getString("gCode"));
				vo.setPrice(rs.getInt("price"));
				vo.setContent(rs.getString("content"));
				vo.setBalance(rs.getInt("balance"));
				
				vos.add(vo);
			}
		} catch (Exception e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		
		return vos;
	}
	*/

	public ArrayList<GagebuVo> gSearch(String wDate) {
		ArrayList<GagebuVo> vos = new ArrayList<GagebuVo>();
		
		try {
			if(wDate.equals("list")) {		//전체조회
				sql = "select * from gagyebu order by idx desc";
				pstmt = conn.prepareStatement(sql);
			}
			else {		// 날짜별 조회
				sql = "select * from gagyebu where replace(substr(wDate,1,10),'-','')=? order by idx desc"; // sql의 substr(변수,시작위치,꺼낼갯수)
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, wDate);
			}
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new GagebuVo();
				
				vo.setIdx(rs.getInt("idx"));
				vo.setwDate(rs.getString("wDate"));
				vo.setgCode(rs.getString("gCode"));
				vo.setPrice(rs.getInt("price"));
				vo.setContent(rs.getString("content"));
				vo.setBalance(rs.getInt("balance"));
				
				vos.add(vo);
			}
		} catch (Exception e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		
		return vos;
	}
	
	// DB에서 실제 레코드 삭제처리
	public void gDelete(int idx) {
		System.out.println(" vo : " + idx);
		try {
			String gCode = "";
			int price = 0;
			// 고유번호(idx)에 해당하는 gCode와 price를 구해온다.
			sql = "select gCodem price from gagyebu where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				gCode = rs.getString("gCode");
				price = rs.getInt("price");
			}
			if(pstmt != null) pstmt.close();
			
			// 기존의 잔고를 읽어온다.
			int balance = 0;
			sql = "select idx, balance from gagyebu order by idx desc limit 1";	// 가장높은 값의 잔고와 idx를 읽음
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				balance = rs.getInt("balance");
			}
			if(pstmt != null) pstmt.close();
			
			sql = "select idx from gagyebu order by idx desc limit 1";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			int imsiIdx = 0;
			if(rs.next()) {
				imsiIdx = rs.getInt("idx");
			}
			if(pstmt != null) pstmt.close();
			
			
			
			
			if(gCode.equals("+")) balance -= price;		// 수익이면 - / 지출이면 + 로 본래의 값으로 돌려놓는ㄷ.
			else balance += price;	
			
			sql = "delete from gagqyebu where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			pstmtClose();
			
			// 제일 마지막 레코드를 수정후로 업데이트!
			sql = "update gagyebu set balance = ? where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, balance);
			pstmt.setInt(2, idx);
			pstmt.executeUpdate();
			pstmtClose();
			
			System.out.println("자료가 삭제처리 되었습니다.");
		} catch (Exception e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
		
	}
	
}
