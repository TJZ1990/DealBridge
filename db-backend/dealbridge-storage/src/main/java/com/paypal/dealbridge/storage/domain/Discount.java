package com.paypal.dealbridge.storage.domain;

import java.util.Date;

public class Discount {
	private Integer discountId;
	private String bankName;
	private String summary;
	private String description;
	private Date beginTime;
	private Date endTime;
	private String area;
	private String discountDetail;
	private String discountUsage;
	private String type;
	private String characteristic;
	private String img;
	private String merchantDescription;
	private String merchantLocation;
	private String merchantTel;
	private String endOfUrl;
	private Integer clickrate;
	

	public Integer getDiscountId() {
		return discountId;
	}

	public void setDiscountId(Integer discountId) {
		this.discountId = discountId;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Date getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(Date beginTime) {
		this.beginTime = beginTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public String getDiscountDetail() {
		return discountDetail;
	}

	public void setDiscountDetail(String discountDetail) {
		this.discountDetail = discountDetail;
	}

	public String getDiscountUsage() {
		return discountUsage;
	}

	public void setDiscountUsage(String discountUsage) {
		this.discountUsage = discountUsage;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getCharacteristic() {
		return characteristic;
	}

	public void setCharacteristic(String characteristic) {
		this.characteristic = characteristic;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public String getMerchantDescription() {
		return merchantDescription;
	}

	public void setMerchantDescription(String merchantDescription) {
		this.merchantDescription = merchantDescription;
	}

	public String getMerchantLocation() {
		return merchantLocation;
	}

	public void setMerchantLocation(String merchantLocation) {
		this.merchantLocation = merchantLocation;
	}

	public String getMerchantTel() {
		return merchantTel;
	}

	public void setMerchantTel(String merchantTel) {
		this.merchantTel = merchantTel;
	}

	public String getEndOfUrl() {
		return endOfUrl;
	}

	public void setEndOfUrl(String endOfUrl) {
		this.endOfUrl = endOfUrl;
	}

	public Integer getClickRate() {
		return clickrate;
	}

	public void setClickRate(Integer clickrate) {
		this.clickrate = clickrate;
	}
	
	

}
