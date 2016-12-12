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

- `[M-x org-searching-string]`
- `[M-x org-searching-regexp]`
- `[M-x org-searching-headlines]`
