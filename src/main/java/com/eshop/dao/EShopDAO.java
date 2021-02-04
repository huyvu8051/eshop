package com.eshop.dao;

import java.lang.reflect.ParameterizedType;
import java.util.List;

import javax.persistence.TypedQuery;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

/**
 * Lớp EShopDAO<E, K> là lớp tổng quát làm việc với một Entity
 * @param <E> là kiểu Entity
 * @param <K> là kiểu Primary Key field
 * @author Nhất Nghệ
 * @version 1.0 - 7/2020
 */
@Transactional
public class EShopDAO<E, K> {
	@Autowired
	protected SessionFactory factory;
	/**
	 * Thêm mới một thực thể vào CSDL
	 * @param entity là thực thể cần thêm mới
	 * @return thực thể đã được thêm vào với đầy đủ thông tin
	 */
	public E create(E entity) {
		Session session = factory.getCurrentSession();
		session.save(entity);
		return entity;
	}
	/**
	 * Cập nhật một thực thể vào CSDL
	 * @param entity là thực thể chứa thông tin cần cập nhật
	 */
	public void update(E entity) {
		Session session = factory.getCurrentSession();
		session.update(entity);
	}
	/**
	 * Xóa các thực thể khỏi CSDL
	 * @param ids là mảng chứa các id cần xóa
	 */
	public void delete(@SuppressWarnings("unchecked") K...ids) {
		Session session = factory.getCurrentSession();
		for(K id : ids) {
			E entity = this.findById(id);
			session.delete(entity);
		}
	}
	/**
	 * Truy vấn một thực thể từ CSDL
	 * @param id là mã của thể cần tìm
	 * @return thực thể được truy vấn hoặc null nếu thực thể không tồn tại
	 */
	public E findById(K id) {
		Session session = factory.getCurrentSession();
		Class<E> entityClass = this.getEntityClass();
		E entity = session.find(entityClass, id);
		return entity;
	}
	/**
	 * Truy vấn tất cả mọi thực thể từ CSDL
	 * @return danh sách các thực thể truy vấn được
	 */
	public List<E> findAll() {
		String hql = "FROM " + this.getEntityClass().getSimpleName();
		List<E> list = this.getResultList(hql);
		return list;
	}
	/**
	 * Truy vấn danh sách giá trị từ CSDL
	 * @param <T> kiểu giá trị cần truy vấn
	 * @param hql là câu lệnh HQL có thể chứa tham số
	 * @param args là mảng giá trị cung cấp cho các tham số trong hql
	 * @return danh sách các giá trị truy vấn được
	 */
	public <T> List<T> getResultList(String hql, Object...args){
		return this.getResultListPage(hql, 0, 0, args);
	}
	/**
	 * Truy vấn một giá trị từ CSDL
	 * @param <T> kiểu giá trị cần truy vấn
	 * @param hql là câu lệnh HQL có thể chứa tham số
	 * @param args là mảng giá trị cung cấp cho các tham số trong hql
	 * @return giá trị truy vấn được
	 */
	public <T> T getSingleResult(String hql, Object...args){
		List<T> list = this.getResultListPage(hql, 0, 1, args);
		return list.isEmpty() ? null : list.get(0);
	}
	/**
	 * Truy vấn danh sách giá trị từ CSDL
	 * @param <T> kiểu giá trị cần truy vấn
	 * @param hql là câu lệnh HQL có thể chứa tham số
	 * @param page là trang số cần truy vấn
	 * @param size là số giá trị cần truy vấn
	 * @param args là mảng giá trị cung cấp cho các tham số trong hql
	 * @return danh sách các giá trị truy vấn được
	 * <h1>Ví dụ</h1>
	 * <em>Truy vấn tất cả các sản phẩm</em><br>
	 * String hql = "FROM Product";<br>
	 * List&lt;Product&gt; list = getResultListPage(hql, 0, 0);
	 * <hr>
	 * <em>Truy vấn các sản phẩm trang số 3 (mỗi trang 8) có giá từ 5 đến 9.5</em><br>
	 * String hql = "FROM Product p WHERE p.unitPrice BETWEEN ? AND ?";<br>
	 * List&lt;Product&gt; list = getResultListPage(hql, 2, 8, 5.0, 9.5);
	 * <hr>
	 * <em>Truy vấn tên các sản phẩm trang số 3 (mỗi trang 8) có giá từ 5 đến 9.5</em><br>
	 * String hql = "SELECT p.name FROM Product p WHERE p.unitPrice BETWEEN ? AND ?";<br>
	 * List&lt;String&gt; list = getResultListPage(hql, 2, 8, 5.0, 9.5);
	 */
	protected <T> List<T> getResultListPage(String hql, int page, int size, Object...args){
		Session session = factory.getCurrentSession();
		@SuppressWarnings("unchecked")
		TypedQuery<T> query = session.createQuery(hql);
		// Phân trang
		if(size > 0) {
			query.setFirstResult(page*size);
			query.setMaxResults(size);
		}
		// Tham số
		for(int i=0; i<args.length;i++) {
			query.setParameter(i, args[i]);
		}
		List<T> list = query.getResultList();
		return list;
	}
	
	/**
	 * Lấy kiểu của tham số generic đầu tiên (E) của EShopDAO<E, K>
	 * @return là kiểu của E
	 */
	@SuppressWarnings({ "unchecked" })
	private Class<E> getEntityClass(){
		ParameterizedType type = (ParameterizedType) this.getClass().getGenericSuperclass();
		return (Class<E>) type.getActualTypeArguments()[0];
	}
}
