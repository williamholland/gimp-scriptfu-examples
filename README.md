# Developing

The language used is [Tiny-Fu](http://www.ve3syb.ca/software/tiny-fu/). This
implements [this
spec](https://conservatory.scheme.org/schemers/Documents/Standards/R5RS/r5rs.pdf)
and the pdf is a good reference.

To find detailed reference for gimp functions go to `Filters>Script-Fu>Console>Browse`.

There are also some functions from TSX (TinyScheme eXtensions) which is
[documented
here](https://github.com/mherasg/tsx/blob/master/tsx-functions.txt). e.g.
`file-exists`, `getenv` and `time`

The regex interface doesn't seem to be documented anywhere but reading the .h
file I _think_ it only exposes `re-match`, which you can learn to use by
looking at the example included here.

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
