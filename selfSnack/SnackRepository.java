package dao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import dto.Snack;

public class SnackRepository {

	public SnackRepository() {
		// TODO Auto-generated constructor stub
	}
	private final String url = "jdbc:mysql://localhost:3306/mini_project?"
			+ "serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true";
	private final String user = "mini";
	private final String password = "1234";
	
	public Connection getConnection() throws Exception{
		Class.forName("com.mysql.cj.jdbc.Driver");
		return DriverManager.getConnection(url, user, password);
	}
	
	// best 상품 출력 메서드
	public ArrayList<Snack> getBestProducts(){
		ArrayList<Snack> bestList = new ArrayList<>();
		String sql="select * from snacks limit 3";//DB에서 Snacks 컬럼에서 조회하되 상위 3개만 가져와서 sql에 저장
		try (
			Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery()){
			while(rs.next()) {
				Snack s = new Snack();
				s.setSerial(rs.getString("serial"));
				s.setProductName(rs.getString("product_name"));
				s.setPrice(rs.getInt("price"));
				s.setImage(rs.getString("image"));
				bestList.add(s);
			}
			}catch(Exception e) {
				e.printStackTrace();}
		return bestList;
			}
	
	// 전체상품 조회	
	public ArrayList<Snack> getAllProducts(){
		ArrayList<Snack> bestList= new ArrayList<>();
		String sql= "select * from snacks";
		try(
				Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()
			){
			while(rs.next()) {
				Snack s = new Snack();
				s.setSerial(rs.getString("serial"));
				s.setProductName(rs.getNString("product_name"));
				s.setPrice(rs.getInt("price"));
				s.setImage(rs.getString("image"));
				bestList.add(s);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return bestList;	
	}
	
	
	//품명상세조회메서드
	public Snack getProductBySerial(String serial) {
		
		Snack s= null;
		String sql= "select * from snacks where serial=?";
		
		try(
				Connection conn = getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql)
			){
				pstmt.setString(1,serial);
				try(ResultSet rs = pstmt.executeQuery()){
					
					if(rs.next()) {
						s = new Snack();
						s.setSerial(rs.getString("serial"));
						s.setProductName(rs.getString("product_name"));
						s.setPrice(rs.getInt("price"));
						s.setCompany(rs.getString("company"));
						s.setIngredient(rs.getString("ingredient"));
						s.setImage(rs.getString("image"));
						s.setFood_type(rs.getString("food_type"));
					}
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
		return s;		
	}
	
	//장바구니에 저장 구현 메서드 저장버튼 누를때마다 수량 ++;  //사용자가 새로고른 제품 수량
	public int addCart(String serial, int quantityValue) {
		//cart table에 이미 들어있던 기존 수량을 담아두기 위한 변수 (DB 조회하기 전이므로 기본값 0으로 설정)
		int currentQuantity = 0;
		
		String checkSql = "SELECT cart_id, quantity FROM cart WHERE serial = ?";
		// 데이터 베이스에 이상품이 이미 담겨있는지 확인
		String uptateSql = "UPDATE cart SET quantity = quantity + ? WHERE serial = ?"; //장바구니수량이 있으면 증가처리하도록
		// 이미 상품이 들어있다면 기존수량 quantity에 1을 더하고 업데이트
		String insertSql ="INSERT INTO cart (serial, quantity) VALUES (?,?)";
		// 장바구니에 상품이 없다면 새로 행 추가하고 수량을 채워넣는 쿼리
			try( Connection conn = getConnection()){
				//1. 이미담겨있는 상품인지 조회
				boolean isExist = false;
				try (PreparedStatement pstmt= conn.prepareStatement(checkSql)){
					pstmt.setString(1,serial);
					
					try(ResultSet rs=pstmt.executeQuery()){
						if (rs.next()) {
							isExist = true;
							currentQuantity = rs.getInt("quantity");	}
					}				
					}
				//2.있으면 수량 +1 업데이트,
					if(isExist) {
						try(PreparedStatement pstmt= conn.prepareStatement(uptateSql)){
							pstmt.setInt(1,quantityValue);
							pstmt.setString(2, serial);
							pstmt.executeUpdate();
									}
						currentQuantity +=quantityValue;  //화면에 보여줄 최종 수량 계산
					}else {//수량이 없다면 장바구니에 추가
						try(PreparedStatement pstmt= conn.prepareStatement(insertSql)){
							pstmt.setString(1,serial);
							pstmt.setInt(2,quantityValue);
							pstmt.executeUpdate();
						}
						currentQuantity =quantityValue; //처음 담으면 1개 
						}
			}catch(Exception e) {
					e.printStackTrace();
				}
			return currentQuantity;		//최종수량 리턴
			
	}
	//장바구니 목록 과 상품을 조인해서 가져오는 메서드 
	public ArrayList<Snack> getCartList(){
		ArrayList<Snack> cartList = new ArrayList<Snack>();
		String sql= "SELECT s.serial, s.product_name, s.price, s.image, c.quantity " +
		"FROM cart c JOIN snacks s ON c.serial = s.serial";
		try(
				Connection conn= getConnection();
				PreparedStatement pstmt= conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()
				){
			while(rs.next()) {
				Snack s = new Snack();
				s.setSerial(rs.getString("serial"));
				s.setProductName(rs.getString("product_name"));
				s.setPrice(rs.getInt("price"));
				s.setImage(rs.getString("image"));
				s.setQuantity(rs.getInt("quantity"));
				
				cartList.add(s);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
			return cartList;	
		
		}
	
	// 장바구니에 담겨있는 상품 최공 구매하는 메서드
	public boolean produectPay() {
		boolean success = false;
		String checkSql="SELECT c.serial, c.quantity, s.stock, s.product_name " +
						"FROM cart c JOIN snacks s ON c.serial = s.serial";
		String updateStockSql= "UPDATE snacks SET stock = stock -? WHERE serial = ?";
		String clearCartSql= "DELETE FROM cart"; // 구매완료후 장바구니 비우기
		
		Connection conn=null;
		
		try {
			conn=getConnection();
			conn.setAutoCommit(false); //트랜잭션 시작 (안전한 처리 위해)
			
			// 현재 장바구니 상품들의 재고상태 확인
			try(PreparedStatement pstmt= conn.prepareStatement(checkSql);
					ResultSet rs= pstmt.executeQuery()){
				
				// 임시리스트에 담아주기 (재고부족 검증)
				while(rs.next()) {
					String serial = rs.getString("serial");
					int cartQty= rs.getInt("quantity");
					int stock= rs.getInt("stock");
					String productName= rs.getString("product_name");
					
					//장바구니 수량이 재고보다 많다면 구매 실패 처리
					if(cartQty> stock) {
						conn.rollback();
						return false;	//재고부족발생
					}
				}
			}
		//재고가 모두 충분하다면 재고 차감 발생
			try(PreparedStatement pstmtCheck = conn.prepareStatement(checkSql);
				ResultSet rs = pstmtCheck.executeQuery();
				PreparedStatement pstmtUpdate = conn.prepareStatement(updateStockSql)){
				
				while(rs.next()) {
					String serial = rs.getString("serial");
					int cartQty= rs.getInt("quantity");
					
					pstmtUpdate.setInt(1, cartQty);
					pstmtUpdate.setString(2, serial);
					pstmtUpdate.executeUpdate();
				}
			}
		// 선택 구매가 완료 되면 장바구니 비우기
			try(PreparedStatement pstmtClear = conn.prepareStatement(clearCartSql)){
				pstmtClear.executeUpdate();
			}
			
			conn.commit();//모든 과정이 성공하면 최종반영
			success = true;
			
		}catch(Exception e) {
			e.printStackTrace();
			if( conn != null) {
				try {conn.rollback();} 
				catch(SQLException ex) {ex.printStackTrace();
			}
			}
		}finally {
			if(conn != null) {
				try {conn.setAutoCommit(true); conn.close();}
				catch(Exception e) {e.printStackTrace();
			}
			}
		}
		return success;
		}
	public boolean insertOrder(String serial, int quantity, int total_price) {
		boolean success = false;
		String insertSql= "INSERT INTO sales_order (serial, quantity, total_price, order_date) VALUES(?,?,?,now())";
		String updateSql= "UPDATE snacks SET stock= stock -? WHERE serial = ?";
		
		try(Connection conn= getConnection()){
			conn.setAutoCommit(false);
			
			try(PreparedStatement pstmt1 = conn.prepareStatement(insertSql);
				PreparedStatement pstmt2 = conn.prepareStatement(updateSql)){
				
				pstmt1.setString(1,serial);
				pstmt1.setInt(2, quantity);
				pstmt1.setInt(3, total_price);
				pstmt1.executeUpdate();
				
				pstmt2.setInt(1, quantity);
				pstmt2.setString(2, serial);
				pstmt2.executeUpdate();
				
				conn.commit();
				success = true;
				
			}catch(Exception e) {
				conn.rollback();
				e.printStackTrace();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return success;
	}
	
	
}




