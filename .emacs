;; File Name: .emacs
;; Purpose: Configure the Emacs environment
;; Creation Date: Tue Feb 16 11:26:59 CST 2016
;; Last Modified: Sun Feb 26 21:54:17 CST 2017
;; Created By: Ivan Guerra <Ivan.E.Guerra-1@ou.edu>

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom-set-variables set from within the editor itself (i.e., these were auto-generated)

(custom-set-variables
 '(TeX-source-correlate-method (quote synctex))
 '(TeX-source-correlate-mode t)
 '(TeX-source-correlate-start-server t)
 '(TeX-view-program-list (quote (("apvlv" ("apvlv %o") "apvlv"))))
 '(TeX-view-program-selection
   (quote
    (((output-dvi has-no-display-manager)
      "dvi2tty")
     ((output-dvi style-pstricks)
      "dvips and gv")
     (output-dvi "xdvi")
     (output-pdf "apvlv")
     (output-html "xdg-open"))))
 '(menu-bar-mode nil)
 '(package-selected-packages
   (quote
    (sr-speedbar iedit header2 elpy auto-complete auctex)))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(tooltip-mode nil))
(custom-set-faces)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set basic Emacs features and load packages

(global-linum-mode t)               ;; enable line numbering
(setq inhibit-startup-message t)    ;; disable the GNU emacs startup message
(setq make-backup-files nil)        ;; stop creating backup~ files
(setq auto-save-default nil)        ;; stop creating #autosave# files
(add-to-list 'load-path "~/.elisp") ;; make all *.el files visible on the load-path
(setq-default cursor-type 'hbar)    ;; make the cursor an '_' symbol
(require 'soft-stone-theme)

;; Load MELPA packages if using Emacs version 24 or greater
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
  (package-initialize))

;; Load Elpy for easy Python editing
(require 'package)
(add-to-list 'package-archives
             '("elpy" .
               "http://jorgenschaefer.github.io/packages/"))
(package-initialize)
(elpy-enable)

;; Load auto completion
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)

;; Load Yasnippet
(require 'yasnippet)
(yas-global-mode 1)

;; Load iedit and set it to exit on RET
(require 'iedit)
(defun quit-iedit-mode ()
  "Turn off iedit-mode."
  (interactive)
  (iedit-mode -1))
(define-key iedit-mode-keymap (kbd "RET") 'quit-iedit-mode)

;; Load semantic
(semantic-mode 1)
(global-semantic-idle-scheduler-mode 1)
(defun add-semantic-to-autocomplete()
  (add-to-list 'ac-sources 'ac-source-semantic)
  )
(add-hook 'c-mode-common-hook 'add-semantic-to-autocomplete)

;; Load header2 for automatic source header insertions
(require 'header2)

;; Insert header automatically depending on file mode
(autoload 'auto-make-header "header2")
(add-hook 'c-mode-common-hook 'auto-make-header)

;; Update file headers automatically on save
(autoload 'auto-update-file-header "header2")
(add-hook 'write-file-hooks 'auto-update-file-header)

(defsubst my/header-dash-line ()
  (insert header-prefix-string)
  (insert-char ?= fill-column)
  (insert "\n"))

(defsubst my/header-author ()
  (insert header-prefix-string "Author: Ivan Guerra <Ivan.E.Guerra-1@ou.edu>\n"))

(setq make-header-hook '(my/header-dash-line
                         header-file-name
                         header-description
                         header-creation-date
                         header-modification-date
                         my/header-author
                         my/header-dash-line))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Language specific configurations

;; C/C++
(setq c-default-style "linux"
      c-basic-offset 4
      tab-width 4
      indent-tabs-mode t)

;; LaTex
(setq TeX-parse-self t)  ;; allow AUCTeX to parse the current open document

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set some useful key mappings

(global-set-key (kbd "C-c d") 'insert-current-date-time)
(global-set-key (kbd "C-c e") 'untabify)
(global-set-key (kbd "C-c w") 'delete-trailing-whitespace)


;; Format variable for the current date and time used in 'insert-current-date-time'
(defvar current-date-time-format "%a %b %d %H:%M:%S %Z %Y")

;; Insert the current date and time into the current buffer using 'current-date-time-format' for the formatting
(defun insert-current-date-time ()
  (interactive)
  (insert (format-time-string current-date-time-format (current-time)))
  )
