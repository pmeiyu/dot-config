;;; Guix Channels

;;; Default:
;; %default-channels

;; (cons* (channel
;;         (name 'my-packages)
;;         (url "https://github.com/pmeiyu/guix-packages.git"))
;;        %default-channels)


(define (project-directory project)
  (string-append (or (getenv "HOME")
                     (passwd:dir (getpwuid (getuid))))
                 "/Projects/"
                 project))

(list (channel
       (name 'guix)
       (url (project-directory "guix")))
      (channel
       (name 'my-packages)
       (url (project-directory "guix-packages"))))
