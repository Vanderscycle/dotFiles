;;; config.el --- hello-world Layer configuration file for Spacemacs
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Your Name Henri-vandersleyen@protonmail.com
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; Define a simple hello-world command
(defun hello-world/greet ()
  "Display a hello world message."
  (interactive)
  (message "Hello, Spacemacs World!"))

;; Bind the command to a key (optional)
(spacemacs/set-leader-keys "oh" 'hello-world/greet)

;;; config.el ends here
