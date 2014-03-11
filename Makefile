all:
	-rm -r bin
	mkdir bin
	coffee -cbo bin coffee

test:
	jasmine-node --coffee spec/

watch:
	jasmine-node --coffee spec/ --autotest --watch . --noStack

deploy: all
	mv bin/main.js 9481041/hashtag.js
	python nodejs_to_web/fix_js.py
	cd 9481041
	git commit -am "updating with latest code"
	git push
	cd ..
