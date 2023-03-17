;;; org-settings.el --- Org Settings                   -*- lexical-binding: t; -*-

;; Copyright (C) 2018  Nasy

;; Author: Nasy <nasyxx@gmail.com>
;; Keywords: tools, tex

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; collections.org to tex settings.

;;; Code:

(setq org-latex-compiler "xelatex"
      org-latex-default-packages-alist nil
      org-latex-default-table-environment "longtable"
      org-latex-pdf-process
      (quote
       ("xelatex -shell-escape -interaction nonstopmode %f"
        "xelatex -shell-escape -interaction nonstopmode %f"))
      org-latex-tables-booktabs t
      org-html-validation-link nil
      org-html-checkbox-type   'html
      org-html-doctype         "html5"
      org-html-html5-fancy     t
      org-html-klipsify-src    t
      org-html-mathjax-options '((path "https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/latest.js?config=TeX-AMS-MML_HTMLorMML")
                                 (scale "100")
                                 (align "center")
                                 (font "Neo-Euler")
                                 (linebreaks "false")
                                 (autonumber "AMS")
                                 (indent "0em")
                                 (multlinewidth "85%")
                                 (tagindent ".8em")
                                 (tagside "right"))
      org-html-use-infojs      nil
      org-html-with-latex      (quote mathjax))


;; Borrowed from spacemacs chinese layer.
(defadvice org-html-paragraph (before org-html-paragraph-advice
                                      (paragraph contents info) activate)
  "Join consecutive Chinese lines into a single long line without
unwanted space when exporting org-mode to html."
  (let* ((origin-contents (ad-get-arg 1))
         (fix-regexp "[[:multibyte:]]")
         (fixed-contents
          (replace-regexp-in-string
           (concat
            "\\(" fix-regexp "\\) *\n *\\(" fix-regexp "\\)") "\\1\\2" origin-contents)))
    (ad-set-arg 1 fixed-contents)))

;; Custom date format
(setq-default org-display-custom-times t)
;;; Before you ask: No, removing the <> here doesn't work.
(setq org-time-stamp-custom-formats
      '("%Y 年 %b 月 %d 日" . "<%d/%m/%y %a %H:%M>"))


(provide 'org-settings.el)
;;; org-settings.el ends here
