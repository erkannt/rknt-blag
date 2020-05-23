img:
	cp -r src/img static/
	find ./static -name '*.jpg' -execdir sh -c "mogrify -resize 1000x1000> *.jpg" {} \;

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
