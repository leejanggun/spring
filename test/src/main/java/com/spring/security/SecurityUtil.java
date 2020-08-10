package com.spring.security;

import java.security.MessageDigest;

public class SecurityUtil {
	public String encryptSHA256(String pw) throws Exception{
		MessageDigest md =MessageDigest.getInstance("SHA-256");
//		byte salt[] = "salt".getBytes();
//		md.reset();
//		md.update(salt);
		md.update(pw.getBytes());
		byte byteData[] = md.digest();
		StringBuffer sb = new StringBuffer();
		for(int i=0;i<byteData.length;i++) {
			String hex = Integer.toHexString(0xff&byteData[i]);
			if(hex.length()==1) 
				sb.append('0');
			sb.append(hex);
		}
		return sb.toString(); 
	}
}
