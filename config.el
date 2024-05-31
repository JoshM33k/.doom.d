;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 14)
      doom-variable-pitch-font (font-spec :family "Alegreya" :size 18))

;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This will (apparently) allow mixed-fonts in a buffer and fix font scaling in org mode?
;;(add-hook! 'org-mode-hook #'mixed-pitch-mode)
;; This makes it so that each * is dimly visible on each org row
;;(add-hook! 'org-mode-hook #'solaire-mode)

(add-hook! org-mode :append
           #'visual-line-mode ;; word wrap!
           ;;#'variable-pitch-mode
           )

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

;; Denote settings
(require 'denote)
(setq denote-directory (expand-file-name "~/org/"))
(setq denote-known-keywords '("emacs" "programming" "managing" "learning"))

;; pick dates, when relevant, with Org's advanced interface:
(setq denote-date-prompt-use-org-read-date t)

;; show some context when viewing backlinks instead of just file names
(setq denote-backlinks-show-context t)

;; This will 'fontify' the file name listing for denote files in dired
(setq denote-dired-directories-include-subdirectories t)
(setq denote-dired-directories
      (list denote-directory
            (expand-file-name "~/org/")))
(add-hook 'dired-mode-hook #'denote-dired-mode-in-directories)

;; Some Denote-specific key mapping
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

;; Keybinding creation example for SPC a j j and SPC a j s
;;(map! :leader
;;      (:prefix-map ("a" . "applications")
;;       (:prefix ("j" . "journal")
;;        :desc "New journal entry" "j" #'org-journal-new-entry
;;        :desc "Search journal entry" "s" #'org-journal-search)))

;; Maximize the window upon startup
;;(setq initial-frame-alist '((top . 10) (left . 10) (width . 90) (height . 75)))
(if (window-system)
  (set-frame-height (selected-frame) 50))

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


;; focus new window after splitting
(setq evil-split-window-below t
      evil-vsplit-window-right t)

;; (diredfl-global-mode -1)
;; (diredfl-mode -1)


;; None of this is currently work :(
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
