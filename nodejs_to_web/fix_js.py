import os.path
import re
import sys

js_file = open('9481041/hashtag.js', 'r')
js_content = js_file.read()
js_file.close()

js_content = re.sub(r'// Generated by CoffeeScript[ \d.]*\n', '', js_content)
js_content = re.sub(r'global.main =', 'var main =', js_content)
js_content = re.sub(r'global.main', 'main', js_content)
js_content = re.sub(r'\sthis\.', ' main.', js_content)

js_file = open('9481041/hashtag.js', 'w')
js_file.write(js_content)
js_file.close()
