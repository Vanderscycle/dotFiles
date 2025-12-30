(require 'all-the-icons)
(require 'json)
(require 'url-util)
(require 'calc)

(defvar universal-launcher--previous-frame nil "The previous frame to return to.")

;; (defun universal-launcher--web-search (query)
;;   "Search the web with QUERY using default browser.
;; If QUERY looks like a URL, navigate directly to it.
;; Otherwise, prompt for a search engine."
;;   (let* ((search-engines
;;           '(("Google" . "https://www.google.com/search?q=")
;;             ("Go documentation" . "https://pkg.go.dev/search?q=")
;;             ("ArchWiki" . "https://wiki.archlinux.org/index.php?search=")
;;             ("DuckDuckGo" . "https://duckduckgo.com/?q=")
;;             ("Wiby" . "https://wiby.me/?q=")
;;             ("Anna's Archive" . "https://annas-archive.org/search?q=")
;;             ("Wikipedia" . "https://en.wikipedia.org/w/index.php?search=")
;;             ("4get" . "https://4get.ca/web?s=")
;;             ("Goodreads" . "https://www.goodreads.com/search?q=")
;;             ("Nix Packages" . "https://search.nixos.org/packages?channel=25.05&show=")
;;             ("NixOS Options" . "https://search.nixos.org/options?channel=25.05&query=")
;;             ("DevDocs.io" . "https://devdocs.io/#q=")
;;             ("GitHub" . "https://github.com/search?q=")
;;             ("Google Images" . "https://www.google.com/search?tbm=isch&q=")
;;             ("Google Maps" . "https://www.google.com/maps/search/")
;;             ("Internet Archive" . "https://archive.org/search.php?query=")
;;             ("Kagi" . "https://kagi.com/search?q=")
;;             ("MDN" . "https://developer.mozilla.org/en-US/search?q=")
;;             ("Project Gutenberg" . "https://www.gutenberg.org/ebooks/search/?query=")
;;             ("StackOverflow" . "https://stackoverflow.com/search?q=")
;;             ("Wolfram Alpha" . "https://www.wolframalpha.com/input/?i=")
;;             ("YouTube" . "https://www.youtube.com/results?search_query=")
;;             ("Perplexity" . "https://www.perplexity.ai/search/new?q=")
;;             ("Hacker News" . "https://hn.algolia.com/?q=")
;;             ("Semantic Scholar" . "https://www.semanticscholar.org/search?q=")
;;             ("Google Scholar" . "https://scholar.google.com/scholar?q=")
;;             ("Go Issues" . "https://github.com/golang/go/issues?q=")
;;             ("Crates.io" . "https://crates.io/search?q=")
;;             ("MELPA" . "https://melpa.org/#/?q=")
;;             ("Man Pages" . "https://man.archlinux.org/search?q=")
;;             ("Emacs Docs" . "https://www.gnu.org/software/emacs/manual/html_node/emacs/index.html?search=")
;;             )))
;;     ;; Check if query is a URL
;;     (if (string-match-p "^\\(https?://\\|www\\.\\)" query)
;;         ;; Navigate directly
;;         (browse-url (if (string-prefix-p "www." query)
;;                         (concat "https://" query)
;;                       query))
;;       ;; Otherwise, search
;;       (let* ((default-engine (or universal-launcher--last-search-engine
;;                                  universal-launcher-default-search-engine
;;                                  "Google"))
;;              (engine (completing-read
;;                       (format "Search with (default %s): " default-engine)
;;                       (mapcar #'car search-engines)
;;                       nil t nil nil default-engine))
;;              (url-base (cdr (assoc engine search-engines)))
;;              (encoded-query (url-hexify-string query)))
;;         (setq universal-launcher--last-search-engine engine)
;;         (browse-url (concat url-base encoded-query))))));; Insert emoji function


(defun universal-launcher-popup ()
  "World-class launcher for Emacs."
  (interactive)

  ;; Store current frame
  (setq universal-launcher--previous-frame (selected-frame))

  ;; Force update if needed
  (universal-launcher--update-candidates)

  ;; Create candidates list with nil as completion table to allow any input
  (let* ((candidates (mapcar #'car universal-launcher--all-candidates))
         (prompt "🚀 Launch (or enter math expression): ")
         (selection
          (minibuffer-with-setup-hook
              (lambda ()
                ;; Allow any input, not just candidates
                (setq-local completion-styles '(substring partial-completion basic))
                (setq-local completion-category-overrides nil))
            (completing-read prompt
                             ;; Use a function that always returns all candidates
                             ;; This allows typing anything while still showing candidates
                             (lambda (string pred action)
                               (if (eq action 'metadata)
                                   '(metadata (category . universal-launcher))
                                 (all-completions string candidates pred)))
                             nil    ; predicate
                             nil    ; require-match = nil allows any input!
                             nil    ; initial-input
                             nil    ; hist
                             nil))) ; def
         (candidate (cdr (assoc selection universal-launcher--all-candidates))))

    (cond
     ;; Empty input - do nothing
     ((string-empty-p selection) nil)

     ;; Calculator check - prioritize this before other matches
     ((universal-launcher--is-calculator-input selection)
      (universal-launcher--handle-calculator-input selection))

     ;; Separator - do nothing
     ((eq candidate 'separator) nil)

     ;; Handle matched candidates
     (candidate
      (let ((type (car candidate))
            (item (cadr candidate)))
        (pcase type
          ('buffer (switch-to-buffer item))
          ('running (universal-launcher--focus-running-application item))
          ('app (universal-launcher--run-application item))
          ('firefox-action (universal-launcher--handle-firefox-action item))
          ('bookmark (universal-launcher--handle-bookmark item))
          ('file (find-file item))
          ('command (universal-launcher--run-command item))
          ('emoji (universal-launcher--insert-emoji item))
          ('ssh (universal-launcher--ssh-connect item))
          ('calculator (message "🧮 Type a math expression like: 2+2, sqrt(16), sin(45)"))
          ('org-task (universal-launcher--jump-to-task item))
          ('kill-ring (universal-launcher--yank-from-ring item))
          ('custom-action (universal-launcher--execute-custom-action item))
          ('function (funcall item))
          ('async-shell
           (let ((default-directory (or (locate-dominating-file default-directory ".git")
                                        default-directory)))
             (async-shell-command item)))
          ('shell-command
           (let ((default-directory (or (locate-dominating-file default-directory ".git")
                                        default-directory)))
             (shell-command item)))
          (_ (message "Unknown action type: %s" type)))))

     ;; Web search fallback - only if not a calculator expression
     ((and (not candidate)
           (not (string-empty-p selection))
           (not (universal-launcher--is-calculator-input selection)))
      (universal-launcher--web-search selection)))

    ;; Return to previous frame
    (when (and universal-launcher--previous-frame
               (frame-live-p universal-launcher--previous-frame))
      (select-frame-set-input-focus universal-launcher--previous-frame))))

;; Set up background update timer
(run-with-timer universal-launcher--update-interval
                universal-launcher--update-interval
                #'universal-launcher--update-candidates)

(provide 'universal-launcher)
;;; universal-launcher.el ends here
