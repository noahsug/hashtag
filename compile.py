import os.path
import sys

template_file = open('template.html', 'r')
template_content = template_file.read()
template_file.close();

js_file = open('code.js', 'r')
js_content = js_file.read()
js_file.close();

html_file = open('index.html', 'w')

js_content = js_content.replace('\n', '');
html_content = template_content.replace('$CODE$', js_content);
html_file.write(html_content);

html_file.close();
