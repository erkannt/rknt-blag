img:
	cp -r src/img static/

css:
	cp -r src/css static/

js:
	cp -r src/js static/

assets: css js img

public: assets
	hugo

clean:
	rm -r static
	rm -r public
