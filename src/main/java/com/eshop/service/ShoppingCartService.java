package com.eshop.service;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.annotation.SessionScope;

import com.eshop.dao.ProductDAO;
import com.eshop.entity.Product;

@SessionScope
@Service("cart") // => scopedTarget.cart
public class ShoppingCartService {
	@Autowired
	ProductDAO pdao;
	/**
	 * Chứa các sản phẩm đã chọn
	 */
	Map<Integer, Product> map = new HashMap<>();
	
	/**
	 * Thêm sản phẩm vào giỏ hoặc tăng số lượng nếu sản phẩm đã tồn tại
	 * @param id mã sản phẩm cần thêm
	 */
	public void add(Integer id) {
		Product p = map.get(id);
		if(p != null) { // đã có trong giỏ hàng
			p.setQuantity(p.getQuantity() + 1);
		}
		else { // chưa có => lấy từ CSDL
			p = pdao.findById(id);
			p.setQuantity(1);
			map.put(id, p);
		}
	}
	/**
	 * Xóa sản phẩm khỏi giỏ
	 * @param id mã sản phẩm cần xóa
	 */
	public void remove(Integer id) {
		map.remove(id);
	}
	/**
	 * Cập nhật số lượng sản phẩm trong giỏ
	 * @param id mã sản phẩm cần thay đổi số lượng
	 * @param qty số lượng mới
	 */
	public void update(Integer id, int qty) {
		Product p = map.get(id);
		p.setQuantity(qty);
	}
	/**
	 * Xóa sạch sản phẩm khỏi giỏ
	 */
	public void clear() {
		map.clear();
	}
	/**
	 * Tính tổng tiền
	 */
	public double getAmount() {
		double total = 0;
		for(Product p: this.getItems()) {
			total += p.getQuantity() * p.getUnitPrice() * (1 - p.getDiscount());
		}
		return total;
	}
	/**
	 * Tính tổng số lượng
	 */
	public int getCount() {
		int total = 0;
		for(Product p: this.getItems()) {
			total += p.getQuantity();
		}
		return total;
	}
	/**
	 * Lấy tập hợp các sản phẩm trong giỏ
	 * @return Collection<Product> chứa các mặt hàng trong giỏ
	 */
	public Collection<Product> getItems() {
		return map.values();
	}
}
