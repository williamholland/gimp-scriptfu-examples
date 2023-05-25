# Developing

The language used is [Tiny-Fu](http://www.ve3syb.ca/software/tiny-fu/). This
implements [this
spec of R5RS Scheme](https://conservatory.scheme.org/schemers/Documents/Standards/R5RS/r5rs.pdf)
and the pdf is a good reference. One quick way to test R5RS Scheme outside of GIMP is in DrRacket by using the language header `#!r5rs` like below

```
#!r5rs

(display "hi!")
```

To find detailed reference for gimp functions go to `Filters>Script-Fu>Console>Browse`.

There are also some functions from TSX (TinyScheme eXtensions) which is
[documented
here](https://github.com/mherasg/tsx/blob/master/tsx-functions.txt). e.g.
`file-exists`, `getenv` and `time`

The regex interface doesn't seem to be documented anywhere but reading the .h
file I _think_ it only exposes `re-match`, which you can learn to use by
looking at the example included here.

## Debugging

To see debug messages do the following (it only works with strings):
```
(gimp-message "foo")
```

## Console

There is a Scheme REPL in GIMP by going to `Filters>Script-Fu>Console`. It's quite hard to work with because most functions need image or drawable IDs. Here is a list of useful procedures when using the console

```
(gimp-image-list) ; see current images
(gimp-image-get-layers <id>) ; see the top-level layers of the current image (you won't see ids of ones inside groups)
(gimp-item-get-children <id>) ; see the children when you have an id of a group
```

## Testing Checklist

* does it work when no image is open?
* does it work when the image has not yet been saved?

##  Best Practices Checklist

* are images/drawables in memory deleted when not needed?

## Gotchas

* most GIMP functions return a list, even if you're only expecting one return
  value so if something isn't working as expected try wrapping it in `car`

# Installation

For me scripts need to go into 

* `~/.config/GIMP/2.10/scripts/`
* or on windows `C:\Users\%username%\AppData\Roaming\GIMP\2.10\scripts`

In general you can find out by going to Edit>Preferences>Folders>Scripts
