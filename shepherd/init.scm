;; Shepherd Configuration

(use-modules (shepherd service)
             (oop goops)
             ((ice-9 ftw) #:select (scandir)))

;; Send shepherd into background.  This should be done before respawnable
;; services are started in order to catch the SIGCHLD signal.
(action 'shepherd 'daemonize)

;; Emacs
(define emacs
  (make <service>
    #:docstring "Emacs daemon"
    #:provides '(emacs emacs-daemon)
    #:start (make-forkexec-constructor
             '("emacs" "--fg-daemon")
             #:log-file (string-append %user-log-dir "/emacs.log"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services emacs)

;; Mcron
(define mcron
  (make <service>
    #:docstring "mcron"
    #:provides '(mcron cron)
    #:start (make-forkexec-constructor
             '("mcron")
             #:log-file (string-append %user-log-dir "/mcron.log"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services mcron)

;; Load all the files in the directory 'init.d' with a suffix '.scm'.
(let ((init-dir (string-append %user-config-dir "/init.d")))
  (for-each (lambda (file)
              (load (string-append init-dir "/" file)))
            (or (scandir init-dir
                         (lambda (file)
                           (string-suffix? ".scm" file)))
                '())))

;; Start services.
;; (define daemons (list emacs mcron))
;; (for-each start daemons)
