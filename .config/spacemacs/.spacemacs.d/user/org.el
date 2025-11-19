;; --- org-general ---
(setq user-mail-address "henri-vandersleyen@protonmail.com")
(add-hook 'org-mode-hook
          (lambda ()
            (toggle-truncate-lines nil) ))

(spacemacs/set-leader-keys "olk" 'spacemacs/helm-persp-kill)
;; --- org-keybindings ---
(defun my/org-add-checkbox-counter ()
  "Append `[/]` at the end of the current TODO item."
  (interactive)
  (save-excursion
    (org-back-to-heading t)
    (end-of-line)
    (insert " [/]")
    ))
;; keybinding will only be available in org mode
(add-hook 'org-mode-hook
          (lambda ()
            (spacemacs/set-leader-keys-for-major-mode 'org-mode "T/" 'my/org-add-checkbox-counter)
            (spacemacs/set-leader-keys-for-major-mode 'org-mode "iDc" 'org-download-clipboard)
            ))
;; --- org-modern ---
(setq org-adapt-indentation t
      org-hide-leading-stars t
      org-hide-emphasis-markers t
      org-pretty-entities t
      org-ellipsis "  ·")
(setq org-src-fontify-natively t
      org-src-tab-acts-natively t
      org-edit-src-content-indentation 0)
;; --- org-journal ---
(setq org-journal-dir "~/Documents/zettelkasten/org-roam/org/journal")
(setq org-directory "~/Documents/zettelkasten/org-roam/org")
(setq org-default-notes-file (concat org-directory )) ;; "/notes.org"
(setq find-file-visit-truename t)
;; --- org-clock ---

(setq org-clocktable-defaults '(:maxlevel 4 :lang "en" :scope file :block nil :wstart 1 :mstart 1 :tstart nil
                                          :tend nil :step nil :stepskip0 nil :fileskip0 nil :tags nil :match
                                          nil :emphasize nil :link nil :narrow 40! :indent t :filetitle nil
                                          :hidefiles nil :formula nil :timestamp nil :level nil :tcolumns nil
                                          :formatter nil))
;; --- org-agenda ---
(setq org-agenda-files '("~/Documents/zettelkasten/org-roam/"))
(setq org-agenda-skip-deadline-if-done t)

;; --- org-todo ---
(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
        (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "CANC(k@)")))

(setq org-todo-keyword-faces
      '(("TODO"      :inherit (org-todo region) :foreground "#A6E3A1" :weight bold)  ; Green
        ("NEXT"      :inherit (org-todo region) :foreground "#F9E2AF" :weight bold)  ; Yellow
        ("PLAN"      :inherit (org-todo region) :foreground "#74C7EC" :weight bold)  ; Sapphire
        ("READY"     :inherit (org-todo region) :foreground "#89B4FA" :weight bold)  ; Blue
        ("ACTIVE"    :inherit (org-todo region) :foreground "#F38BA8" :weight bold)  ; Red
        ("REVIEW"    :inherit (org-todo region) :foreground "#F5C2E7" :weight bold)  ; Pink
        ("WAIT"      :inherit (org-todo region) :foreground "#EBA0AC" :weight bold)  ; Maroon
        ("BACKLOG"   :inherit (org-todo region) :foreground "#B4BEFE" :weight bold)  ; Lavender
        ("HOLD"      :inherit (org-todo region) :foreground "#CBA6F7" :weight bold)  ; Mauve
        ("DONE"      :inherit (org-todo region) :foreground "#6C7086" :weight bold)  ; Gray (Subtext0)
        ("CANC"      :inherit (org-todo region) :foreground "#FAB387" :weight bold)  ; Peach
        ))
;; --- org-priority
;; ~spc m p~ will allow you to set the priority
(setq org-lowest-priority  ?F) ;; Gives us priorities A through F
(setq org-default-priority ?E) ;; If an item has no priority, it is considered [#E].

(setq org-priority-faces
      '(
        (65 . (:foreground "#f38ba8" :weight bold)) ;; Priority A (highest) - Red
        (66 . (:foreground "#fab387" :weight bold)) ;; Priority B - Peach
        (67 . (:foreground "#cba6f7" :weight bold)) ;; Priority C - Mauve
        (68 . (:foreground "#89b4fa" :weight bold)) ;; Priority D - Blue
        (69 . (:foreground "#74c7ec" :weight bold)) ;; Priority E - Sapphire
        (70 . (:foreground "#9399b2" :weight bold)) ;; Priority F (lowest) - Overlay2
        ))
;; --- org-tags ---
(setq org-tag-alist
      '(
        ;; Ticket types
        (:startgroup . nil)
        ("@bug" . ?b)
        ("@feature" . ?u)
        ("@spike" . ?j)
        ("@emergency" . ?e)
        (:endgroup . nil)

        ;; descritpive
        ("new" . ?q)
        ;; tasks TODOs
        (:startgroup . nil)
        ("homelab" . ?h)
        ("3d_printer" . ?3)
        ("maintenance" . ?m)
        ("planning" . ?p)
        ("workout" . ?w)
        ("linux" . ?l)
        (:endgroup . nil)
        ))
(setq org-tag-faces
      '(
        ("@bug"        . (:foreground "#f38ba8" :background "#313244" :weight bold))  ; Red on surface0
        ("@feature"    . (:foreground "#a6e3a1" :background "#313244" :weight bold))  ; Green on surface0
        ("@spike"      . (:foreground "#cba6f7" :background "#313244" :weight bold))  ; Mauve on surface0
        ("@emergency"  . (:foreground "#fab387" :background "#45475a" :weight bold :box t))  ; Peach on surface1 with box
        ("homelab"     . (:foreground "#89b4fa" :weight bold))  ; Blue
        ("linux"     . (:foreground "#89b4fa" :weight bold))  ; Blue
        ("3d_printer"  . (:foreground "#a6e3a1" :weight bold))  ; Green
        ("maintenance" . (:foreground "#f9e2af" :weight bold))  ; Yellow
        ("planning"    . (:foreground "#f38ba8" :weight bold))  ; Red
        ))

