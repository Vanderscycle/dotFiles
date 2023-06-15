;;; Compiled snippets and support files for `org-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'org-mode
                     '(("section" "** ${1:section}\n   - +[[Table of Content]]\n*** ${2:subsection}" "section" t nil nil "/home/henri/.config/doom/snippets/org-mode/section" nil "t")
                       ("chapter" "* ${1:chapter}\n** Table of Content\n   1. +[[$2]]\n** $2\n   - +[[Table of Content]]\n*** ${3:sub-section}\n" "chapter" nil nil nil "/home/henri/.config/doom/snippets/org-mode/chapter" nil nil)))


;;; Do not edit! File generated at Wed Jun 14 10:33:26 2023
