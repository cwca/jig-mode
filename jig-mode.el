;;; jig-mode.el --- Major mode for the Jig programming language.  -*- lexical-binding: t -*-

;; Copyright (C) 2020 Chris Walsh.

;; Author: Chris Walsh
;;
;; Version: 0.1.0
;; Package-Version: 0.1.0
;; Package-Requires: ((emacs "25.1") (seq "2.3"))
;; Keywords: languages jig
;; URL: https://github.com/cwca/jig-mode
;;
;; This file is not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Major-mode for the Jig programming language.

;;; Code:

(defgroup paren-face nil
  "Face for parenthesis in lisp modes."
  :group 'font-lock-extra-types
  :group 'faces)

(defface parenthesis '((t (:inherit shadow)))
  "Face for parentheses."
  :group 'paren-face)

(defcustom paren-face-regexp "[][()]"
  "Regular expression to match parentheses."
  :type 'regexp
  :group 'paren-face)

(defcustom string-q1-face-regexp "[‘’]"
  "Regular expression to match parentheses."
  :type 'regexp
  :group 'string-face)

(setq jig-font-lock-keywords
      (let* (
             ;; define a few categories of keywords
             (x-keywords
              '("import" "use"
                
                "def" "defvar" "let" "var" "set" "as"
                "ƒn" "ƒm" "ƒs" "ƒa" "return" 
                "class" "struct" "enum" "union" "item"
                
                "if" "then" "else"
                "switch" "match" "case" "when" "default"
                "for" "in" "while" "do" "not-break?" "never-run?"
                "defer" "assert" 
                "break" "continue" "goto"
                "go" "select" "channel" "interface" "send" "receive"
                 ))
             (x-types
              '("Bool"
                
                "Int8" "Int16" "Int32" "Int64" "Int128" "IntBig"
                "Int" "IntSize" "Rune"
                
                "UInt" "UIntSize" "UInt8" "UInt16" "UInt32" "UInt64" "UInt128" "UIntBig"
                "UInt" "UIntSize"
                
                "Float16" "Float32" "Float64" "Float80" "FloatBig"
                "Float" "FloatLong"
                
                "Complex32" "Complex64" "Complex80" "ComplexBig"
                "Complex" "ComplexLong"

                "Any" "Array" "Channel" "Dictionary" "List" "Number"
                "Set" "Stack" "String" "Vector"

                "Char" "SChar" "UChar"
                "IntShort" "UIntShort" "IntLong" "UIntLong" "IntLongLong" "UIntLongLong"
                ))
             (x-constants
              '("true" "false" "nil"))
             (x-builtin
              '("not" "and" "or" "xor" "nand" "nor" "xnor"))
             (x-functions
              '("printn" "print" "input"))

             ;; generate regex string for each category of keywords
             (x-keywords-regexp (regexp-opt x-keywords 'words))
             (x-types-regexp (regexp-opt x-types 'words))
             (x-constants-regexp (regexp-opt x-constants 'words))
             (x-builtin-regexp (regexp-opt x-builtin 'words))
             (x-functions-regexp (regexp-opt x-functions 'words))
             )

        `(
          (,"(\\#[\0-\377[:nonascii:]]*?\\#)" . font-lock-comment-face)
          (,"«««\[\0-\377[:nonascii:]]*?\»»»" . font-lock-string-face)
          (,"#.*" . font-lock-comment-face)
          (,"‘.*’" . font-lock-string-face)
          (,"“.*”" . font-lock-string-face)
          (,"«.*»" . font-lock-string-face)
          (,x-types-regexp . font-lock-type-face)
          (,x-constants-regexp . font-lock-constant-face)
          (,x-builtin-regexp . font-lock-builtin-face)
          (,x-functions-regexp . font-lock-function-name-face)
          (,x-keywords-regexp . font-lock-keyword-face)
          )))

;;; REGEXP syntax
;;; https://www.emacswiki.org/emacs/RegularExpression

;;;###autoload
(add-to-list 'auto-mode-alist (cons "\\.jig\\'" 'jig-mode))

;;;###autoload
(define-derived-mode jig-mode prog-mode "Jig"
  "Major mode for editing Jig source text."

  ;; Font lock
  (set (make-local-variable 'font-lock-defaults)
       '(jig-font-lock-keywords))
  
  )

(provide 'jig-mode)

;;; jig-mode.el ends here
