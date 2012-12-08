Strainer
========

Strainer is a jQuery plugin for filtering DOM elements based on the contents of a text input.

Demo
----

Check out the live demo at [zeke.github.com/jquery.strainer](http://zeke.github.com/jquery.strainer/)
or clone it and open it yourself...

```bash
git clone git://github.com/zeke/jquery.strainer.git
open jquery.strainer/demo.html
```

How It Works
------------

As you enter text into your input, a `match` class is applied to all elements that 
match the string, and removed from all elements that don't. It's up to you to use
CSS to determine what a match looks like.

Strainer is case insensitive and supports multi-word searches. 
`cat` matches `Catherine`, `wildcat`, and `scattergories`.
`mi fa` matches `Mia Farrow` and `fancy mingling`, but not `minimalism`.

Installation
------------

```bash
curl -O https://raw.github.com/zeke/jquery.strainer/master/jquery.strainer.js 
```
    
Usage
-----

```css
  ul.things > li { display: none; }
  ul.things > li.match { display: block; }
```

```js
$(function() {
  
  // Minimal
  $('input.strainer').strainer({selector: "ul.things > li"});
  
  // Bells and Whistles
  $('input.strainer').strainer({
    selector: "ul.things > li",
    mode: "additive",
    minChars: 3,
    onStrain: function(matches) {
      console.log(matches.length);
    }
  });
  
});
```

### Options

- `selector`: The only required option; a CSS selector string like `'ul.things > li'`
- `mode`: `reductive` (default) shows everything until you start filtering. `additive` shows nothing until you start filtering.
- `minChars`: The minimum number of characters required before filtering is performed. Default: `1`
- `onStrain`: An optional callback function to which a jQuery collection of matched elements will be passed every time filtering occurs.

Key-Value Matching
------------------

Strainer allows you to search against HTML5 data attributes using a 
`key:value` search syntax.

```html
<li data-emotion="happy">I feel good.</li>
<li data-emotion="happy">I feel great.</li>
<li data-emotion="elated">I feel wonderful.</li>
```

The following search patterns are supported:

```
emotion:happy good
emotion:sad
emotion:happy,sad
```

Development
-----------

Use coffee to watch and compile...

```bash
coffee -wc *.coffee
```

License
-------

MIT. Go Nuts.

Created by @zeke