package com.book_conference.adminmember.controller;

import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;


public class MailSend {

	public static void MailSendProcess(String receiver, String status,String member) {
		String host = "smtp.naver.com";//메일 발신 계정
		String user = "rogirl71@naver.com";
		String password = "";
		String membername="";
		membername =member;
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
			//처리 결과에 따라 메일 발신
			if(status.equals( "a")){
				message.setSubject("[알림]이용신청승인");
				message.setText(membername+"님 이용 신청이 승인되었습니다.");
			}else if(status.equals( "r")){
				message.setSubject("[알림]이용신청반려");
				message.setText(membername+"님 이용 신청이 반려되었습니다.");
			}
			Transport.send(message);

		} catch (MessagingException e) {
			e.printStackTrace();
			}
	}
	
	
}
