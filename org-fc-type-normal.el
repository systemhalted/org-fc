;;; org-fc-type-normal.el --- Normal card type -*- lexical-binding: t; -*-

;; Copyright (C) 2020  Leon Rische

;; Author: Leon Rische <emacs@leonrische.me>

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
;;
;; Most basic card type, showing the front of a card, either the
;; heading (for compact cards) and revealing the content, or showing
;; the contents of a heading, then expanding the "Back" subheading.
;;
;;; Code:

(defun org-fc-type-normal-init ()
  "Initialize a heading as a normal card."
  (interactive)
  (org-fc--init-card "normal")
  (org-fc-review-data-update '("front")))

(defvar org-fc-type-normal--hidden '()
  "List of all hidden headings of a normal card.")

(defun org-fc-type-normal-setup (_position)
  "Set up a normal card for review."
  (interactive)
  (if (org-fc-has-back-heading-p)
      (progn
        (org-show-subtree)
        (setq org-fc-type-normal--hidden (org-fc-hide-subheading "Back")))
    (org-flag-subtree t))
  (org-fc-review-flip-hydra/body))

(defun org-fc-type-normal-flip ()
  "Flip a normal card."
  (interactive)
  (save-excursion
    (org-show-subtree)
    (dolist (pos org-fc-type-normal--hidden)
      (goto-char pos)
      (org-show-subtree)))
  (org-fc-review-rate-hydra/body))

;; No-op
(defun org-fc-type-normal-update ()
  "Update a normal card, No-op.")

(org-fc-register-type
 'normal
 'org-fc-type-normal-setup
 'org-fc-type-normal-flip
 'org-fc-type-normal-update)

;;;; Footer

(provide 'org-fc-type-normal)

;;; org-fc-type-normal.el ends here
