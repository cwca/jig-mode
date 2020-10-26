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

(setq jig-font-lock-keywords
      (let* (
             ;; define a few categories of keywords
             (x-keywords
              '("import" "use"
                "def" "let" "var" "set"
                "function" "method" "signature" "ƒ" "return"
                "if" "else"
                "for" "in" "while" "then" "continue" "break" "not-break?" "never-run?"
                "match" "switch" "with" "when" "default"
                "go" "select" "channel" "interface" "send" "receive"
                "class" "struct" "enum" "union" "item"
                "defer" "assert" "goto" ))
             (x-types
              '("Int" "Int8" "Int16" "Int32" "Int64" "Int128" "Int256"
                "UInt" "UInt8" "UInt16" "UInt32" "UInt64" "UInt128" "UInt256"
                "IntShort" "IntLong" "IntLongLong"
                "UIntShort" "UIntLong" "UIntLongLong"
                "Bool" "Bit"
                "CChar" "UCChar" "SCChar"
                "IntPtr" "UIntPtr" "IntPtrDiff" "UIntSize"
                "Float16" "Float32" "Float64" "Float80" "Float96" "Float128" "FloatLong"
                "Complex32" "Complex64" "Complex80" "Complex96" "Complex128" "ComplexLong"

                "IntBig" "FloatBig"

                "Any" "Array" "Base" "CString" "Channel" "Dictionary" "ForwardList"
                "List" "Number" "Set" "Stack" "String" "Vector"
                
                "Function" "Signature"   
                ))
             (x-constants
              '("true" "false" "nil"))
             (x-builtin
              '("not" "and" "or" "xor" "nand" "nor" "xnor"))
             (x-functions
              '("print-line" "print" "input"))

             ;; generate regex string for each category of keywords
             (x-keywords-regexp (regexp-opt x-keywords 'words))
             (x-types-regexp (regexp-opt x-types 'words))
             (x-constants-regexp (regexp-opt x-constants 'words))
             (x-builtin-regexp (regexp-opt x-builtin 'words))
             (x-functions-regexp (regexp-opt x-functions 'words))
             )

        `(
          ("(\\#[\0-\377[:nonascii:]]*?\\#)" . font-lock-comment-face)
          ("#.+" . font-lock-comment-face)
          ;(,paren-face-regexp . 'parenthesis)   ;; turn on if want to de-emphasise parens
          (,x-types-regexp . font-lock-type-face)
          (,x-constants-regexp . font-lock-constant-face)
          (,x-builtin-regexp . font-lock-builtin-face)
          (,x-functions-regexp . font-lock-function-name-face)
          (,x-keywords-regexp . font-lock-keyword-face)
          )))

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
