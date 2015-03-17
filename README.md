# Transmarkdownifier

I've decided that none of the [existing million kinds of markdown editors](http://mashable.com/2013/06/24/markdown-tools/) out there are any good for me to write my design docs on. So I'm creating my own here using [Github's Markup project](github/markup).

## Usage

1. `cp transmarkdownify ~/bin`
2. Make sure your `~/bin` is in your PATH
3. `transmarkdownify functional-specs.md`
4. `transmarkdownify` will generate a `functional-specs.html` file and open it in your browser
5. Print to pdf from your browser

## Transmarkdownification is a new technology

Ideally, I guess I want something like [Mou](http://25.io/mou) that will export pretty Github-styled pdfs. And also parse `<br>` tags (so I can add custom line breaks to reflow pages properly).

Till then this is where I'm at with it.

![](http://assets.amuniversal.com/8d40c700deba01317193005056a9545d)
![](http://assets.amuniversal.com/8e9507d0deba01317193005056a9545d)
![](http://assets.amuniversal.com/9446da50deba01317193005056a9545d)
