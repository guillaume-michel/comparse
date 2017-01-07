(in-package #:comparse)

(defun replace-subseq (needle haystack replacement)
  (let* ((haystack (copy-seq haystack))
         (idx (search needle haystack :test 'equal)))
    (when idx
      (replace haystack replacement :start1 idx))
    haystack))

(defun replace-invalid (old new)
  (let ((replace-invalid (find-restart 'replace-invalid)))
    (when replace-invalid
      (invoke-restart replace-invalid old new))))

(defun run (parser input)
  ;; the run function runs the parser and returns the entire parse tree
  (restart-case
      (progn
        (funcall parser input))
    (replace-invalid (old new)
      (let ((next-replace-invalid (find-restart 'replace-invalid)))
        (if (and next-replace-invalid (not (search old input)))
            (invoke-restart 'replace-invalid old new)
            (funcall parser (replace-subseq old (copy-seq input) new)))))))

(defun parse (parser input)
  ;; Most of the time we simply want the CAR of the FIRST result.
  ;; The CDR is the leftover input, and the REST of the result alternative outcomes.
  ;; We might want these as well, so we return that as VALUES.
  (let ((result (run parser input)))
    (when result
      (destructuring-bind ((result . input) &rest rest)
          result
        (apply #'values result input rest)))))
