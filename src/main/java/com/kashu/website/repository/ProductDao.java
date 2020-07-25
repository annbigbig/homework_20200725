package com.kashu.website.repository;

import java.util.List;

import com.kashu.website.entity.Product;

public interface ProductDao {
	int countByName(String keyword);
	List<Product> searchByName(String keyword, int start_index, int records_per_page, String order_column, String order_type);
	Product getById(String id);
}
