;; Shepherd Configuration

(use-modules (shepherd service)
             (oop goops)
             ((ice-9 ftw) #:select (scandir)))

(define %xdg-config-home
  (or (getenv "XDG_CONFIG_HOME")
      (string-append (or (getenv "HOME")
                         (passwd:dir (getpwuid (getuid))))
                     "/.config")))

(define %log-directory
  (string-append (or (getenv "HOME")
                     (passwd:dir (getpwuid (getuid))))
                 "/.local/log"))

(unless (file-exists? %log-directory)
  (mkdir %log-directory))

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
             #:log-file (string-append %log-directory "/emacs.log"))
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
             #:log-file (string-append %log-directory "/mcron.log"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services mcron)

;; Services to start when shepherd starts.
(define daemons
  (list emacs mcron))

;; Load all the files in the directory 'init.d' with a suffix '.scm'.
(let ((init-dir (string-append %xdg-config-home "/shepherd/init.d")))
  (for-each (lambda (file)
              (load (string-append init-dir "/" file)))
            (or (scandir init-dir
                         (lambda (file)
                           (string-suffix? ".scm" file)))
                '())))

;; Start services.
(for-each start daemons)
