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

(defconst v-mode-keywords
  '("break"  "const"  "continue" "defer" "else"   "enum"   "fn"
    "for"    "go"     "goto"     "if"    "import" "in"     "interface"
    "match"  "module" "mut"      "none"  "or"     "pub"    "return"
    "struct" "type")
  "V language keywords. See https://vlang.io/docs#keywords")

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

(define-derived-mode v-mode prog-mode "vlang"
  :syntax-table v-mode-syntax-table
  (font-lock-fontify-buffer))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.v\\'" . v-mode))

(provide 'v-mode)

;;; v-mode.el ends here
