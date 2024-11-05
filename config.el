;; STOP!! DO NOT EDIT THIS FILE DIRECTLY!!
;; ----------------------------------------
;; This file is generated from README.org, a literate source file.
;; You should make any changes there and then regenerate this file per the instructions found there.

(setq user-full-name "Josh Meek"
      user-mail-address "meek.josh@gmail.com")

(defun font-exists-p (font) (if (null (x-list-fonts font)) nil t))
(when (window-system)
  (cond ((font-exists-p "JetBrains Mono") (setq doom-font (font-spec :family "JetBrains Mono" :size 13)))
    ((font-exists-p "JetBrains Mono") (setq doom-font (font-spec :family "JetBrains Mono" :size 13))))
  (cond ((font-exists-p "Noto Sans") (setq doom-variable-pitch-font (font-spec :family "Noto Sans" :size 16 :weight 'bold)))))
  ;;(cond ((font-exists-p "Noto Sans") (setq doom-variable-pitch-font (font-spec :family "ET Book" :size 13)))))

;;(setq doom-font (font-spec :family "ETBookOT"))
;;(setq doom-font (font-spec :family "JetBrains Mono" :size 13))

(cond (:system 'macos
               (when (window-system)
  (cond ((font-exists-p "JetBrains Mono") (setq doom-font (font-spec :family "JetBrains Mono" :size 14)))
    ((font-exists-p "JetBrains Mono") (setq doom-font (font-spec :family "JetBrains Mono" :size 14))))
  (cond ((font-exists-p "Noto Sans") (setq doom-variable-pitch-font (font-spec :family "Noto Sans" :size 14)))))
               ))

(use-package! fontaine
  :preface
  (defvar jm/base-font-height
    140
    "The main font size")
  :demand
  :init
  (setq fontaine-presets
        `((JetBrains-Light
           :default-family "JetBrains Mono"
           :default-weight light
           :default-height ,(- jm/base-font-height 10))
          (JetBrains-Regular
           :default-family "JetBrains Mono"
           :default-weight regular
           :default-height ,(- jm/base-font-height 10))
          (VCTR-Light
           :default-family "VCTR Mono Trial v0.12"
           :default-weight light
           :default-height ,(- jm/base-font-height 10))
          (VCTR-Regular
           :default-family "VCTR Mono Trial v0.12"
           :default-weight regular
           :default-height ,(- jm/base-font-height 10))
          (ETBook
           :default-family "ETBookOT"
           :default-weight bold
           :default-height ,(- jm/base-font-height 10))
          ))
  :config
  (fontaine-set-preset (fontaine-store-latest-preset))
  :hook
  (fontaine-set-preset . fontaine-store-latest-preset))
;;(fontaine-set-preset (or (fontaine-restore-latest-preset) 'JetBrains-Regular))
;(fontaine-mode 1)

;;(setq doom-theme 'doom-dracula)
;;(setq doom-theme 'doom-outrun-electric)
(setq doom-theme 'doom-solarized-light)

(setq display-line-numbers-type t)

(setq org-directory "~/org/")

(add-hook! org-mode :append
           #'visual-line-mode)

(add-hook 'org-mode-hook 'org-auto-tangle-mode)

(setq org-hide-emphasis-markers t)

(font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

(use-package org-bullets
    :config
    (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(setq org-agenda-custom-commands
      '(("p" "Planning"
         ((tags-todo "+@planning"
                     ((org-agenda-overriding-header "Planning Tasks")))
          (tags-todo "-{.*}"
                     ((org-agenda-overriding-header "Untagged Tasks")))))))

;;(setq org-todo-keywords
;;      '((sequence "TODO" "NEXT" "PROG" "|" "DONE")))

(setq denote-directory (expand-file-name "~/org/"))

(setq denote-known-keywords '("emacs" "programming" "managing" "learning"))

(setq denote-date-prompt-use-org-read-date t)

(setq denote-backlinks-show-context t)

;(setq denote-rename-buffer-format "[D] %t%b")
;(denote-rename-buffer-mode 1)

(setq denote-dired-directories-include-subdirectories t)
(setq denote-dired-directories
      (list denote-directory
            (expand-file-name "~/org/")))
(add-hook 'dired-mode-hook #'denote-dired-mode-in-directories)

(map! :leader
      (:prefix-map ("d" . "denote")
                :desc "new denote note" "d" #'denote
                :desc "link to existing note, or create a new note" "l" #'denote-link-or-create
                (:prefix ("b" . "backlinks")
                         :desc "show backlinks to the current note" "b" #'denote-backlinks
                         :desc "next backlink" "j" #'denote-backlinks-mode-next
                         :desc "previous backlink" "k" #'denote-backlinks-mode-previous)
                (:prefix ("s" . "stats")
                         :desc "count notes" "c" #'denote-explore-count-notes
                         :desc "count keywords" "k" #'denote-explore-count-keywords
                         :desc "keywords barchart" "b" #'denote-explore-keywords-barchart
                         :desc "extensions barchart" "e" #'denote-explore-extensions-barchart)
                (:prefix ("u" . "Utilities")
                         :desc "insert dynamic links block" "l" #'denote-org-extras-dblock-insert-links
                         :desc "update dynamic links block" "u" #'org-dblock-update)
                (:prefix ("r" . "random walks")
                         :desc "random note" "r" #'denote-explore-random-note
                         :desc "random link" "l" #'denote-explore-random-link
                         :desc "random keyword" "k" #'denote-explore-random-keyword)
                (:prefix ("j" . "janitor")
                         :desc "duplicate notes" "d" #'denote-explore-identify-duplicate-notes
                         :desc "zero keywords" "z" #'denote-explore-zero-keywords
                         :desc "single keywords" "i" #'denote-explore-single-keywords
                         :desc "sort keywords" "s" #'denote-explore-sort-keywords
                         :desc "rename keyword" "r" #'denote-explore-rename-keyword)))

(use-package! denote-explore
  :custom
  ;; Location of graph files
  (denote-explore-network-directory "~/org/graphs/")
  (denote-explore-network-filename "denote-network")
  ;; Output format
  (denote-explore-network-format 'graphviz)
  (denote-explore-network-graphviz-filetype "svg")
  ;; Exlude keywords or regex
  (denote-explore-network-keywords-ignore '("bib")))

(defun joshm33k/center-frame-on-primary-monitor ()
  "Centers the current frame on the primary monitor and resizes it to 75% of the monitor's size."
  (interactive)
  (let* ((monitor-attributes (car (display-monitor-attributes-list))) ; Get primary monitor's attributes
         (monitor-geometry (assoc 'geometry monitor-attributes))
         (monitor-x (nth 0 (cdr monitor-geometry)))
         (monitor-y (nth 1 (cdr monitor-geometry)))
         (monitor-width (nth 2 (cdr monitor-geometry)))
         (monitor-height (nth 3 (cdr monitor-geometry)))
         ;; Convert monitor size from pixels to characters
         (char-width (frame-char-width))
         (char-height (frame-char-height))
         (new-width (round (* 0.75 (/ monitor-width char-width))))
         (new-height (round (* 0.75 (/ monitor-height char-height))))
         (new-x (+ monitor-x (/ (- monitor-width (* new-width char-width)) 2)))
         (new-y (+ monitor-y (/ (- monitor-height (* new-height char-height)) 2))))
    (set-frame-size (selected-frame) new-width new-height)
    (set-frame-position (selected-frame) new-x new-y)))

;; Optional: Bind the function to a key for quick access
;;(global-set-key (kbd "C-c C-f") 'center-frame-on-primary-monitor)

(joshm33k/center-frame-on-primary-monitor)

(map! :leader
      (:prefix-map ("z" . "Utilities")
                (:prefix ("f" . "Frame Management")
                         :desc "Center the frame on the primary monitor" "c" #'joshm33k/center-frame-on-primary-monitor)))

(setq evil-split-window-below t
      evil-vsplit-window-right t)

(setq confirm-kill-emacs nil)

(let ((alternatives '(;;"doom-emacs-color.png"
                      ;;"doom-emacs-color2.svg"
                      ;;"doom-emacs-bw-light.svg"
                      "doom-emacs-flugo-slant_out_purple.png"
                      ;;"doom-emacs-flugo-slant_out_bw.png"
                      )))
  (setq fancy-splash-image
        (concat doom-user-dir "splash/"
                (nth (random (length alternatives)) alternatives))))

(after! company
  (set-company-backend! 'org-mode nil))

(setq company-global-modes '(not org-mode))

(after! company
    ;;; Prevent suggestions from being triggered automatically. In particular,
  ;;; this makes it so that:
  ;;; - TAB will always complete the current selection.
  ;;; - RET will only complete the current selection if the user has explicitly
  ;;;   interacted with Company.
  ;;; - SPC will never complete the current selection.
  ;;;
  ;;; Based on:
  ;;; - https://github.com/company-mode/company-mode/issues/530#issuecomment-226566961
  ;;; - https://emacs.stackexchange.com/a/13290/12534
  ;;; - http://stackoverflow.com/a/22863701/3538165
  ;;;
  ;;; See also:
  ;;; - https://emacs.stackexchange.com/a/24800/12534
  ;;; - https://emacs.stackexchange.com/q/27459/12534

  ;; <return> is for windowed Emacs; RET is for terminal Emacs
  (dolist (key '("<return>" "RET"))
    ;; Here we are using an advanced feature of define-key that lets
    ;; us pass an "extended menu item" instead of an interactive
    ;; function. Doing this allows RET to regain its usual
    ;; functionality when the user has not explicitly interacted with
    ;; Company.
    (define-key company-active-map (kbd key)
      `(menu-item nil company-complete
                  :filter ,(lambda (cmd)
                             (when (company-explicit-action-p)
                              cmd)))))
  ;; (define-key company-active-map (kbd "TAB") #'company-complete-selection)
  (map! :map company-active-map "TAB" #'company-complete-selection)
  (map! :map company-active-map "<tab>" #'company-complete-selection)
  (define-key company-active-map (kbd "SPC") nil)

  ;; Company appears to override the above keymap based on company-auto-complete-chars.
  ;; Turning it off ensures we have full control.
  (setq company-auto-commit-chars nil) ;; this appears to now be obsolete, replaced with the below
  (setq company-insertion-triggers nil)
  )

(use-package! yasnippet :config(yas-global-mode))

(use-package! lsp-mode :hook ((lsp-mode . lsp-enable-which-key-integration))
              :config (setq lsp-completion-enable-additional-text-edit nil))

(use-package! which-key :config (which-key-mode))

(use-package! lsp-java :config (add-hook 'java-mode-hook 'lsp))

(use-package! dap-mode :after lsp-mode :config (dap-auto-configure-mode))

;(use-package! helm :config (helm-mode))

;; workaround for large title bar on macOS Sonoma
;; see https://github.com/doomemacs/doomemacs/issues/7532
(add-hook 'doom-after-init-hook (lambda () (tool-bar-mode 1) (tool-bar-mode 0)))

(defun jm/google-current-word ()
  ;; initially written by chatgpt but later modified by u/Aminumbra
  "Search the current word on Google using browse-url."
  (interactive)
  (let ((word (thing-at-point 'word)))
    (if word
        (browse-url (concat "https://www.google.com/search?q=" word))
      (message "No word found at point."))))
