(define syncthing
  (make <service>
    #:docstring "syncthing"
    #:provides '(syncthing)
    #:start (make-forkexec-constructor
             '("syncthing" "-no-browser"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services syncthing)
