# How to build/watch

```
cp -r src/img static/ && imageoptim static/img
minify -w -r src/ -o static/
hugo server
```

## Requires

- hugo
- minify
- imageoptim
- imageoptim-cli 