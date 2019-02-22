#!/bin/sh

cp -r src/img static/
find ./static -name '*.jpg' -execdir sh -c "mogrify -resize 1000x1000 *.jpg" {} \;
imageoptim static/img
