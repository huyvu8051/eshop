package com.eshop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.eshop.dao.CategoryDAO;

@Controller
public class HomeController {
	@RequestMapping("home/index")
	public String index() {
		return "home/index";
	}
	@RequestMapping("home/about")
	public String about() {
		return "home/about";
	}
	@RequestMapping("home/contact")
	public String contact() {
		return "home/contact";
	}
	@RequestMapping("home/feedback")
	public String feedback() {
		return "home/feedback";
	}
	@RequestMapping("home/faq")
	public String faq() {
		return "home/faq";
	}
	
	@Autowired
	private CategoryDAO categoryDAO;
	@RequestMapping("home/aside/category")
	public String category(Model model) {
		model.addAttribute("categories", categoryDAO.findAll());
		return "no-layout/layout/_aside-category";
	}
}
