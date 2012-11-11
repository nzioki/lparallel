;;; Copyright (c) 2011-2012, James M. Lawrence. All rights reserved.
;;; 
;;; Redistribution and use in source and binary forms, with or without
;;; modification, are permitted provided that the following conditions
;;; are met:
;;; 
;;;     * Redistributions of source code must retain the above copyright
;;;       notice, this list of conditions and the following disclaimer.
;;; 
;;;     * Redistributions in binary form must reproduce the above
;;;       copyright notice, this list of conditions and the following
;;;       disclaimer in the documentation and/or other materials provided
;;;       with the distribution.
;;; 
;;;     * Neither the name of the project nor the names of its
;;;       contributors may be used to endorse or promote products derived
;;;       from this software without specific prior written permission.
;;; 
;;; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
;;; "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
;;; LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
;;; A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
;;; HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
;;; SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
;;; LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
;;; DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
;;; THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
;;; (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
;;; OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

(in-package #:lparallel.spin-queue)

#+sbcl
(eval-when (:compile-toplevel :load-toplevel :execute)
  (require 'sb-concurrency))

#+sbcl
(progn
  (deftype spin-queue () 'sb-concurrency:queue)

  (defun make-spin-queue (&optional initial-capacity)
    (declare (ignore initial-capacity))
    (sb-concurrency:make-queue))
  
  ;; only used for testing
  (defun peek-spin-queue (queue)
    (let ((list (sb-concurrency:list-queue-contents queue)))
      (if list
          (values (first list) t)
          (values nil nil))))

  (alias-function push-spin-queue    sb-concurrency:enqueue)
  (alias-function pop-spin-queue     sb-concurrency:dequeue)
  (alias-function spin-queue-count   sb-concurrency:queue-count)
  (alias-function spin-queue-empty-p sb-concurrency:queue-empty-p))

#-sbcl
(progn
  (deftype spin-queue () 'lparallel.queue:queue)

  (defun make-spin-queue (&optional initial-capacity)
    (declare (ignore initial-capacity))
    (lparallel.queue:make-queue))

  (alias-function push-spin-queue    lparallel.queue:push-queue)
  (alias-function pop-spin-queue     lparallel.queue:try-pop-queue)
  (alias-function peek-spin-queue    lparallel.queue:peek-queue)
  (alias-function spin-queue-count   lparallel.queue:queue-count)
  (alias-function spin-queue-empty-p lparallel.queue:queue-empty-p))
