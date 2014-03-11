all:
	-rm -r bin
	mkdir bin
	coffee -cbo bin coffee
	coffee -cbo bin nodejs_to_web

test:
	jasmine-node --coffee spec/

watch:
	jasmine-node --coffee spec/ --autotest --watch . --noStack

deploy: all
	mv bin/code.js 9481041/hashtag.js
