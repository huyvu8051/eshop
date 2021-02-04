package com.eshop.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eshop.dao.CategoryDAO;
import com.eshop.dao.ProductDAO;
import com.eshop.entity.Product;
import com.eshop.service.HttpService;
import com.eshop.service.MailerService;

@Controller
public class ProductController {
	@Autowired
	private ProductDAO productDAO;

	@Autowired
	private CategoryDAO categoryDAO;

	@Autowired
	private HttpService httpService;
	@Autowired
	private MailerService mailerService;

	@RequestMapping("product/list-by-category/{id}")
	public String product(@PathVariable(value = "id") int id, Model model) {
		model.addAttribute("list", productDAO.findByCategory(categoryDAO.findById(id)));
		return "product/list";
	}

	@RequestMapping("product/detail/{id}")
	public String detail(@PathVariable(value = "id") Integer id, Model model) {
		String ids = httpService.getCookieValue("clicks", id.toString());
		if (!ids.contains(id.toString())) {
			ids += ", " + id;
		}
		httpService.createCookie("clicks", ids, 30);

		List<Product> list = productDAO.findByIds(ids);
		model.addAttribute("clicks", list);
		Product product = productDAO.findById(id);
		model.addAttribute("prod", product);

		String favos = httpService.getCookieValue("favos", "");
		if (favos.length() > 0) {
			List<Product> listFavo = productDAO.findByIds(ids);
			model.addAttribute("favos", listFavo);
		}
		return "product/detail";
	}

	@RequestMapping("product/list-by-keywords")
	public String listByKeywords(@RequestParam("keywords") String key, Model model) {
		List<Product> list = productDAO.findByKeywords(key);
		model.addAttribute("list", list);
		return "product/list";
	}

	@RequestMapping("product/list-by-hot/{key}")
	public String listByHot(@PathVariable("key") String key, Model model) {
		List<Product> list = productDAO.findByHot(key);
		model.addAttribute("list", list);
		return "product/list";
	}

	@ResponseBody
	@RequestMapping("product/favo/{id}")
	public String favo(@PathVariable("id") Integer id, Model model) {
		String ids = httpService.getCookieValue("favos", id.toString());
		if (!ids.contains(id.toString())) {
			ids += ", " + id;
		}
		httpService.createCookie("favos", ids, 30);
		List<Product> list = productDAO.findByIds(ids);
		model.addAttribute("favos", list);
		return "Đã thêm vào danh sách sản phẩm yêu thích";
	}

	@ResponseBody
	@RequestMapping("product/send")
	public String send(@RequestParam("id") Integer id, @RequestParam("from") String from, @RequestParam("to") String to,
			@RequestParam("subject") String subject, @RequestParam("body") String body) {
		String url = httpService.getCurrentUrl().replace("send", "detail/" + id);
		mailerService.send(to, subject, body + "<hr/> <a href='" + url + "' >Chi tiết</a> ", from);
		return "Thông tin sản phẩm đã được gửi.";

	}
}
