package com.eshop.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.eshop.dao.OrderDAO;
import com.eshop.dao.ProductDAO;
import com.eshop.entity.Customer;
import com.eshop.entity.Order;
import com.eshop.entity.Product;
import com.eshop.service.HttpService;
import com.eshop.service.ShoppingCartService;

@Controller
public class OrderController {
	@Autowired
	HttpService httpService;
	@Autowired
	ShoppingCartService cart;
	@Autowired
	OrderDAO orderDAO;

	@Autowired
	ProductDAO productDAO;

	@GetMapping("order/checkout")
	public String checkout(Model model) {
		Customer user = httpService.getSession("user");
		model.addAttribute("cart", cart);
		Order order = new Order();
		order.setAmount(cart.getAmount());
		order.setOrderDate(new Date());
		order.setCustomer(user);
		model.addAttribute("order", order);
		return "order/checkout";
	}

	@PostMapping("order/checkout")
	public String checkout(Model model, @ModelAttribute("order") Order order) {
		orderDAO.create(order, cart);
		cart.clear();
		return "redirect:/order/list";
	}

	@GetMapping("order/list")
	public String list(Model model) {
		Customer user = httpService.getSession("user");
		List<Order> list = orderDAO.findByUser(user);
		model.addAttribute("orders", list);
		return "order/list";
	}

	@GetMapping("order/detail/{id}")
	public String detail(Model model, @PathVariable("id") Integer id) {
		Order order = orderDAO.findById(id);
		model.addAttribute("order", order);
		return "order/detail";
	}

	@GetMapping("order/items")
	public String items(Model model) {
		Customer user = httpService.getSession("user");
		List<Product> list = productDAO.findByUser(user);
		model.addAttribute("list", list);
		return "product/list";
	}
}
