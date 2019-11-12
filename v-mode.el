;;; v-mode.el --- Major mode for the V programming language.

;; Copyright (C) 2019 by Zajcev Evgeny.

;; Author: Zajcev Evgeny <zevlg@yandex.ru>
;; Created: Fri Jun 21 17:59:25 2019
;; Keywords: languages
;; Homepage: https://github.com/zevlg/v-mode.el
;; Package-Requires: ((emacs "25.1"))
;; Version: 0.1.0
(defconst v-mode-version "0.1.0")

;; This file is NOT part of GNU Emacs.

;;; License:

;; v-mode.el is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; v-mode.el is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this file.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; 

;;; Code:

(defun v--regexp-opt (strings &optional paren)
  "Emacs 23 provides `regexp-opt', but it does not support PAREN taking the value 'symbols.
This function provides equivalent functionality, but makes no efforts to optimise the regexp."
  (cond
   ((>= emacs-major-version 24)
    (regexp-opt strings paren))
   ((not (eq paren 'symbols))
    (regexp-opt strings paren))
   ((null strings)
    "")
   ('t
    (rx-to-string `(seq symbol-start (or ,@strings) symbol-end)))))

(defconst v-keywords-regex
  (v--regexp-opt
   '("break"  "const"  "continue" "defer" "else"   "enum"   "fn"
     "for"    "go"     "goto"     "if"    "import" "in"     "interface"
     "match"  "module" "mut"      "none"  "or"     "pub"    "return"
     "struct" "type")
   'symbols))

;;(defconst v-function-regex
;;  (rx line-start (* (or space "pub")) symbol-start
;;      "fn" (1+ space)
;;      (group (or word (syntax symbol)))))

(defconst v-builtin-types-regex
  (v--regexp-opt
   '("bool" "string"
     "i8"   "i16" "int" "i64" "i128"
     "byte" "u16" "u32" "u64" "u128"
     "rune"
     "f32" "f64"
     "byteptr"
     "voidptr")
   'symbols))

(defconst v-mode-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?' "\"" table)
    (modify-syntax-entry ?\" "\"" table)

    (modify-syntax-entry ?+ "." table)
    (modify-syntax-entry ?- "." table)
    (modify-syntax-entry ?* "." table)
    (modify-syntax-entry ?/ "." table)
    (modify-syntax-entry ?% "." table)
    (modify-syntax-entry ?= "." table)
    (modify-syntax-entry ?< "." table)
    (modify-syntax-entry ?> "." table)

    (modify-syntax-entry ?\( "()" table)
    (modify-syntax-entry ?\) ")(" table)
    (modify-syntax-entry ?\{ "(}" table)
    (modify-syntax-entry ?\} "){" table)
    (modify-syntax-entry ?\[ "(]" table)
    (modify-syntax-entry ?\] ")[" table)

    ;(modify-syntax-entry ?\n ">" table)

    table))

(defconst v-builtin-regex
  (v--regexp-opt
   '()
   'symbols))

(defconst v-font-lock-keywords
  (list
;;   (list v-quoted-symbol-regex 1 ''julia-quoted-symbol-face)
   (cons v-builtin-types-regex 'font-lock-type-face)
   (cons v-keywords-regex 'font-lock-keyword-face)
;;   (list v-unquote-regex 2 'font-lock-constant-face)
;;   (list v-forloop-in-regex 1 'font-lock-keyword-face)
;;   (list v-function-regex 1 'font-lock-function-name-face)
;;   (list v-function-assignment-regex 1 'font-lock-function-name-face)
   (list v-builtin-regex 1 'font-lock-builtin-face)
   ))

(defalias 'v-mode-prog-mode
  (if (fboundp 'prog-mode)
      'prog-mode
    'fundamental-mode))

(define-derived-mode v-mode v-mode-prog-mode "Vlang"
  (set-syntax-table v-mode-syntax-table)
  (set (make-local-variable 'font-lock-defaults) '(julia-font-lock-keywords))
  ;;  (font-lock-fontify-buffer))
  )

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.v\\'" . v-mode))

(provide 'v-mode)

;;; v-mode.el ends here
