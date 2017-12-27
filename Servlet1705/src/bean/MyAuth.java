package bean;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class MyAuth extends Authenticator{
	PasswordAuthentication pa;
	
	protected PasswordAuthentication getPasswordAuthentication(){
		String u="gomdi920@naver.com";	//bbb.naver.com
		String p="Ehdqkd466**";
		pa = new PasswordAuthentication(u, p);		
		return pa;
	}

}
