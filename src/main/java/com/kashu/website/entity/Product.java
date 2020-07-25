package com.kashu.website.entity;

public class Product {
	private String id;
	private String name;
	private int price;
	private int amount;
	private String description;
	
	public Product() {
		
	}
	
	public Product(String id, String name, int price, int amount, String description) {
		this.id = id;
		this.name = name;
		this.price = price;
		this.amount = amount;
		this.description = description;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

}
