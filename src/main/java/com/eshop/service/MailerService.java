package com.eshop.service;

import java.io.File;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class MailerService {
	@Autowired
	JavaMailSender sender;
	
	/**
	 * Gửi email
	 * @param to email người nhận
	 * @param subject tiêu đề email
	 * @param body nội dung email
	 * @param others các thông số còn lại theo thứ tự sau
	 * <ol>
	 * <li>from: email người gửi</li>
	 * <li>cc: chuỗi chứa danh sách email những người đồng nhận, cách nhau dấu phẩy</li>
	 * <li>bcc: chuỗi chứa danh sách email những người đồng nhận bí mật, cách nhau dấu phẩy</li>
	 * <li>files: chuỗi chứa danh sách đường dẫn file đính kèm, cách nhau dấu phẩy</li>
	 * </ol>
	 * @return true nếu gửi mail thành công, ngược lại là false
	 */
	public boolean send(String to, String subject, String body, String...others) {
		try {
			MimeMessage mail = sender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(mail, true, "utf-8");			
			helper.setTo(to);
			helper.setSubject(subject);
			helper.setText(body, true);
			
			// Sender
			String from = "Nghiem Java <nghiemjava@gmail.com>";
			if(others.length > 0 && others[0] != null) {
				from = String.format("%s <%s>", others[0], others[0]);
			}
			helper.setReplyTo(from);
			helper.setFrom(from);
			
			// Receiver CC
			if(others.length > 1 && others[1] != null && others[1].length() > 0) {
				String[] cc = others[1].split("[,; ]+");
				helper.setCc(cc);
			}
			
			// Receiver BCC
			if(others.length > 2 && others[2] != null && others[2].length() > 0) {
				String[] bcc = others[2].split("[,; ]+");
				helper.setBcc(bcc);
			}
			
			// File Attachments
			if(others.length > 3 && others[3] != null && others[3].length() > 0) {
				String[] paths = others[3].split("[,; ]+");
				for(String path: paths) {
					File file = new File(path);
					helper.addAttachment(file.getName(), file);
				}
			}
			// Send
			sender.send(mail);
			return true;
		} 
		catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
}
