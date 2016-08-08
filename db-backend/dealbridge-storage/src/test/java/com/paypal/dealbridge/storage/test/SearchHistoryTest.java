package com.paypal.dealbridge.storage.test;

import static org.junit.Assert.*;

import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.SpringApplicationConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.paypal.dealbridge.storage.domain.SearchHistory;
import com.paypal.dealbridge.storage.mapper.SearchHistoryMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(TestStartApp.class)
@Transactional
public class SearchHistoryTest {
	@Autowired
	private SearchHistoryMapper searchHistoryMapper;
	
	
	@Test
	public void test() {
	}
	

}
