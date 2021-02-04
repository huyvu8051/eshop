package com.eshop.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.eshop.entity.Category;
import com.eshop.entity.Product;

@Repository
public class ProductDAO extends EShopDAO<Product, Integer>{

	public List<Product> findByKeywords(String keywords) {
		String hql = "FROM Product p WHERE p.name LIKE ?0 OR p.category.name LIKE ?1 OR p.category.nameVN LIKE ?2";
		String kw = "%"+keywords+"%";
		return getResultList(hql, kw, kw, kw);
	}
	
	public List<Product> findByHot(String hotkey) {
		String hql = "FROM Product";
		switch (hotkey) {
		case "best":
			hql = "FROM Product p ORDER BY size (p.orderDetails) DESC";
			break;
		case "disc":
			hql = "FROM Product p WHERE p.discount > 0 ORDER BY p.discount DESC";
			break;
		case "late":
			hql = "FROM Product p ORDER BY p.productDate DESC";
			break;
		case "favo":
			break;
		default:
			break;
		}
		return getResultListPage(hql, 0, 12);
	}

	public List<Product> findByIds(String ids) {
		String hql = "FROM Product p WHERE p.id IN ("+ids+")";
		return getResultList(hql);
	}

	public List<Product> findByCategory(Category category) {
		if(category == null) {
			category = getSingleResult("FROM Category");
		}
		else {
			factory.getCurrentSession().refresh(category);
		}
		return category.getProducts();
	}
}
