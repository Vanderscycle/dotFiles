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

(setq org-priority-faces
      '(
        (65 . (:foreground "#f38ba8" :weight bold)) ;; Priority A (highest) - Red
        (66 . (:foreground "#fab387" :weight bold)) ;; Priority B - Peach
        (67 . (:foreground "#cba6f7" :weight bold)) ;; Priority C - Mauve
        (68 . (:foreground "#89b4fa" :weight bold)) ;; Priority D - Blue
        (69 . (:foreground "#74c7ec" :weight bold)) ;; Priority E - Sapphire
        (70 . (:foreground "#9399b2" :weight bold)) ;; Priority F (lowest) - Overlay2
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
