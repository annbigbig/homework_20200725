package com.kashu.website.dto;

public class GreetMessage {
	private String title;
	private String message;
	
	public GreetMessage() {
		this.title = "";
		this.message = "";
	}
	
	public GreetMessage(String title, String message) {
		this.title = title;
		this.message = message;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	
}
