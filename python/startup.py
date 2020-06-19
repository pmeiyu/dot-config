import cProfile
import datetime
import functools
import http
import io
import itertools
import json
import os
import pdb
import sys
import time
import timeit
import trace
import tracemalloc
import urllib

from functools import reduce

try:
    import requests
except ImportError:
    pass
