# org-searching.el
Searching Org-mode with search engines.

# Install #

- You can install this package through MELPA.

# Config #

## use-package ##

``` emacs-lisp
(use-package org-searching
  :ensure t
  :commands (org-searching-string org-searching-regexp org-searching-headlines)
  )
```

# Usage #

## Use Cases ##

If you organize your knowledge wiki with Org-mode, and store them in a
directory, you may want to search like this:

- search through all Org files for a specific thing with `[M-x org-searching-string]`.
- search all Org files under current path by specify `[C-u]`.
- search with regular expression with `[M-x org-searching-regexp]`.
- search only org-mode headlines for quick search (because most user define a
  short description with headline) with `[M-x org-searching-headlines]`.

