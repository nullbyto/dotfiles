;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file emplates and snippets. It is optional.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-tokyo-night)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
;; (setq display-line-numbers-type t)
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; General
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; enable global word wrapping (called visual line mode)
(global-visual-line-mode t)
;; another way: add word-wrap doom module in init.el:
;; https://docs.doomemacs.org/latest/modules/editor/word-wrap

;; evil should respect visual line mode
;; set variable before loading evil
(use-package-hook! evil
  :pre-init
  (setq evil-respect-visual-line-mode t) ;; sane j and k behavior
  t)

(defun my/print-register (reg)
  (message (format "\"%c" reg))
  )
(advice-add 'evil-use-register :before 'my/print-register)

;; Edit Modeline
(after! doom-modeline
  (setq doom-modeline-persp-name t)
  (setq doom-modeline-persp-icon nil))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Variables
(defvar my/servers-list-file-path "~/.doom.d/servers.txt"
  "Path to my servers list file")

(defun my/read-lines (filePath)
  "Return a list of lines of a file at filePath."
  (with-temp-buffer
    (insert-file-contents filePath)
    (split-string (buffer-string) "\n" t)))

(defun my/dired-home ()
  "Open dired in home directory"
  (interactive)
  (dired "~/")
  )

(defun my/choose-a-server (server)
  "Choose from a list of servers defined in .doom.d/servers.txt in format user@ip"
  (interactive (list (completing-read "Choose a server: " (my/read-lines my/servers-list-file-path))))
  (let ((servers-list (my/read-lines my/servers-list-file-path)))
    (if (member server servers-list)
        nil
      (write-region server nil my/servers-list-file-path 'append)
      )
    )
  (dired (format "/ssh:%s:" server))
  )

(defun my/remote-shell (host)
  "Spawn a remote shell to server specified user@ip"
  (interactive (list (completing-read "Choose a server: " (my/read-lines my/servers-list-file-path))))
  (let ((default-directory (format "/ssh:%s:" host)))
    ;; shell, eshell, term or vterm
    (shell)
    )
  )

(defun my/find-file-ssh (file-name)
  "Open find-file with ssh:"
  (interactive
   (list (read-file-name "Remote file/dir: " "/ssh:"))
   )
  (switch-to-buffer (find-file-noselect file-name))
  )

(defun my/connect-to-server ()
  "Connect to remote server providing user and server user@ip"
  (interactive)
  (setq user_name (read-string "Enter username of remote server: "))
  (setq server_ip (read-string "Enter server ip of remote server: "))
  (dired (format "/ssh:%s@%s:" user_name server_ip))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom keybindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(map! :leader
      ;; <leader> x will invoke the command provided after the single quote
      "o C-s" #'my/find-file-ssh
      "o C--" #'my/dired-home
      ;; <leader> y will print "Hello world" in the minibuffer
      "y" (cmd! (message "Hello world"))
      )

(map! :leader
      "\\ c" #'my/choose-a-server
      "\\ t" #'my/connect-to-server
      "\\ -" #'my/dired-home
      "\\ s" #'my/find-file-ssh
      "\\ r" #'my/remote-shell
      )

;; Disable using systems clipboard
(setq select-enable-clipboard nil)
(map! :map evil-insert-state-map
      :prefix "C-c"
      "c v" '("Paste from clipboard" . "+")
 )
(map! :map evil-normal-state-map
      :prefix "C-c"
      "d" '("Delete to black hole" . "\"_dd")
      "c x" '("Cut to clipboard" . "\"+dd")
      "c v" '("Paste from clipboard" . "\"+p")
      "c c" '("Yank to clipboard" . "\"+yy")
 )
(map! :map evil-visual-state-map
      :prefix "C-c"
      "p" '("Paste into without copying" . "\"_dP")
      "d" '("Delete to black hole" . "\"_dd")
      "c x" '("Cut to clipboard" . "\"+dd")
      "c v" '("Paste from clipboard" . "\"+p")
      "c c" '("Yank to clipboard" . "\"+y")
 )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Packages configs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq lsp-diagnostics-provider :none)
