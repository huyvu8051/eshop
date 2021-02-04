package com.eshop.dao;

import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.eshop.entity.Customer;
import com.eshop.entity.Order;
import com.eshop.entity.OrderDetail;
import com.eshop.entity.Product;
import com.eshop.service.ShoppingCartService;

@Repository
public class OrderDAO extends EShopDAO<Order, Integer>{
	@Autowired
	OrderDetailDAO ddao;
	public void create(Order order, ShoppingCartService cart) {
		this.create(order);
		Collection<Product> items = cart.getItems();
		items.forEach(p -> {
			OrderDetail detail = new OrderDetail();
			detail.setOrder(order);
			detail.setProduct(p);
			detail.setUnitPrice(p.getUnitPrice());
			detail.setDiscount(p.getDiscount());
			detail.setQuantity(p.getQuantity());
			ddao.create(detail);
		});
	}
	
	public List<Order> findByUser(Customer user) {
		String hql = "FROM Order o WHERE o.customer.id=?0 ORDER BY o.orderDate DESC";
		return this.getResultList(hql, user.getId());
	}

}
