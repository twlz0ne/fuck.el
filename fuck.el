;;; fuck.el --- Punctuation replacing -*- lexical-binding: t; -*-

;; Copyright (C) 2019 Gong Qijian <gongqijian@gmail.com>

;; Author: Gong Qijian <gongqijian@gmail.com>
;; Created: 2019/03/25
;; Version: 0.1.0
;; Package-Requires: ((emacs "24.4"))
;; URL: https://github.com/twlz0ne/fuck
;; Keywords: convenience

;; This program is free software; you can redistribute it and/or modify
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

;; Convert full-width/half-width panctuations before or around point.

;;; Change Log:

;;  0.1.0  2019/03/25  Initial version.

;;; Code:

(defvar fuck-paires
  '(("，" . ",")
    ("。" . ".")
    ("；" . ";")
    ("：" . ":")
    ("、" . "\\")
    ("／" . "/")
    ("！" . "!")
    ("｜" . "|")
    ;;
    ("【" . (:replace "["  :next-fn looking-at ))
    ("】" . (:replace "]"  :next-fn looking-back))
    ("（" . (:replace "("  :next-fn looking-at ))
    ("）" . (:replace ")"  :next-fn looking-back))
    ("《" . (:replace "<"  :next-fn looking-at ))
    ("》" . (:replace ">"  :next-fn looking-back))
    ("‘"  . (:replace "'"  :next-fn looking-at ))
    ("’"  . (:replace "'"  :next-fn looking-back))
    ("“"  . (:replace "\"" :next-fn looking-at ))
    ("”"  . (:replace "\"" :next-fn looking-back))
    ;;
    ("["  . (:replace "【" :next-fn looking-at ))
    ("]"  . (:replace "】" :next-fn looking-back))
    ("("  . (:replace "（" :next-fn looking-at ))
    (")"  . (:replace "）" :next-fn looking-back))
    ("<"  . (:replace "《" :next-fn looking-at ))
    (">"  . (:replace "》" :next-fn looking-back))
    ;;
    ("'"  . (:replace ("‘" . "’") :next-fn looking-at))
    ("\"" . (:replace ("“" . "”") :next-fn looking-at))))

(defun fuck--convert-punctuations (&optional looking-fn looking-next-p)
  "Convert full-width/half-width panctuations before or around point.

if LOOKING-FN can be `looking-back' (default) or `looking-at'.
if LOOKING-NEXT-P is not nil, stop looking next."
  (when (funcall (or looking-fn 'looking-back) "\\s-*\\([[:punct:]]\\)\\s-*")
    (let ((replace (cdr (assoc (match-string-no-properties 1) fuck-paires))))
      (when replace
        (save-excursion
          (if (listp replace)
              (let ((replace-char (plist-get replace :replace)))
                (if (listp replace-char)
                    (if looking-next-p
                        (replace-match (cdr replace-char) nil nil nil 1)
                      (replace-match (car replace-char) nil nil nil 1))
                  (replace-match replace-char nil nil nil 1))
                (unless looking-next-p
                  (pcase replace
                    (`(:replace ,_ :next-fn looking-back)
                     (save-excursion
                       (goto-char (match-beginning 1))
                       (fuck--convert-punctuations 'looking-back t)))
                    (`(:replace ,_ :next-fn looking-at)
                     (save-excursion
                       (fuck--convert-punctuations 'looking-at t))))))
            (replace-match replace nil nil nil 1)))))))

(defun fuck ()
  (interactive)
  (fuck--convert-punctuations 'looking-back))

(provide 'fuck)

;;; fuck.el ends here
