# Zkbl

This is, in essence, a bunch of code that makes [zKillboard](https://zkillboard.com) more usable and makes things
easier to find.

### What it does / will do:

Zkbl implements a LISP-like language that serves as query and analysis constructor for Zkb. The end goal is to have
something like this:

```clojure
(losses
  (group :CFC)
  (shiptype :battleship)
  (region :delve))
```

And have Zkbl give you all the battleship losses of the alliances associated with the CFC in Delve. There are going
to be a bunch of functions more, like value limiters and all sorts of filters.

### But Az, what does it do right now?

```clojure
(kill 55403284)
```
... You're welcome. 