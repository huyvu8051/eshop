package com.eshop.controller;

import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.eshop.dao.CustomerDAO;
import com.eshop.entity.Customer;
import com.eshop.service.HttpService;
import com.eshop.service.MailerService;

@Controller
public class AccountController {
	@Autowired
	HttpService http;
	@Autowired
	MailerService mailer;
	@Autowired
	CustomerDAO cdao;
	
	@GetMapping("/account/login")
	public String loginForm(Model model) {
		String[] user = http.getCookieValue("user", " , ").split(",");
		model.addAttribute("username", user[0].trim());
		model.addAttribute("password", user[1].trim());
		return "account/login";
	}
	@PostMapping("/account/login")
	public String login(Model model, 
			@RequestParam("username") String id,
			@RequestParam("password") String pw,
			@RequestParam(name="remember", defaultValue="false") Boolean rm) {
		Customer user = cdao.findById(id);
		if(user == null) {
			model.addAttribute("message", "Invalid username!");
		}
		else if(!user.getPassword().equals(pw)) {
			model.addAttribute("message", "Invalid password!");
		}
		else if(!user.isActivated()) {
			model.addAttribute("message", "This account is not activated!");
		}
		else {
			http.setSession("user", user);
			model.addAttribute("message", "Login successfully!");
			http.createCookie("user", id + "," + pw, rm ? 30 : 0);

			String secureUri = http.getSession("secure-uri");
			if(secureUri != null) {
				return "redirect:"+secureUri;
			}
		}
		return "account/login";
	}
	@RequestMapping("/account/logoff")
	public String logoff() {
		http.removeSession("user");
		return "redirect:/home/index";
	}
	
	@GetMapping("/account/register")
	public String registerForm(Model model) {
		Customer user = new Customer();
		model.addAttribute("user", user);
		return "account/register";
	}
	@PostMapping("/account/register")
	public String register(Model model, 
			@RequestParam("photo_file") MultipartFile file,
			@RequestParam("confirm") String confirm,
			@Validated @ModelAttribute("user") Customer form, BindingResult errors) {
		if(errors.hasErrors()) {
			model.addAttribute("message", "Please fix the bugs bellow!");
		}
		else if(!confirm.equals(form.getPassword())) {
			model.addAttribute("message", "Password and its confirm are not same!");
		}
		else {
			Customer user = cdao.findById(form.getId());
			if(user != null) {
				model.addAttribute("message", "This id is in used!");
			}
			else if(!this.sendWelcome(form)) {
				model.addAttribute("message", "Unable to send your email!");
			}
			else {
				File photo = http.saveCustomerPhoto(file);
				if(photo != null) {
					form.setPhoto(photo.getName());
				}
				else {
					form.setPhoto("user.png");
				}
				cdao.create(form);
				model.addAttribute("message", "Check email and activate your account!");
				
				return "redirect:/account/login?message=" + model.getAttribute("message");
			}
		}
		return "account/register";
	}
	@GetMapping("/account/activate/{id}")
	public String activate(Model model, @PathVariable("id") String id) {
		Customer user = cdao.findById(http.decode(id));
		user.setActivated(true);
		cdao.update(user);
		
		model.addAttribute("message", "Your account was activated!");
		return "redirect:/account/login?message=" + model.getAttribute("message");
	}
	
	@GetMapping("/account/forgot")
	public String forgotForm() {
		return "account/forgot";
	}
	@PostMapping("/account/forgot")
	public String forgot(Model model,
			@RequestParam("username") String id, @RequestParam("email") String email) {
		Customer user = cdao.findById(id);
		if(user == null) {
			model.addAttribute("message", "Invalid username!");
		}
		else if(!user.getEmail().equalsIgnoreCase(email)) {
			model.addAttribute("message", "Invalid email address!");
		}
		else if(!this.sendPassword(user)){
			model.addAttribute("message", "Unable to send your email!");
		}
		else {
			model.addAttribute("message", "Your password was sent to your inbox!");
			return "redirect:/account/login?message=" + model.getAttribute("message");
		}
		return "account/forgot";
	}
	
	@GetMapping("/account/change")
	public String changeForm() {
		return "account/change";
	}
	@PostMapping("/account/change")
	public String change(Model model,
			@RequestParam("username") String id, 
			@RequestParam("password") String password,
			@RequestParam("newpwd") String newpwd,
			@RequestParam("confirm") String confirm) {
		if(id.isEmpty() || password.isEmpty() || newpwd.isEmpty() || confirm.isEmpty()) {
			model.addAttribute("message", "All fileds are required!");
		}
		else if(!newpwd.equals(confirm)) {
			model.addAttribute("message", "New password and its confirm are not same!");
		}
		else {
			Customer user = http.getSession("user");
			if(!user.getId().equals(id)) {
				model.addAttribute("message", "Invalid username!");
			}
			else if(!user.getPassword().equalsIgnoreCase(password)) {
				model.addAttribute("message", "Invalid password!");
			}
			else {
				user.setPassword(confirm);
				cdao.update(user);
				model.addAttribute("message", "Your password was changed!");
				return "redirect:/account/login?message=" + model.getAttribute("message");
			}
		}
		return "account/change";
	}
	
	@GetMapping("/account/edit")
	public String edit(Model model) {
		model.addAttribute("user", http.getSession("user"));
		return "account/edit";
	}
	@PostMapping("/account/edit")
	public String edit(Model model, 
			@RequestParam("photo_file") MultipartFile file,
			@Validated @ModelAttribute("user") Customer form, BindingResult errors) {
		if(errors.hasErrors()) {
			model.addAttribute("message", "Please fix the bugs bellow!");
		}
		else {
			File photo = http.saveCustomerPhoto(file);
			if(photo != null) {
				form.setPhoto(photo.getName());
			}
			cdao.update(form);
			http.setSession("user", form);
			model.addAttribute("message", "Your profile was updated!");
		}
		return "account/edit";
	}
	
	boolean sendWelcome(Customer user) {
		String to = user.getEmail();
		String subject = "Welcome to E-Shop";
		String url = http.getCurrentUrl().replace("register", "activate/"+http.encode(user.getId()));
		String body = "<a href='"+url+"'>Click to activate your account!</a>";
		return mailer.send(to, subject, body);
	}
	boolean sendPassword(Customer user) {
		String to = user.getEmail();
		String subject = "Forgot password form E-Shop";
		String body = "Your password is <strong>"+user.getPassword()+"</strong>. Delete this email because of security.";
		return mailer.send(to, subject, body);
	}
}
