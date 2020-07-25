package com.kashu.website.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.kashu.website.entity.Product;

public class ProductDaoJdbcImpl implements ProductDao {
	private DataSource dataSource;

	public ProductDaoJdbcImpl() {
		Context initContext;
		try {
			initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:comp/env");
	        dataSource = (DataSource) envContext.lookup("jdbc/DB_SPRING");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	public int countByName(String keyword) {
		int count = 0;
		try {
			Connection conn = dataSource.getConnection(); 
			
			String sql = "SELECT COUNT(id_bin) AS _rows_ FROM TB_YOAN_PRODUCT WHERE name LIKE ?;";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+keyword+"%");
			ResultSet rs = stmt.executeQuery();
			
			//Recordset only has one cell , fetch it with if-statement is enough 
			if(rs.next()) {
				count = rs.getInt("_rows_");
			}
						
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count;
	}

	public List<Product> searchByName(String keyword, int start_index, int records_per_page, String order_column, String order_type) {
		
		List<Product> products = new ArrayList<Product>();
		Product product = null;
		try {
			Connection conn = dataSource.getConnection(); 
			
			String sql = "SELECT id_text, name, price, amount, description FROM TB_YOAN_PRODUCT WHERE name LIKE ? ORDER BY ";
			       sql += order_column + " " + order_type + " LIMIT " + records_per_page + " OFFSET " + start_index + ";";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+keyword+"%");
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()) {
				product = new Product();
				product.setId(rs.getString("id_text"));
				product.setName(rs.getString("name"));
				product.setPrice(rs.getInt("price"));
				product.setAmount(rs.getInt("amount"));
				product.setDescription(rs.getString("description"));
				products.add(product);
			}
			
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return products;
	}

	public Product getById(String id) {
		Product product = null;
		return product;
	}

}
