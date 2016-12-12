;;; org-searching.el --- Searching Org-mode files with search engines.
;;; -*- coding: utf-8 -*-

;; Author: stardiviner <numbchild@gmail.com>
;; Maintainer: stardiviner <numbchild@gmail.com>
;; Keywords: org search
;; URL: https://github.com/stardiviner/org-searching.el
;; Created: 12th Dec 2016
;; Version: 0.1.0
;; Package-Requires: ((emacs "24.3") (ag "0.48"))

;;; Commentary:

;;; Code:
;;; ----------------------------------------------------------------------------
;; load function `ag/read-from-minibuffer', `ag/search'
(require 'ag)

(defgroup org-searching nil
  "Org files searching.")

(defcustom org-searching-org-root-path "~/Org"
  "The default root path of your Org-mode files."
  :type 'string
  :group 'org-searching)

(defcustom org-searching-search-engine 'ag
  "Specify the search engine for searching.

The search engines can be: ag, pt, ripgrep, grep, ack."
  :type 'symbol
  :group 'org-searching)


;;;###autoload
(defun org-searching-string (string directory)
  "Full context searching STRING using ag in a given DIRECTORY.

By default STRING is the symbol under point unless called with a
prefix, prompts for flags to pass to ag."
  (interactive
   (list
    (read-from-minibuffer "Search string in Org:" (thing-at-point 'symbol))
    (read-directory-name "Directory: " (expand-file-name "~/Org"))
    ))
  
  (case org-searching-search-engine
    ('ag
     ;; (ag/search string directory :regexp nil :file-type 'org)
     (ag/search string directory
                :regexp nil :file-regex ".*\.org"))
    ('pt
     (pt-regexp string directory))
    ('ripgrep
     (ripgrep-regexp string directory))
    )
  )

;;;###autoload
(defun org-searching-regexp (regexp directory)
  "Full context searching REGEXP using ag in a given DIRECTORY.

By default REGEXP is the symbol under point unless called with a
prefix, prompts for flags to pass to ag."
  (interactive
   (list
    (read-from-minibuffer "Search regexp in Org:" (thing-at-point 'symbol))
    (read-directory-name "Directory: " (expand-file-name "~/Org"))
    ))
  
  (case org-searching-search-engine
    ('ag
     (ag/search regexp directory
                :regexp nil :file-regex ".*\.org"))
    ('pt
     (pt-regexp regexp directory))
    ('ripgrep
     (ripgrep-regexp regexp directory))
    )
  )

;;;###autoload
(defun org-searching-headlines (string directory)
  "Search STRING in Org files headlines using ag in a given DIRECTORY.

By default STRING is the symbol under point unless called with a
prefix, prompts for flags to pass to ag."
  (interactive
   (list
    (read-from-minibuffer "Search headlines in Org:" (thing-at-point 'symbol))
    (read-directory-name "Directory: "
                         (expand-file-name (if current-prefix-arg "~/Org" ".")))
    ))
  
  (case org-searching-search-engine
    ('ag
     (ag/search (concat "^(\\*)+\ .*" string) directory
                :regexp t :file-regex ".*\.org"))
    ('pt
     (pt-regexp (concat "^(\\*)+\ .*" string) directory))
    ('ripgrep
     (ripgrep-regexp (concat "^(\\*)+\ .*" string) directory))
    ;; TODO
    ;; ('grep
    ;;  (rgrep (concat "^(\\*)+\ .*" string) org directory))
    ;; TODO
    ;; ('ack
    ;;  (ack))
    )
  
  ;; the real shell command and regexp result:
  ;; ag --file-search-regex .\*.org --group --line-number --column --color --color-match 30\;43 --color-path 1\;32 --smart-case --stats -- \^\(\\\*\)\+.\*time .
  )

;;; ----------------------------------------------------------------------------

(provide 'org-searching)

;;; org-searching.el ends here
