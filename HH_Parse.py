# -*- coding: utf-8 -*-
"""
Created on Fri Sep 23 15:28:46 2022

@author: vlasenko
"""

from bs4 import BeautifulSoup
import requests
import re

def is_palindrome(s:str='taco cat'):
    """ Функция проверки строки на палиндром """
    s=s.lower()
    s=re.sub('[^a-z0-9а-яё]','',s)
    #s=str(s).replace(' ','')
    return s == s[::-1]

