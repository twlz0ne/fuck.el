;;; fuck.el --- Punctuation replacing -*- lexical-binding: t; -*-

;; Copyright (C) 2019 Gong Qijian <gongqijian@gmail.com>

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

;;; Code:

(require 'ert)
(require 'fuck)

(defun test-fuck--insert| (string)
  (insert string)
  (re-search-backward "|")
  (delete-char 1))

(defun test-fuck--fuck-off (string)
  (with-temp-buffer
    (test-fuck--insert| string)
    (fuck)
    (insert "|")
    (buffer-string)))

(ert-deftest test-fuck-1 () (should (equal (test-fuck--fuck-off "a《|》b") "a<|>b")))
(ert-deftest test-fuck-2 () (should (equal (test-fuck--fuck-off "a《》|b") "a<>|b")))
(ert-deftest test-fuck-3 () (should (equal (test-fuck--fuck-off "a《|b")   "a<|b")))
(ert-deftest test-fuck-4 () (should (equal (test-fuck--fuck-off "a》|b")   "a>|b")))
(ert-deftest test-fuck-5 () (should (equal (test-fuck--fuck-off "a，|b")   "a,|b")))
(ert-deftest test-fuck-6 () (should (equal (test-fuck--fuck-off "a，|，b") "a,|，b")))

;;; test-fuck.el ends here
