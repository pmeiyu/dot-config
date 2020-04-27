;; Shepherd Configuration

;; (use-modules (shepherd service) (oop goops))


(define emacs-daemon
  (make <service>
    #:docstring "Emacs daemon"
    #:provides '(emacs-daemon)
    #:start (make-forkexec-constructor
             '("emacs" "--fg-daemon"))
    #:stop (make-system-destructor
            "emacsclient" " --eval" " (kill-emacs)")))

(define mcron
  (make <service>
    #:docstring "mcron"
    #:provides '(mcron cron)
    #:start (make-forkexec-constructor
             '("mcron"))
    #:stop (make-kill-destructor)))

(define syncthing
  (make <service>
    #:docstring "syncthing"
    #:provides '(syncthing)
    #:start (make-forkexec-constructor
             '("syncthing" "-no-browser"))
    #:stop (make-kill-destructor)))


(define daemons
  (list mcron syncthing))


;; Services known to shepherd:
;; Add new services (defined using 'make <service>') to shepherd here by
;; providing them as arguments to 'register-services'.
(apply register-services daemons)

;; Send shepherd into the background
(action 'shepherd 'daemonize)

;; Services to start when shepherd starts:
;; Add the name of each service that should be started to the list
;; below passed to 'for-each'.
(for-each start daemons)
