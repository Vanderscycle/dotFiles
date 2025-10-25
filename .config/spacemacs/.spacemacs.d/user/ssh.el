;; --- tramp/ssh ---
(defun connect-monolith ()
  "Open a remote folder using TRAMP in Dired."
  (interactive)
  (dired "/ssh:monolith@192.168.2.228:/"))

(defun connect-macos()
  "Open a remote folder using TRAMP in Dired."
  (interactive)
  (dired "/ssh:mac@192.168.4.167:/"))

(defun connect-pi ()
  "Open a remote folder using TRAMP in Dired."
  (interactive)
  (dired "/ssh:admin@192.168.1.100:/"))

(defhydra hydra/diredssh (:hint nil :color blue)
  "
SSH Connections
--------------------------
_f_: factorio/monolith
_p_: Pi
_m_: Macos
_q_: Cancel
"
  ("f" connect-monolith :color yellow)
  ("p" connect-pi :color yellow)
  ("m" connect-macos :color yellow)
  ("q" nil "cancel" :color blue))
(spacemacs/set-leader-keys "ods" 'hydra/diredssh/body)
