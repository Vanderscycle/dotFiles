;; --- tramp/ssh ---
(defun connect-monolith ()
  "Open a remote folder using TRAMP in Dired."
  (interactive)
  (dired "/ssh:monolith@192.168.2.228:/"))

(defun connect-medialab ()
  "Open a remote folder using TRAMP in Dired."
  (interactive)
  (dired "/ssh:monolith@192.168.1.196:/"))

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
  ("m" connect-medialab :color yellow)
  ("q" nil "cancel" :color blue))
(spacemacs/set-leader-keys "ods" 'hydra/diredssh/body)
