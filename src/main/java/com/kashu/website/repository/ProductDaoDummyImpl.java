package com.kashu.website.repository;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
import com.kashu.website.entity.Product;

public class ProductDaoDummyImpl implements ProductDao {
	List<Product> shoes = new ArrayList<Product>();
	List<Product> routers = new ArrayList<Product>();

	public ProductDaoDummyImpl() {
		//shoes , 26 rows
		shoes = readDataFromCsv("shoes.csv");
		
		//routers , 35 rows
		routers = readDataFromCsv("routers.csv");
	}

	public int countByName(String keyword) {
		int result = 0;
		if(keyword.equals("球鞋") || keyword.equals("shoes")) {
			result = 26;
		}else if(keyword.equals("路由") || keyword.equals("routers")) {
			result = 35;
		}
		return result;
	}

	/*
	 * List.subList usage was found here : 
	 * https://www.geeksforgeeks.org/arraylist-sublist-method-in-java-with-examples/
	 */
	public List<Product> searchByName(String keyword, int start_index, int records_per_page, String order_column, String order_type) {
		List<Product> products = new ArrayList<Product>();
		if(keyword.equals("球鞋") || keyword.equals("shoes")) {
			
			if(start_index <= 10) {
				products = shoes.subList(start_index, (start_index + records_per_page));
			} else if (start_index == 20 ){
				// 26 records, indexes on last page : 20,21,22,23,24,25
				products = shoes.subList(start_index, 26);
			}
			
		}else if (keyword.equals("路由") || keyword.equals("routers")) {

			if(start_index <= 20) {
				products = routers.subList(start_index, (start_index + records_per_page));
			} else if (start_index == 30 ){
				// 35 records, indexes on last page : 30,31,32,33,34
				products = routers.subList(start_index, 35);
			}
		}
		
		return products;
	}

	public Product getById(String id) {
		Product product = null;
		return product;
	}

	/*
	 * this function was inspired by these links
	 * https://dotblogs.com.tw/cylcode/2018/10/04/165113
	 * https://stackoverflow.com/questions/15749192/how-do-i-load-a-file-from-resource-folder
	 */
	private List<Product> readDataFromCsv(String filepath) {
		List<Product> products = new ArrayList<Product>();
		Product p;
		
		try {
			   ClassLoader classloader = Thread.currentThread().getContextClassLoader();
			   InputStream is = classloader.getResourceAsStream(filepath);
			   InputStreamReader isr = new InputStreamReader(is);
			   BufferedReader reader = new BufferedReader(isr);
			   String line = null;
			   while((line=reader.readLine())!=null){
			      String item[] = line.split(",");
			      /*
			      String  data1= item[0].trim();
			      String  data2= item[1].trim();
			      String  data3= item[2].trim();
			      String  data4= item[3].trim();
			      String  data5= item[4].trim();
			      System.out.print(data1+"\t"+ data2+"\t"+ data3+"\t"+ data4+"\t"+ data5+"\n"); 
			      */
			      String  data1= item[0].trim();
			      String  data2= item[1].trim();
			      int data3= Integer.parseInt(item[2].trim());
			      int data4= Integer.parseInt(item[3].trim());
			      String  data5= item[4].trim();
			      p = new Product(data1,data2,data3,data4,data5);
			      products.add(p);
			   }
			   reader.close();
		} catch (Exception e) {
			   e.printStackTrace();
		}
	    
		return products;
	}
}
