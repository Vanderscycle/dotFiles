;; --- tramp/ssh ---
(defun connect-monolith ()
  "Open a remote folder using TRAMP in Dired."
  (interactive)
  (dired "/ssh:monolith@192.168.4.129:/"))

(defun connect-macos()
  "Open a remote folder using TRAMP in Dired."
  (interactive)
  (dired "/ssh:mac@192.168.4.167:/"))

(defun connect-pi ()
  "Open a remote folder using TRAMP in Dired."
  (interactive)
  (dired "/ssh:admin@192.168.1.100:/"))

(defun connect-kube-node1 ()
  "Open a remote folder using TRAMP in Dired."
  (interactive)
  (dired "/ssh:proxmox@192.168.2.10:/"))

(defun connect-kube-node2 ()
  "Open a remote folder using TRAMP in Dired."
  (interactive)
  (dired "/ssh:proxmox@192.168.2.12:/"))

(defun connect-kube-node3 ()
  "Open a remote folder using TRAMP in Dired."
  (interactive)
  (dired "/ssh:proxmox@192.168.2.13:/"))

(defhydra hydra/diredssh (:hint nil :color blue)
  "
SSH Connections                  Kubernetes Nodes
--------------------------       --------------------------
_f_: factorio/monolith           _1_: kube-node1
_p_: Pi                          _2_: kube-node2
_m_: Macos                       _3_: kube-node3
_q_: Cancel
"
  ("f" connect-monolith :color yellow)
  ("p" connect-pi :color yellow)
  ("m" connect-macos :color yellow)
  ("1" connect-kube-node1 :color yellow)
  ("2" connect-kube-node2 :color yellow)
  ("3" connect-kube-node3 :color yellow)
  ("q" nil "cancel" :color blue))
(spacemacs/set-leader-keys "ods" 'hydra/diredssh/body)
