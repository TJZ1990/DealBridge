package com.paypal.dealbridge.service.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

import com.paypal.dealbridge.storage.domain.BriefDiscount;

@Service
public class ServiceUtil {
	public BriefDiscount JsonToBriefDiscount(JSONObject doc) throws JSONException, ParseException {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		BriefDiscount discount = new BriefDiscount();
		discount.setBankName(doc.getString("bank_name"));
		discount.setSummary(doc.getString("summary"));
		discount.setDiscountId(doc.getInt("id"));
		discount.setDescription(doc.getString("description"));
		if (!doc.isNull("begin_time")) {
			discount.setBeginTime(dateFormat.parse(doc.getString("begin_time")));
		}
		if (!doc.isNull("end_time")) {
			discount.setEndTime(dateFormat.parse(doc.getString("end_time")));
		}
		if (!doc.isNull("distance")) {
			discount.setDistance(doc.getDouble("distance"));
		}
		discount.setImg(doc.getString("img"));
		
		return discount;
	}
}