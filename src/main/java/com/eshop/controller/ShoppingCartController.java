package com.eshop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eshop.service.ShoppingCartService;

@Controller
public class ShoppingCartController {
	@Autowired
	private ShoppingCartService shoppingCartService;

	@RequestMapping("cart/info")
	public String info(Model model) {
		model.addAttribute("cart", shoppingCartService);
		return "no-layout/layout/_aside-cart";
	}

	@ResponseBody
	@RequestMapping("cart/add/{id}")
	public String add(@PathVariable("id") Integer id) {
		shoppingCartService.add(id);
		return getInfo();
	}

	@ResponseBody
	@RequestMapping("cart/remove/{id}")
	public String remove(@PathVariable("id") Integer id) {
		shoppingCartService.remove(id);
		return getInfo();
	}

	@ResponseBody
	@RequestMapping("cart/update/{id}/{qty}")
	public String update(@PathVariable("id") Integer id, @PathVariable("qty") Integer qty) {
		shoppingCartService.update(id, qty);
		return getInfo();
	}

	@ResponseBody
	@RequestMapping("cart/clear")
	public void clear() {
		shoppingCartService.clear();
	}

	@RequestMapping("/cart/view")
	public String view(Model model) {
		model.addAttribute("cart", shoppingCartService);
		return "cart/view";
	}

	private String getInfo() {
		return String.format("{\"count\":\"%d\", \"amount\":\"%.2f\"}", shoppingCartService.getCount(),
				shoppingCartService.getAmount());
	}
}
