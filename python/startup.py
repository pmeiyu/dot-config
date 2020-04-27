import datetime
import functools
import itertools
import json
import os
import sys
import time
import urllib

from functools import reduce

try:
    import requests
except ImportError:
    pass
