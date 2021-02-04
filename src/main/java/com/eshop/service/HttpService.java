package com.eshop.service;

import java.io.File;
import java.util.Base64;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class HttpService {
	@Autowired
	ServletContext application;
	@Autowired
	HttpSession session;
	@Autowired
	HttpServletRequest request;
	@Autowired
	HttpServletResponse response;
	
	/**
	 * Tạo mã hóa và gửi cookie về client
	 * @param name tên cookie
	 * @param value giá trị chưa mã hóa
	 * @param days số ngày tồn tại
	 */
	public void createCookie(String name, String value, int days) {
		Cookie cookie = new Cookie(name, this.encode(value));
		cookie.setMaxAge(days*24*60*60);
		cookie.setPath("/");
		response.addCookie(cookie);
	}
	/**
	 * Xóa cookie
	 * @param name tên cookie cần xóa
	 */
	public void removeCookie(String name) {
		this.createCookie(name, "", 0);
	}
	/**
	 * Đọc và giải mã cookie
	 * @param name tên cookie cần đọc
	 * @param defaultValue giá trị mặc định
	 * @return giá trị đã giải mã cookie nếu tồn tại hoặc defaultValue nếu không tồn tại
	 */
	public String getCookieValue(String name, String defaultValue) {
		Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			for(Cookie cookie : cookies) {
				if(cookie.getName().equalsIgnoreCase(name)) {
					return this.decode(cookie.getValue());
				}
			}
		}
		return defaultValue;
	}
	
	/**
	 * Lưu ảnh người dùng upload
	 * @param photo là file ảnh upload
	 * @return File ảnh được lưu hoặc null nếu không upload ảnh
	 */
	public File saveCustomerPhoto(MultipartFile photo) {
		return this.save(photo, "static/images/customers");
	}
	
	/**
	 * Lưu ảnh sản phẩm upload
	 * @param image là file ảnh upload
	 * @return File ảnh được lưu hoặc null nếu không upload ảnh
	 */
	public File saveProductImage(MultipartFile image) {
		return this.save(image, "static/images/products");
	}
	
	/**
	 * Lưu file upload vào một thư mục
	 * @param uploadfile là file upload
	 * @param folder là thư mục chứa file upload
	 * @return File được lưu hoặc null nếu không upload file
	 */
	public File save(MultipartFile uploadfile, String folder) {
		try {
			if(!uploadfile.isEmpty()) {
				String fname = uploadfile.getOriginalFilename();
				fname = UUID.randomUUID().toString() + fname.substring(fname.lastIndexOf("."));
				File file = new File(application.getRealPath(folder), fname); 
				uploadfile.transferTo(file);
				return file;
			}
		} 
		catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * Mã hóa chuỗi dạng Base64
	 * @param text là chuỗi cần mã hóa
	 * @return chuỗi đã mã hóa
	 */
	public String encode(String text) {
		return Base64.getEncoder().encodeToString(text.getBytes());
	}
	/**
	 * Giải mã chuỗi được mã hóa dạng Base64
	 * @param encodedText là chuỗi mã hóa
	 * @return chuỗi đã giải mã
	 */
	public String decode(String encodedText) {
		return new String(Base64.getDecoder().decode(encodedText));
	}
	
	public String getCurrentUrl() {
		return request.getRequestURL().toString();
	}
	public String getCurrentUri() {
		return request.getRequestURI();
	}
	@SuppressWarnings("unchecked")
	public <T> T getSession(String name) {
		return (T) session.getAttribute(name);
	}
	public void setSession(String name, Object value) {
		session.setAttribute(name, value);
	}
	public void removeSession(String name) {
		session.removeAttribute(name);
	}

}
