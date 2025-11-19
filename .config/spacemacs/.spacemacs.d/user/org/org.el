;; --- org-general ---
(add-hook 'org-mode-hook
          (lambda ()
            (toggle-truncate-lines nil) ))

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

;; --- org-priority
;; ~spc m p~ will allow you to set the priority
(setq org-lowest-priority  ?F) ;; Gives us priorities A through F
(setq org-default-priority ?E) ;; If an item has no priority, it is considered [#E].
;; --- org-tags ---
(setq org-tag-alist
      '(
        ;; Ticket types
        (:startgroup . nil)
        ("@bug" . ?b)
        ("@feature" . ?u)
        ("@spike" . ?j)
        (:endgroup . nil)

        ;; descritpive
        ("new" . ?q)
        ;; tasks TODOs
        (:startgroup . nil)
        ("homelab" . ?h)
        ("3d_printer" . ?3)
        ("maintenance" . ?m)
        ("programming" . ?p)
        ("workout" . ?w)
        ("emacs" . ?e)
        ("linux" . ?l)
        (:endgroup . nil)
        ))

;; --- org-templates --- (to capture the information)
(setq org-directory "~/Documents/zettelkasten/org")
(setq org-capture-templates
      `(
        ("t" "tasks w/ deadline" entry
         (file+headline ,(concat org-directory "/home/tasks.org") "Task list")
         "* TODO [#B] %?\nDEADLINE: %^t")
        ("l" "link to a buffer file" entry
         (file+headline ,(concat org-directory "/home/tasks.org") "Links to buffer/files")
         "* TODO [#C] %?\n%a")
        ("c" "Contact Information PLEASE ENCRYPT")
        ("ca" "Acquitances and friends" entry
         (file+headline ,(concat org-directory "/home/contacts.org") "Acquitances and Friends")
         "* %^{Name Full}\n :PROPERTIES:\n :PHONE: %^{+country number}\n :EMAIL: %^{email}\n")
        ("cf" "Family" entry
         (file+headline ,(concat org-directory "/home/contacts.org") "Family Members")
         "* %^{Name Full}\n :PROPERTIES:\n :PHONE: %^{+country number}\n :RELATION: %^{Relation}\n :EMAIL: %^{email}\n :BIRTHDAY: %^t")
        ("w" "Work PLEASE ENCRYPT")
        ("wj" "Work Log Entry" entry
         (file+datetree ,(concat org-directory "/work/work-log.org"))
         "* %^{Task}\n:PROPERTIES:\n:END:\n%?"
         :empty-lines 0)
        ("m" "meetings PLEASE ENCRYPT")
        ("ma" "Appointments" entry
         (file+datetree ,(concat org-directory "/home/meetings.org"))
         "* MEETING %:from\nSCHEDULED: %^t\n :PROPERTIES:\n :TOPIC: %:subject %?\n :END:\n%?"
         :empty-lines 0)
        ("l" "Learning")
        ("lk" "Cooking" entry
         (file+headline ,(concat org-directory "/home/cooking.org") "Cooking")
         "* %^{Recipe name}\n :PROPERTIES:\n :CAPTURE: %U\n :PLATE: %^{Plate type}\n :END:\n\n** Ingredients\n#+begin_quote\n%?\n#+end_quote\n** Instructions"
         :empty-lines 0)
        ("lb" "Book" entry
         (file+headline ,(concat org-directory "/home/books.org") "Books")
         "* %^{Book name}\n :PROPERTIES:\n :CAPTURE: %U\n :SUBJECT: %^{Subject}\n :PAGE: %^{Page}\n :END:\n\n#+begin_quote\n%?\n#+end_quote"
         :empty-lines 0)
        ("lc" "Code" entry
         (file+headline ,(concat org-directory "/home/code.org") "Code")
         "* %^{Code knowledge}%?\n :PROPERTIES:\n :CAPTURE: %U\n :LANGUAGE: %^{Language}\n :USE_CASE: %^{Use case}\n :END:\n\n#+begin_src %^{Language}\n%?\n#+end_src"
         :empty-lines 0)
        ("lz" "Chinese" entry
         (file+headline ,(concat org-directory "/home/Chinese.org") "Chinese")
         "* %^{Chinese words/patterns to remember}\n :PROPERTIES:\n :CAPTURE: %U\n :END:\n\n%?"
         :empty-lines 0)
        ("lp" "Pattern" entry
         (file+headline ,(concat org-directory "/home/learning.org") "Patterns")
         "* %^{Speak your mind}\n :PROPERTIES:\n :CAPTURE: %U\n :SUBJECT:%^{Subject}\n :END:\n%i\n%?"
         :empty-lines 0)
        ("i" "Ideas")
        ("ip" "Pattern" entry
         (file+headline ,(concat org-directory "/home/ideas.org") "Patterns")
         "* %^{Speak your mind}\n :PROPERTIES:\n :CAPTURE: %U\n :END:\n\n%i\n%?"
         :empty-lines 0)
        ("ie" "Emacs" entry
         (file+headline ,(concat org-directory "/home/ideas.org") "Emacs")
         "* %^{What is your Emacs idea/project}\n :PROPERTIES:\n :CAPTURE: %U\n :END:\n%i\n%?"
         :empty-lines 0)
        ("is" "Usefull skills" entry
         (file+headline ,(concat org-directory "/home/ideas.org") "Usefull skills")
         "* %^{What skill/subskill would help?}\n :PROPERTIES:\n :SKILL:%^{Skill}\n :CAPTURE: %U\n :END:\n%i\n%?"
         :empty-lines 0)
        ("w" "Workout")
        ("wb" "Bike ride" entry
         (file+dateline ,(concat org-directory "/org/workout.org"))
         "* %^{How was the ride}\n :PROPERTIES:\n :DISTANCE:\n :END:\n\n %i\n%?"
         :empty-lines 0)
        ("wk" "Kettlebells" entry
         (file+dateline ,(concat org-directory "/org/workout.org") "")
         "* %^{How was the workout}\n :PROPERTIES:\n :END:\n\n %i\n%?"
         :empty-lines 0)
        ))

;; --- org-roam --- (to store the information)
(spacemacs/set-leader-keys "oord" 'org-roam-dailies-capture-today)
(spacemacs/set-leader-keys "oorr" 'org-roam-ref-add)
;; don't forget to org-roam-db-sync
(setq org-roam-directory "~/Documents/zettelkasten/org-roam")
(setq org-default-notes-file (concat org-directory )) ;; "/notes.org"
(setq org-roam-capture-templates
      '())
;; '(
;;   ("d" "default" plain "%?"
;;    :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+date: %U\n")
;;    :unnarrowed t)
;;   ("c" "chinese" plain
;;    "\n* ${title}\n** Words\n** Patterns\n** Radicals\n** Forgotten Words\n"
;;    :target (file+head "notes/chinese/%<%Y%m%d>-${slug}.org"
;;                       "#+title: ${title}\n#+filetags: :chinese:\n\n* ${title}\nRoot Parent: [[id:31c43342-c4dd-4fff-bef5-a4ee1cd04f42][chinese]]\n")
;;    :unnarrowed t
;;    :immediate-finish nil)
;;   ("b" "book child" plain
;;    "\n* Source\n\nAuthor: %^{Author}\nTitle: ${title}\nYear: %^{Year}\n\n* Summary\n\n%?"
;;    :target (file+head "notes/books/%<%Y%m%d>-${slug}.org"
;;                       "#+title: ${title}\n#+filetags: :book:\n\n* ${title}\nRoot Parent: [[id:eb639da8-b533-46df-a0ab-3a7135e4349b][books]]\n")
;;    :unnarrowed t
;;    :immediate-finish nil)
;;   ("l" "programming language" plain
;;    "* Characteristics\n\n- Family: %?\n- Inspired by: \n\n* Reference:\n\n"
;;    :if-new (file+head "programming/%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
;;    :unnarrowed t)
;;   ("p" "project" plain "* Goals\n\n%?\n\n* Tasks\n\n** TODO Add initial tasks\n\n* Dates\n\n"
;;    :if-new (file+head "projects/%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: Project")
;;    :unnarrowed t)
;;   ))
