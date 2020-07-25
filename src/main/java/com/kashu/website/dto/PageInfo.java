package com.kashu.website.dto;

import java.util.ArrayList;
import java.util.List;

import com.kashu.website.entity.Product;

public class PageInfo {
	List<Product> products = new ArrayList<Product>();
	int min_page_number = 0;
	int page_number = 0;
	int max_page_number = 0;
	int records_per_page = 10;
	int total_records = 0;
	String order_column = "";
	String order_type= "";
	String keyword = "";
	
	public PageInfo() {
		
	}
	
	public PageInfo(List<Product> products, int min_page_number, int page_number, int max_page_number, int records_per_page, int total_records, String order_column, String order_type, String keyword) {
		this.products = products;
		this.min_page_number = min_page_number;
		this.page_number = page_number;
		this.max_page_number = max_page_number;
		this.records_per_page = records_per_page;
		this.total_records = total_records;
		this.order_column = order_column;
		this.order_type = order_type;
		this.keyword = keyword;
	}

	public List<Product> getProducts() {
		return products;
	}

	public void setProducts(List<Product> products) {
		this.products = products;
	}

	public int getMin_page_number() {
		return min_page_number;
	}

	public void setMin_page_number(int min_page_number) {
		this.min_page_number = min_page_number;
	}

	public int getPage_number() {
		return page_number;
	}

	public void setPage_number(int page_number) {
		this.page_number = page_number;
	}

	public int getMax_page_number() {
		return max_page_number;
	}

	public void setMax_page_number(int max_page_number) {
		this.max_page_number = max_page_number;
	}

	public int getRecords_per_page() {
		return records_per_page;
	}

	public void setRecords_per_page(int records_per_page) {
		this.records_per_page = records_per_page;
	}

	public int getTotal_records() {
		return total_records;
	}

	public void setTotal_records(int total_records) {
		this.total_records = total_records;
	}

	public String getOrder_column() {
		return order_column;
	}

	public void setOrder_column(String order_column) {
		this.order_column = order_column;
	}

	public String getOrder_type() {
		return order_type;
	}

	public void setOrder_type(String order_type) {
		this.order_type = order_type;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

}
