(defun +calendar/open-calendar ()
  "Open calfw calendar with org integration."
  (interactive)
  (require 'calfw)
  (require 'calfw-org)

  ;; Apply Catppuccin Mocha Palette
  (custom-theme-set-faces
   'user
   '(cfw:face-title ((t (:foreground "#cba6f7" :weight bold :height 1.2))))     ;; Mauve
   '(cfw:face-header ((t (:foreground "#89b4fa" :weight bold))))               ;; Blue
   '(cfw:face-sunday ((t (:foreground "#f38ba8" :weight bold))))               ;; Red
   '(cfw:face-saturday ((t (:foreground "#89dceb" :weight bold))))             ;; Sky
   '(cfw:face-grid ((t (:foreground "#313244"))))                              ;; Surface0
   '(cfw:face-today ((t (:background "#45475a" :weight bold))))                ;; Surface1
   '(cfw:face-select ((t (:background "#585b70" :foreground "#f5e0dc"))))      ;; Surface2 + Rosewater
   '(cfw:face-schedule ((t (:foreground "#fab387"))))                          ;; Peach
   '(cfw:face-deadline ((t (:foreground "#f9e2af")))))                         ;; Yellow

  (calfw-org-open-calendar))

;; Prevent byte-compilation of this function
(put '+calendar/open-calendar 'byte-compile 'byte-compile-file-form-defmumble)
(defun my/new-frame-with-vterm ()
  "Create a new frame and immediately open vterm in it."
  (interactive)
  (require 'vterm)
  (let ((new-frame (make-frame '((explicit-vterm . t)))))
    (select-frame new-frame)
    (delete-other-windows)
    ;; Force vterm to take full window
    (let ((vterm-buffer (vterm (format "*vterm-%s*" (frame-parameter new-frame 'name)))))
      (switch-to-buffer vterm-buffer)
      (delete-other-windows))))  ; Nuke any splits vterm created

;; --- /| ---
