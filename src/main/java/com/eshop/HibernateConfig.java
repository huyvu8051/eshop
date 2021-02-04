package com.eshop;

import java.util.Properties;

import javax.sql.DataSource;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.orm.hibernate5.HibernateTransactionManager;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;

@Configuration
@PropertySource("classpath:db.properties")
public class HibernateConfig {
	@Autowired
	Environment env;

	@Bean
	public DataSource getDataSource() {
		DriverManagerDataSource dataSource = new DriverManagerDataSource();
		dataSource.setDriverClassName(env.getProperty("db.driver"));
		dataSource.setUrl(env.getProperty("db.url"));
		dataSource.setUsername(env.getProperty("db.username"));
		dataSource.setPassword(env.getProperty("db.password"));
		return dataSource;

	}

	@Bean
	@Autowired
	public SessionFactory getSessionFactory(DataSource dataSource) throws Exception {
		LocalSessionFactoryBean fb = new LocalSessionFactoryBean();
		fb.setDataSource(dataSource);
		fb.setPackagesToScan(new String[] { "com.eshop.entity" });
		Properties props = fb.getHibernateProperties();
		props.put("hibernate.show_sql", env.getProperty("hb.show_sql"));
		props.put("hibernate.format_sql", env.getProperty("hb.format_sql"));
		props.put("hibernate.ddl-auto", env.getProperty("hb.ddl-auto"));
		props.put("hibernate.dialect", env.getProperty("hb.dialect"));
		props.put("current_session_context_class", env.getProperty("hb.session"));
		fb.afterPropertiesSet(); // validate all properties
		SessionFactory factory = fb.getObject();
		return factory;
	}

	@Bean
	@Autowired
	public HibernateTransactionManager getHibernateTransactionManager(SessionFactory factory) {
		return new HibernateTransactionManager(factory);
	}
}
