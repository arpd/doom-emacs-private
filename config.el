;;; ~/.config/doom/config.el -*- lexical-binding: t; -*-

(defun is-work-host ()
  (string= (system-name) "workvm-vbox"))

(setq user-full-name "Ben Foster"
      user-mail-address (if (is-work-host)
                            "ben.foster@etas.com"
                          "bf@svbtl.io")
      which-key-idle-delay 0.1
      which-key-idle-secondary-delay 0.1)

;; When I bring up Doom's scratch buffer with SPC x, it's often to play with
;; elisp or note something down (that isn't worth an entry in my notes). I can
;; do both in `lisp-interaction-mode'.
(setq doom-scratch-initial-major-mode 'lisp-interaction-mode)

(setq vc-ignore-dir-regexp
      (format "\\(%s\\)\\|\\(%s\\)"
              vc-ignore-dir-regexp
              tramp-file-name-regexp))

;;
;;; UI

;; doom-font (font-spec :family "PragmataPro Mono" :size 12 :weight 'light)
;; NOTE(bf): to live test fonts:
;; 1) SPC m e r
;; 2) SPC h r f
(setq doom-theme 'doom-city-lights
      doom-font (font-spec :family "Input Mono Compressed" :size 14 :weight 'ultra-light))
;     doom-font (font-spec :family "Input Mono Condensed" :size 12 :weight 'semi-light))

;; Line numbers are pretty slow all around. The performance boost of disabling
;; them outweighs the utility of always keeping them on.
(setq display-line-numbers-type nil)

;;
;;; Modules

;;; :completion company
;; IMO, modern editors have trained a bad habit into us all: a burning need for
;; completion all the time -- as we type, as we breathe, as we pray to the
;; ancient ones -- but how often do you *really* need that information? I say
;; rarely. So opt for manual completion:
;(after! company
;  (setq company-idle-delay nil))

;;; :ui modeline
;; An evil mode indicator is redundant with cursor shape
(advice-add #'doom-modeline-segment--modals :override #'ignore)

;;; :editor evil
;; Focus new window after splitting
(setq evil-split-window-below t
      evil-vsplit-window-right t)

;; Implicit /g flag on evil ex substitution, because I use the default behavior
;; less often.
(setq evil-ex-substitute-global t)

;;; :tools lsp
;; Disable invasive lsp-mode features
(after! lsp-mode
  (setq lsp-enable-symbol-highlighting nil))
(after! lsp-ui
  (setq lsp-ui-sideline-enable nil))

;;; Language customizations

(define-generic-mode sxhkd-mode
  '(?#)
  '("alt" "Escape" "super" "bspc" "ctrl" "space" "shift") nil
  '("sxhkdrc") nil
  "Simple mode for sxhkdrc files.")
