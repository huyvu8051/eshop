package com.eshop.controller;

import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.eshop.dao.CustomerDAO;
import com.eshop.entity.Customer;
import com.eshop.service.HttpService;
import com.eshop.service.MailerService;

@Controller
public class AccountController {
	@Autowired
	private CustomerDAO customerDAO;

	@Autowired
	private HttpService httpService;

	@Autowired
	private MailerService mailerService;

	@GetMapping("account/login")
	public String login(Model model) {
		String[] info = httpService.getCookieValue("user", " , ").split(",");
		model.addAttribute("username", info[0]);
		model.addAttribute("password", info[1]);
		return "account/login";
	}

	@PostMapping("account/login")
	public String login(Model model, @RequestParam("username") String username,
			@RequestParam("password") String password,
			@RequestParam(name = "remember", defaultValue = "false") boolean remember) {
		Customer user = customerDAO.findById(username);
		if (user == null) {
			model.addAttribute("message", "Sai tên đăng nhập!");

		} else if (!password.equals(user.getPassword())) {
			model.addAttribute("message", "Sai mật khẩu!");

		} else if (!user.isActivated()) {
			model.addAttribute("message", "Tài khoả của bạn chưa kích hoạt!");
		} else {
			httpService.setSession("user", user);
			model.addAttribute("message", "Đăng nhập thành công!");
			if (remember) {
				httpService.createCookie("user", username + "," + password, 30);
			} else {
				httpService.removeCookie("user");
			}
		}
		return "account/login";
	}

	@GetMapping("account/forgot")
	public String forgot() {

		return "account/forgot";
	}

	@PostMapping("account/forgot")
	public String forgot(Model model, @RequestParam("username") String username, @RequestParam("email") String email) {
		Customer user = customerDAO.findById(username);
		if (user == null) {
			model.addAttribute("message", "Sai tên đăng nhập!");

		} else if (!email.equals(user.getEmail())) {
			model.addAttribute("message", "Sai email đã đăng ký!");

		} else {
			mailerService.send(email, "Forgot password", user.getPassword());
			return "redirect:/account/login?message=" ;
		}
		return "account/forgot";
	}

	@GetMapping("account/register")
	public String register(Model model) {
		Customer customer = new Customer();

		model.addAttribute("user", customer);
		return "account/register";
	}

	@PostMapping("account/register")
	public String register(Model model, @Validated @ModelAttribute("user") Customer customer, BindingResult errors,
			@RequestParam("photo_file") MultipartFile photo) {
		Customer user = customerDAO.findById(customer.getId());
		if (user != null) {
			model.addAttribute("message", "Tên đăng nhập này đã được sử dụng!");
		} else {
			File file = httpService.saveCustomerPhoto(photo);
			if (file != null) {// Co upload
				customer.setPhoto(file.getName());
			}

			if (errors.hasErrors()) {
				model.addAttribute("message", "Vui lòng sửa các lỗi sau đây!");

			} else {
				customerDAO.create(customer);
				model.addAttribute("user", customer);
				model.addAttribute("message", "Đã đăng kí thành công!");

				String url = httpService.getCurrentUrl().replace("register", "activate/" + customer.getId());
				String body = "<a href='" + url + "'> Activate</a>";
				mailerService.send(customer.getEmail(), "Welcome to EShop", body);
			}
		}

		return "account/register";
	}

}
