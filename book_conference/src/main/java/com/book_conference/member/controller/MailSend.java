package com.book_conference.member.controller;

import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

// 사용자 패스워드 찾기 시 메일 발송용 클래스
public class MailSend {
	public static void MailSendProcess(String receiver, String name,String memberpw) {
		String host = "smtp.naver.com";
		String user = "rogirl71@naver.com";
		String password = "";
		String membername="";
		String memberpasswd="";
		membername =name;
		memberpasswd=memberpw;
		Properties props = new Properties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", 587);
		props.put("mail.smtp.auth", "true");
		        
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user, password);
			}
		});

		try {
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(user));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(receiver));
			message.setSubject("[알림]"+membername+"님 패스워드 전송.");
			message.setText(membername+"님 패스워드는"+memberpasswd+"입니다.");

			Transport.send(message);

		} catch (MessagingException e) {
			e.printStackTrace();
			}
	}
	
	
}
