# How to build/watch

To rebuild on change, run in two terminal:
```
find ./src | entr make assets
hugo server
```

Builds static site:
```
make public
```

## Requires

- hugo
- minify
- imagemagick
