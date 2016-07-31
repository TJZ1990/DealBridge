#!/usr/bin/python
# -*- coding: UTF-8 -*-
import threading
import requests
import detail_info
import store_data
import bs4
import re
import sys
import log
import multiprocessing
import traceback
import store_data
from request_page import get_page
from multiprocessing import Process, Queue, Pool
reload(sys)
sys.setdefaultencoding('utf8')


def get_num_of_page(url):
    """Get the total number of discounts"""
    content = get_page(url)
    result_title = content.find("div", {"class": "result-title"}).string.encode("latin1")
    pattern = re.compile(r'.*?(\d+).*')
    total_result = re.findall(pattern, result_title)[0]
    total_result = int(total_result)
    # print total_result
    num_of_page = total_result / 20
    if total_result % 20 != 0:
        num_of_page += 1
    return num_of_page


def get_end_of_url(url):
    """Return the distinctive content of a series of urls.
       Example:
           url: 'http://www.rong360.com/credit/youhui/2469ec8784e05534c603e15276cc3afb'
           return '2469ec8784e05534c603e15276cc3afb'
    """
    p = re.compile(r'.*/(.*)')
    return re.findall(p, url)[0]


def get_short_description_page(url, page_queue):
    """Get the content of a short description page.
       Each short description page has twenty subpage.
       Then, continue to get content of all subpages and store the result to database.
    """
    try:
        content = get_page(url)
        li = content.findAll("li", {"class": "clearfix"})
        discount_dicts = []
        for discount in li:
            img = discount.find("img")['src']
            link = 'http://www.rong360.com' + discount.find("a")['href']
            if link == 'http://www.rong360.com/credit/xingye':
                break
            end_of_url = get_end_of_url(link.encode('latin1'))
            sql = "select discount_id from discount where end_of_url = '" + end_of_url + "'"
            page_queue.put([end_of_url, img])
    except Exception, e:
        print e
        traceback.print_exc()


def get_page_url(queue, total_num_of_page, page_queue):
    p_num = queue.get()
    while p_num < total_num_of_page:
        p_num += 1
        queue.put(p_num)
        print multiprocessing.current_process().name + 'processing: ' + str(p_num)
        url = 'http://www.rong360.com/credit/f-youhui' + '-p' + str(p_num)
        get_short_description_page(url, page_queue)
        p_num = queue.get()
    queue.put(total_num_of_page)
    print '{} end.'.format(multiprocessing.current_process().name)
    print queue.qsize()


def get_page_element(page_queue, element_queue):
    while not page_queue.empty():
        data = page_queue.get()
        end_of_url = data[0]
        url = 'http://www.rong360.com/credit/youhui/' + data[0]
        img = data[1]
        discount_dict = detail_info.get_detail_info(url)
        discount_dict['end_of_url'] = end_of_url
        discount_dict['img'] = img
        discount_dict['classify'] = ''
        discount_dict['characteristic'] = ''
        element_queue.put(discount_dict)


def callback(x):
    print '{} end.'.format(multiprocessing.current_process().name)


if __name__ == '__main__':
    try:
        # get the number of total discount messages
        total_num_of_page = get_num_of_page('http://www.rong360.com/credit/f-youhui')
        total_num_of_page = 50
        print str(total_num_of_page)

        thread_num = 20  # num of process

        manager = multiprocessing.Manager()
        queue = manager.Queue()  # a queue storing index of url
        queue.put(20)             # Initialization of url index

        page_queue = manager.Queue()    # a queue storing end of urls

        # start multiprocess to get urls
        pool = Pool(thread_num)     
        for i in range(thread_num):
            pool.apply_async(get_page_url, args=(queue, total_num_of_page, page_queue))
        pool.close()
        pool.join()
        print 'num of total pages: ' + str(page_queue.qsize())

        store_data.remove_existed_url(page_queue)   # remove the urls that were already existed in the database
        print 'num of new pages: ' + str(page_queue.qsize())
        
        # start multiprocess to get the content of urls
        pool2 = Pool(thread_num)
        element_queue = manager.Queue()
        for i in range(thread_num):
            pool2.apply_async(get_page_element, args=(page_queue, element_queue), callback=callback)
        pool2.close()
        pool2.join()
        print 'num of pages(finally got): ' + str(element_queue.qsize())

        index = 0
        while not element_queue.empty():
            dicts = []
            for i in range(1):
                if not element_queue.empty():
                    dicts.append(element_queue.get())
                else:
                    break
            store_data.store_discount(dicts)
            
    except:
        print dicts
        log.record_error_to_logfile(traceback.format_exc())

