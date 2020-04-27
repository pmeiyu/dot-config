;;; Guix Channels

;;; Default:
;; %default-channels

(cons* (channel
        (name 'my-packages)
        (url "https://github.com/pmeiyu/guix-packages.git"))
       %default-channels)

;; (list (channel
;;        (name 'guix)
;;        (branch "dev")
;;        (url "https://github.com/pmeiyu/guix.git"))
;;       (channel
;;        (name 'my-packages)
;;        (url "https://github.com/pmeiyu/guix-packages.git")))
