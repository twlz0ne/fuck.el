# fuck.el [![Build Status](https://travis-ci.com/twlz0ne/fuck.el.svg?branch=master)](https://travis-ci.com/twlz0ne/fuck.el)

Convert full-width/half-width punctuations before or around point.
This project was inspired by [thefuck](https://github.com/nvbn/thefuck).

## Installation

Clone this repository to `~/.emacs.d/site-lisp/fuck`. Add the following to your `.emacs`:

```elisp
(require 'fuck)
```

## Usage

#### `M-x fuck RET`

```
《|》                <|>
《》|                <>|
《|         =>       <|
》|                  >|
，|                  ,|
```
