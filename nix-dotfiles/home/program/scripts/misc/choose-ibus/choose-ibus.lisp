(defparameter *id* 2593)

;; &key will be regard as part of the &rest
;; in common lisp you pull data in and out of a stream.
;; so functions that dealing with streams become super important.
;; format is nolonger a formater, it becomes a string concatenator.
(defun check-output (cmd &rest arguments)
  "run external process and return the output as string"
  (declare (type string cmd))
  (let* ((full-cmd (format nil "~a ~{~A ~}" cmd arguments))
         (output (with-output-to-string (out)
                                        (sb-ext:run-program "/usr/bin/bash"
                                                            (list "-c" full-cmd)
                                                            :input nil
                                                            :output out))))
        (string-trim '(#\Space #\Newline #\Tab) output)))

(defun dunstify (&key duration id message)
  "run dunstify"
  (declare (type integer duration id) (string message))
  (check-output "dunstify" "-t"
                (write-to-string duration)
                "-r" (write-to-string id) message))

(defun current-engine ()
  "get current engine name"
  (check-output "ibus" "engine"))

(defun set-engine (engine)
  "set current ibus engine to `engine`"
  (declare (type string engine))
  (if (typep engine 'string)
      (check-output "ibus" "engine" engine)
      nil))

(defun grab-imp-code (name)
  "grab the input method code of engine `name`"
  (check-output "ibus" "list-engine" "|" "grep" "-i" name))

;;; A name, imp-code tuple.
(defstruct language name imp-code)

;;; All algnauges we supports.
(defparameter *languages-list*
  (vector
   (make-language :name "EN us"
                  :imp-code (grab-imp-code "xkb:us::eng"))
   (make-language :name "CH Pinyin"
                  :imp-code (grab-imp-code "libpinyin"))))

;; (make-language :name "JP Anthy"
;;                :imp-code (grab-imp-code "anthy"))

;; in clos, class is only responsible for holding data.
(defclass ibus-selector ()
  ((languages
    :initarg :languages
    :initform *languages-list*
    :accessor languages)
   (current
    :initarg :current
    :initform 0
    :accessor current)))

(defgeneric get-current-lang (o)
  (:documentation "get current language name"))

(defgeneric get-current-imp-code (o)
  (:documentation "get current language imput method code"))

(defgeneric set-current (o lang)
  (:documentation "set current input method to lang"))

(defgeneric set-to-next (o)
  (:documentation "set current to the next item in the language list "))

(defmethod get-current-lang ((o ibus-selector))
  (elt (languages o) (current o)))

(defmethod get-current-imp-code ((o ibus-selector))
  (language-imp-code (get-current-lang o)))

(defmethod set-current-lang ((o ibus-selector) lang)
  (if (position lang (languages o))
      (let ((idx (position lang (languages o))))
           (when (not (= idx (current o)))
                 (setf (current o) idx)))
      nil))

(defmethod set-to-next ((o ibus-selector))
  "set to the next input method"
  (labels ((modnext (x)
                    (let ((len (length (languages o))))
                         (mod (+ x 1) len))))
          (setf (current o) (modnext (current o)))
          (let ((current-lang (elt (languages o) (current o))))
               (set-engine (language-imp-code current-lang)))))

(defmethod set-to-next :after ((o ibus-selector))
  "set the dunsitfy notification after the new ibus engine is set"
  (dunstify :duration 1000
            :id *id*
            :message (concatenate
                       'string
                       "Ibus now is "
                       (language-name (elt (languages o) (current o))))))

(defun startswith (pat str)
  "check if string str starts with pat. Return false f length of pat is larger
   then that of str"
  (let ((is-same t))
       (if (> (length pat) (length str))
           nil
           (loop for i from 0 to (- (length pat) 1) do
                 (when (not (eql (elt pat i) (elt str i)))
                       (setf is-same nil))))
       is-same))

;; initialize-instance is by default implemented for every class.
;; by providing overload for tags (before, after, around, etc.),
;; we can provide customized construction logic.
(defmethod initialize-instance :after ((o ibus-selector) &key)
  "initialize ibus selector by getting the current ibus engine"
  (let* ((current-ibus-engine (current-engine))
         (idx (position-if (lambda (x)
                                   (print (language-imp-code x))
                                   (startswith (language-imp-code x)
                                               current-ibus-engine))
                           (languages o))))
        (setf (current o) idx)))

(defparameter *s* (make-instance 'ibus-selector))

(set-to-next *s*)
