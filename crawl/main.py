# !/usr/bin/python
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


def get_page_url(queue, total_num_of_page, page_queue, url_addition_info):
    p_num = queue.get()
    while p_num < total_num_of_page:
        p_num += 1
        queue.put(p_num)
        print multiprocessing.current_process().name + 'processing: ' + str(p_num)
        url = 'http://www.rong360.com/credit/f-youhui' + url_addition_info + '-p' + str(p_num)
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


def get_classify():
    classify = {"type1": "美食", "type2": "休闲娱乐",  "type4-sub_type1": "酒店",  "type5": "购物",  "type6": "办卡送礼",
                "type7": "旅游",  "type9": "汽车",  "type10": "时尚丽人",  "type11": "生活服务",
                "type4-sub_type2": "出行", "type4-sub_type3": "出行"}
    for name in classify:
        total_num_of_page = get_num_of_page('http://www.rong360.com/credit/f-youhui-' + name)
        print classify[name] + ": " + str(total_num_of_page)
        thread_num = 20  # num of process
        section_size = 50
        section = total_num_of_page / section_size
        if total_num_of_page % section_size > 0:
            section += 1

        for k in range(section):
            begin = k * section_size + 1
            end = begin + section_size - 1
            end = min(end, total_num_of_page)
            print "start to get summary pages from " + str(begin) + " to " + str(end) + \
                  ", each summary page contains 20 detail content pages."
            manager = multiprocessing.Manager()
            queue = manager.Queue()  # a queue storing index of url
            queue.put(begin - 1)  # Initialization of url index

            page_queue = manager.Queue()  # a queue storing end of urls

            # start multiprocess to get urls
            pool = Pool(thread_num)
            for i in range(thread_num):
                pool.apply_async(get_page_url, args=(queue, end, page_queue, '-' + name))
            pool.close()
            pool.join()
            print 'num of total pages: ' + str(page_queue.qsize())

            store_data.insert_column("classify", classify[name], page_queue)


if __name__ == '__main__':
    try:
        # get the number of total discount messages
        total_num_of_page = get_num_of_page('http://www.rong360.com/credit/f-youhui')
        print str(total_num_of_page)
        thread_num = 20  # num of process

        section_size = 50
        section = total_num_of_page / section_size
        if total_num_of_page % section_size > 0:
            section += 1

        for k in range(section):
            begin = k * section_size + 1
            end = begin + section_size - 1
            print "start to get summary pages from " + str(begin) + " to " + str(end) +\
                  ", each summary page contains 20 detail content pages."
            manager = multiprocessing.Manager()
            queue = manager.Queue()  # a queue storing index of url
            queue.put(begin - 1)  # Initialization of url index

            page_queue = manager.Queue()  # a queue storing end of urls

            # start multiprocess to get urls
            pool = Pool(thread_num)
            for i in range(thread_num):
                pool.apply_async(get_page_url, args=(queue, end, page_queue, ''))
            pool.close()
            pool.join()
            print 'num of total pages: ' + str(page_queue.qsize())

            store_data.remove_existed_url(page_queue)  # remove the urls that were already existed in the database
            num_of_new_pages = page_queue.qsize()
            print 'num of new pages: ' + str(num_of_new_pages)

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
                insert_size = 20
                for i in range(insert_size):
                    if not element_queue.empty():
                        dicts.append(element_queue.get())
                    else:
                        break
                store_data.store_discount(dicts)

            print 'pages: ' + str(begin) + ' - ' + str(end) + ' finished.'
        get_classify()
    except:
        log.record_error_to_logfile(traceback.format_exc())