;; --- org-templates ---
(setq org-directory "~/Documents/zettelkasten/org")
(setq org-capture-templates
      `(
        ("t" "task for a day" entry
         (file+headline ,(concat org-directory "/home/tasks.org") "Task list")
         "* TODO [#B] %?\nDEADLINE: %^t")
        ("l" "link to a buffer file" entry
         (file+headline ,(concat org-directory "/home/tasks.org") "Links to buffer/files")
         "* TODO [#C] %?\n%a")
        ("c" "Contact Information PLEASE ENCRYPT")
        ("ca" "Acquitances and friends" entry
         (file+headline ,(concat org-directory "/home/contacts.org") "Acquitances and Friends")
         "* %^{Name SURNAME}\n :PROPERTIES:\n :PHONE: %^{+country number}\n :EMAIL:%^{}\n")
        ("cf" "Family" entry
         (file+headline ,(concat org-directory "/home/contacts.org") "Family Members")
         "* %^{Name SURNAME}\n :PROPERTIES:\n :PHONE: %^{+country number}\n :EMAIL:%^{}\n")
        ("w" "work PLEASE ENCRYPT")
        ("wj" "Work Log Entry" entry
         (file+datetree ,(concat org-directory "/work/work-log.org"))
         "* %^{Task}\n:PROPERTIES:\n:END:\n"
         :empty-lines 0)
        ;; ("c" "Code To-Do"
        ;;  entry (file+headline "~/Documents/zettelkasten/org/work/todo.org" "Code Related Tasks")
        ;;  "* TODO [#C] %?\n:PROPERTIES:\n:Effort: $^{Effort}\n:Weight: $^{Weight}\n:END:\nDEADLINE: %^T\n:Created: %T\n%i\n%a\nShortcut Ticket: \nProposed Solution: \n"
        ;;  :empty-lines 0)
        ;; ("g" "General To-Do"
        ;;  entry (file+headline "~/Documents/zettelkasten/org/home/todo.org" "General TODOS")
        ;;  "* TODO [#E] %?\n:Created: %T\n "
        ;;  :empty-lines 0)
        ;; ("l" "Learning note"
        ;;  entry (file+headline "~/Documents/zettelkasten/org/home/learning.org" "Learning Notes")
        ;;  "* %^{Subject} \n:PROPERTIES:\n:END:\n** %?"
        ;;  :empty-lines 0)
        ;; ("b" "Book note"
        ;;  entry (file+headline "~/Documents/zettelkasten/org/home/books.org" "Book Notes")
        ;;  "* %^{Subject}\n:PROPERTIES:\n:Title: %^{Title}\n:Author: %^{Author}\n:END:\n** Notes\n%?"
        ;;  :empty-lines 0)
        ;; ("m" "Meeting"
        ;;  entry (file+datetree "~/Documents/zettelkasten/org/work/meetings.org")
        ;;  "* %^{meeting} :meeting:%^g\n:PROPERTIES:\n:Created: %T\n:END:\n** Attendees\n*** \n** Notes\n** Action Items\n*** TODO [#A] "
        ;;  :tree-type week
        ;;  :clock-in t
        ;;  :clock-resume t
        ;;  :empty-lines 0)
        ))

;; --- org-roam ---
(setq org-roam-db-autosync-mode nil)
;; don't forget to org-roam-db-sync
(setq org-roam-directory "~/Documents/zettelkasten/org-roam")
(setq org-journal-dir "~/Documents/zettelkasten/org/journal")
(setq org-default-notes-file (concat org-directory )) ;; "/notes.org"
;; https://systemcrafters.net/build-a-second-brain-in-emacs/capturing-notes-efficiently/
(setq org-roam-capture-templates
      '(
        ("d" "default" plain "%?"
         :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+date: %U\n")
         :unnarrowed t)
        ("c" "chinese" plain
         "\n* ${title}\n** Words\n** Patterns\n** Radicals\n** Forgotten Words\n"
         :target (file+head "notes/chinese/%<%Y%m%d>-${slug}.org"
                            "#+title: ${title}\n#+filetags: :chinese:\n\n* ${title}\nRoot Parent: [[id:31c43342-c4dd-4fff-bef5-a4ee1cd04f42][chinese]]\n")
         :unnarrowed t
         :immediate-finish nil)
        ("b" "book child" plain
         "\n* Source\n\nAuthor: %^{Author}\nTitle: ${title}\nYear: %^{Year}\n\n* Summary\n\n%?"
         :target (file+head "notes/books/%<%Y%m%d>-${slug}.org"
                            "#+title: ${title}\n#+filetags: :book:\n\n* ${title}\nRoot Parent: [[id:eb639da8-b533-46df-a0ab-3a7135e4349b][books]]\n")
         :unnarrowed t
         :immediate-finish nil)
        ("l" "programming language" plain
         "* Characteristics\n\n- Family: %?\n- Inspired by: \n\n* Reference:\n\n"
         :if-new (file+head "programming/%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
         :unnarrowed t)
        ("p" "project" plain "* Goals\n\n%?\n\n* Tasks\n\n** TODO Add initial tasks\n\n* Dates\n\n"
         :if-new (file+head "projects/%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: Project")
         :unnarrowed t)
        ))
