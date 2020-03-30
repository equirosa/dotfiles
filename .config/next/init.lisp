(in-package :next-user)

;; Specify blocklist
(defvar *my-blocked-hosts*
  (next/blocker-mode:make-hostlist
   :hosts '("platform.twitter.com"
	    "syndication.twitter.com"
	    "m.media-amazon.com")))

(define-mode my-blocker-mode (next/blocker-mode:blocker-mode)
  ((hostlists :initform (list *my-blocked-hosts* next/blocker-mode:*default-host-list*))))

(defclass my-buffer (buffer)
  ((default-modes :initform
     (cons 'my-blocker-mode (get-default 'buffer 'default-modes)))))

(setf *buffer-class* 'my-buffer)

;; Search engines
(defclass my-browser (browser)
  ((search-engines :initform
		   '(("default"
		      "https://duckduckgo.com/?q=~a"
		      "https://duckduckgo.com/")
		     ("wiki"
		      "https://en.wikipedia.org/w/index.php?search=~a")))))

;; Make some redirections
;;;; ; Reddit
;; (defun old-reddit-hook (url)
;;   (let* ((uri (quri:uri url)))
;;     (if (search "www.reddit" (quri:uri-host uri))
;;         (progn
;;           (setf (quri:uri-host uri) "old.reddit.com")
;;           (let ((new-url (quri:render-uri uri)))
;;             (log:info "Switching to old Reddit: ~a" new-url)
;;             new-url))
;;         url)))

;; (defclass my-buffer (buffer)
;;  ((load-hook :initform (next-hooks:make-hook-string->string
;;                          :handlers (list #'old-reddit-handler)
;;                          :combination #'next-hooks:combine-composed-hook))))

;; (setf *buffer-class* 'my-buffer)

;; Some styles
(in-package :next-user)

(defclass my-buffer (buffer)
  ((box-style :initform
    (cl-css:inline-css
     '(:background "#C30000"
       :color "black"
       :border "1px #C38A22 solid"
       :font-weight "bold"
       :padding "1px 3px 0px 3px"
       :padding "1px 3px 0px 3px"
       :position "absolute"
       :text-align "center"
       :text-shadow "0 3px 7px 0px rgba(0,0,0,0.3)")))))

(setf *buffer-class* 'my-buffer)
