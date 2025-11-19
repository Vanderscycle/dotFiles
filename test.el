(require 'eieio)
;; Elisp programs are made of symbolic expressions ("sexps"):
;; SPC m e b (evaluate buffer)
(setq max-front-squat 315)
(setq max-deadlift 315)
(setq max-ovh-press 155)
;; "%s" string
;; "%d" digit
;; essentially console.log
;; (message "%d" max-front-squat)
;; (message "%d" (/ max-ovh-press .7))
;; (message "%d" (+ 2 2 ))

;; I can only train 3-4 times a week
;; I want progressive overloads for the heavy lifts. which allows for spare work (if I feel good)
;; kb exervises clean/jerk, snatch, loaded carry.
;;(setq table '((set exercise weight)))

(defclass workout ()
  ((exercise :initarg :exercise
             :initform ""
             :type string
             :custom string
             :documentation "The big lift name.")
   (weight :initarg :weight
           :initform 0
           :type integer
           :custom integer
           :documentation "The weight of the lift.")))

(cl-defmethod data ((wkout workout))
  (message "exercise: %s weight: %d"
           (slot-value wkout 'exercise)
           (slot-value wkout 'weight)))

;; let*: Variables are bound in sequence, so later ones can use earlier ones
(cl-defmethod month ((wkout workout) &optional (sets 1))
  "Generate org table rows for N sets of a workout."
  (let* ((exercise (slot-value wkout 'exercise)) ;; defines a list of vars
         (weight (round (* (slot-value wkout 'weight) 0.7)))
         (rows (mapcar (lambda (i) (list i exercise weight))
                       (number-sequence 1 sets))))
    rows)) ;; rows contains the returned data

(cl-defmethod to-org ((tables list))
  "Render multiple workout tables into a temporary Org-mode buffer."
  (let ((buf (get-buffer-create "*Workout Tables*")))
    (with-current-buffer buf
      (erase-buffer)
      (org-mode)
      (dolist (table tables)
        (insert "\n") ;; Add a blank line between tables
        ;; Optionally: Add a heading
        (let ((exercise-name (nth 1 (car table)))) ;; Get exercise name from row 1
          (insert (format "* %s\n" exercise-name)))
        ;; Insert the table rows
        (dolist (row table)
          (insert (mapconcat (lambda (cell)
                               (format "| %s " cell))
                             row
                             "")
                  "|\n"))
        (insert "\n")) ;; Another newline for spacing
      (goto-char (point-min))
      (org-table-map-tables 'org-table-align))
    (switch-to-buffer buf)))

;; ---
(setq squats (workout :exercise "Squat" :weight max-front-squat))
(setq deadlift (workout :exercise "Deadlift" :weight max-deadlift))

(data squats)
;; Call month to add to table
;;(month squats)

;; Check contents of table
(to-org (list (month squats 7)
              (month deadlift 5)))
