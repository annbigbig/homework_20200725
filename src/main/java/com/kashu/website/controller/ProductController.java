package com.kashu.website.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.kashu.website.dto.PageInfo;
import com.kashu.website.entity.Product;
import com.kashu.website.repository.ProductDao;
import com.kashu.website.repository.ProductDaoDummyImpl;
import com.kashu.website.repository.ProductDaoJdbcImpl;

@WebServlet("/productServlet")
public class ProductController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	ProductDao productDao;
	private Gson gson = new Gson();
	
	//set parameters default values here
	private static final int records_per_page = 10; //this parameter could be set by users maybe someday future if they need to do this
	private String keyword = "";
	private int page_number = 1;
	private String order_column = "name";
	private String order_type = "asc";
       
    public ProductController() {
        super();
        // dummy data from csv files, use it only when u don't have JNDI resource and real database connection 
     	//productDao = new ProductDaoDummyImpl();
        
        productDao = new ProductDaoJdbcImpl();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//get parameters submitted from front-end UI
		keyword = (request.getParameter("keyword")!=null && request.getParameter("keyword").length()>0) ? request.getParameter("keyword") : keyword;
		String page_number_str = request.getParameter("page_number");
		page_number = (page_number_str!=null && Integer.parseInt(page_number_str) > 0) ? Integer.parseInt(page_number_str) : page_number;
		order_column = (request.getParameter("order_column")!=null && request.getParameter("order_column").length()>0) ? request.getParameter("order_column") : order_column;
		order_type = (request.getParameter("order_type")!=null && request.getParameter("order_type").length()>0) ? request.getParameter("order_type") : order_type;
		
		//------BEGINNING----- u could separate this part into Service layer ------BEGINNING------
		
		//calculate page number information
		PageInfo pageInfo = new PageInfo();
		int total_records = productDao.countByName(keyword);
		int start_index = (page_number - 1) * records_per_page;
		int min_page_number = (total_records > 0) ? 1 : 0;
		int max_page_number = (total_records % records_per_page ==  0) ? (total_records / records_per_page) : ((total_records-1) / records_per_page) + 1;
		
		//encapsulate page info and matched products into DTO
		pageInfo.setMin_page_number(min_page_number);
		pageInfo.setPage_number(page_number);
		pageInfo.setMax_page_number(max_page_number);
		pageInfo.setRecords_per_page(records_per_page);
		pageInfo.setTotal_records(total_records);
		pageInfo.setKeyword(keyword);
		pageInfo.setOrder_column(order_column);
		pageInfo.setOrder_type(order_type);
		List<Product> matched_products = new ArrayList<Product>();
		
		//fetch records only when page number is reasonable
		if((page_number>=min_page_number) && (page_number<=max_page_number) && (page_number!=0)) {
			matched_products = productDao.searchByName(keyword, start_index, records_per_page, order_column, order_type);
			pageInfo.setProducts(matched_products);
		}
		
		//------ENDING------ u could separate this part into Service layer ------ENDING-------
		
		//return JSON messages to front-end
		response.setContentType("application/json;charset=utf-8");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        System.out.println(this.gson.toJson(pageInfo));
        out.print(this.gson.toJson(pageInfo));
        out.flush();   
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	/* just for testing page number formula
	public static void main(String[] args) {
		int total_records = 0;
		int min_page_number = (total_records > 0) ? 1 : 0;
		int max_page_number = (total_records % records_per_page ==  0) ? (total_records / records_per_page) : ((total_records-1) / records_per_page) + 1;
		System.out.println("min_page_number = " + min_page_number);
		System.out.println("max_page_number = " + max_page_number);
	}
	*/
}
