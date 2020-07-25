package com.kashu.website.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.kashu.website.dto.GreetMessage;
import com.kashu.website.repository.ProductDao;
import com.kashu.website.repository.ProductDaoDummyImpl;

@WebServlet("/betaServlet")
public class BetaController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Gson gson = new Gson();
 
    public BetaController() {
        super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//get parameters submitted from front-end UI
		String id = request.getParameter("id");
		System.out.println("id = " + id);
		GreetMessage greet = new GreetMessage("This is greent message , submitted id is", id);
		
	
		//return JSON messages to front-end
				response.setContentType("application/json;charset=utf-8");
		        response.setCharacterEncoding("UTF-8");
		        PrintWriter out = response.getWriter();
		        System.out.println(this.gson.toJson(greet));
		        out.print(this.gson.toJson(greet));
		        out.flush();   
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request,response);
	}

}
