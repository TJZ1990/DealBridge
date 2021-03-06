package com.paypal.dealbridge.web.controller;

import java.text.ParseException;
import java.util.List;

import org.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.paypal.dealbridge.service.SearchService;
import com.paypal.dealbridge.service.solr.SolrQueryException;
import com.paypal.dealbridge.storage.domain.BriefDiscount;

@Controller
public class SearchController {
	// TODO check userId from session

	@Autowired
	private SearchService searchService;

	@RequestMapping(path = "/api/search_history/{userId}", method = RequestMethod.PUT)
	@ResponseBody
	public void insertHistoryRecord(@PathVariable("userId") int userId, @RequestParam("keyword") String keyword) {
		searchService.insertSearchHistory(userId, keyword);
	}

	@RequestMapping(path = "/api/search_history/{userId}", method = RequestMethod.GET)
	@ResponseBody
	public List<String> getUserSearchHistory(@PathVariable("userId") int userId,
			@RequestParam("limitNumber") int limitNumber) {
		return searchService.getUserHistory(userId, limitNumber);
	}

	@RequestMapping(path = "/api/search_history/{userId}", method = RequestMethod.POST)
	@ResponseBody
	public void clearSearchHistory(@PathVariable("userId") int userId) {
		searchService.setHistoryInvisible(userId);
	}
	
	@RequestMapping(path="/api/search", method = RequestMethod.GET)
	@ResponseBody
	public List<BriefDiscount> search(@RequestParam("query") String query, @RequestParam("start") int start, @RequestParam("rows") int rows) throws SolrQueryException, JSONException, ParseException {
		return searchService.searchDiscount(query, start, rows);
	}
	
	@RequestMapping(path = "/search", method = RequestMethod.GET)
	public String showSearchPage(Model model) {
		List<String> hotKeywords = searchService.getHotKeywords(9);
		List<String> searchHistories = searchService.getUserHistory(3, 10);
		model.addAttribute("searchHistories", searchHistories);
		model.addAttribute("hotKeywords", hotKeywords);
		return "search";
	}
	
	@RequestMapping(path = "/search_result", method=RequestMethod.GET)
	public String showSearchResult(@RequestParam("query") String query, Model model) {
		List<String> hotKeywords = searchService.getHotKeywords(9);
		List<String> searchHistories = searchService.getUserHistory(3, 10);
		model.addAttribute("searchHistories", searchHistories);
		model.addAttribute("hotKeywords", hotKeywords);
		model.addAttribute("query", query);
		return "search_result";
	}
}
