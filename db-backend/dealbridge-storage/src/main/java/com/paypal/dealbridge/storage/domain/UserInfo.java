package com.paypal.dealbridge.storage.domain;

import java.util.Date;
import java.util.List;

public class UserInfo {
	private Integer userId;
	private String userName;
	private String gpsDistrict;
	private Integer gender;
	private Date birthday;
	private String email;
	
	private String bankName;
	private String bankOfficial;
	private String bankImg;
	private Integer accountId;
	
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getGpsDistrict() {
		return gpsDistrict;
	}
	public void setGpsDistrict(String gpsDistrict) {
		this.gpsDistrict = gpsDistrict;
	}
	public Integer getGender() {
		return gender;
	}
	public void setGender(Integer gender) {
		this.gender = gender;
	}
	public Date getBirthday() {
		return birthday;
	}
	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}

	public String getBankName() {
		return bankName;
	}
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	public String getBankOfficial() {
		return bankOfficial;
	}
	public void setBankOfficial(String bankOfficial) {
		this.bankOfficial = bankOfficial;
	}
	public String getBankImg() {
		return bankImg;
	}
	public void setBankImg(String bankImg) {
		this.bankImg = bankImg;
	}
	public Integer getAccountId() {
		return accountId;
	}
	public void setAccountId(Integer accountId) {
		this.accountId = accountId;
	}
	
	
}