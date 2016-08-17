package com.paypal.dealbridge.web.controller;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.paypal.dealbridge.service.DiscountService;
import com.paypal.dealbridge.service.SearchService;
import com.paypal.dealbridge.storage.domain.Discount;

@Controller
public class HomeController {
	@Autowired
	private DiscountService discountService;
	@Autowired
	private SearchService searchService;
	
	public static final int TOP_DISCOUNT_NUM = 6;
	
	@RequestMapping(path="/home", method=RequestMethod.GET)
	public String showDefaultHomePage() throws UnsupportedEncodingException {
		String url = "redirect:/home/上海";
		url = new String(url.getBytes(), "iso-8859-1");
		return url;
	}
	
	@RequestMapping(path="/home/{area}", method=RequestMethod.GET)
	public String showHomePage(@PathVariable("area") String area, HttpSession session, Model model) {
		int userId = (int)session.getAttribute("userId");
		List<Discount> hots = discountService.getTopDiscount(TOP_DISCOUNT_NUM);
		List<String> hotKeywords = searchService.getHotKeywords(9);
		List<String> searchHistories = searchService.getUserHistory(3, 10);
		model.addAttribute("searchHistories", searchHistories);
		model.addAttribute("hotKeywords", hotKeywords);
		model.addAttribute("hots", hots);
		model.addAttribute("userId", userId);
		model.addAttribute("area", area);
		return "home";
	}
	
}
