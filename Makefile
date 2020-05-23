img:
	cp -r src/img static/
	find ./static -name '*.jpg' -execdir sh -c "mogrify -resize 1000x1000> *.jpg" {} \;

css:
	minify -r src/css/ -o static/css/

js:
	minify -r src/js/ -o static/js/

assets: css js img

public: assets
	hugo

clean:
	rm -r static
	rm -r public
