package com.eshop.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.eshop.entity.Customer;

@Repository
public class CustomerDAO extends EShopDAO<Customer, String>{
	public int getUserPageCount(int pageSize) {
		String hql = "SELECT count(c) FROM Customer c WHERE c.admin=false";
		Long rowCount = getSingleResult(hql);
		return (int)Math.ceil(1.0*rowCount/pageSize);
	}
	
	public List<Customer> findUsers(int pageNo, int pageSize) {
		String hql = "FROM Customer c WHERE c.admin=false";
		return getResultListPage(hql, pageNo, pageSize);
	}
	
	public List<Customer> findAdmins() {
		String hql = "FROM Customer c WHERE c.admin=true";
		return getResultList(hql);
	}
}
