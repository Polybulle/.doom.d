;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

(global-set-key (kbd "M-v") 'yank)
(global-set-key (kbd "M-c") 'kill-ring-save)
(global-set-key (kbd "M-w") 'kill-region)
(global-set-key (kbd "C-x C-x") 'org-capture)

(setq ivy-re-builders-alist '((t . ivy--regex-fuzzy))
      with-editor-emacsclient-executable "/usr/local/opt/emacs-plus/bin/emacsclient"
      doom-font (font-spec :family "JetBrains Mono" :size 12)
      doom-theme 'doom-opera-light
      ispell-dictionary "fr_FR"
      mac-option-modifier nil
      mac-command-modifier 'meta
      mac-mouse-wheel-smooth-scroll t)

(map! :after dired
      :map dired-mode-map
      :n "u" #'dired-up-directory)

(use-package! xah-math-input
  :hook (org-mode . xah-math-input-mode)
  :config
  (map! :map xah-math-input-keymap
        :i "C-SPC" #'xah-math-input-change-to-symbol))

(map! :after flyspell
      :map flyspell-mouse-map
      [mouse-1] nil
      [S-mouse-1] #'flyspell-correct-at-point)

(use-package! latex
  :defer t
  :config
  (add-to-list 'safe-local-variable-values
               '(TeX-command-extra-options . "-shell-escape"))
  (setq +latex-viewers '(pdf-tools))
  (map! :map TeX-mode-map
        :i "\"" (λ! (insert-char ?\"))))

(use-package! ivy-bibtex
  :defer t
  :config
  (setq bibtex-completion-bibliography '("~/Stage/Stage.bib")
        bibtex-completion-pdf-field "file"))

(setq org-default-notes-file (concat org-directory "/inbox.org"))

(use-package! ox-publish
  :commands (org-publish)
  :config
  (setq hsdotcom-source-dir "~/Site"
        hsdotcom-dest-dir "~/Code/hectorsuzanne.com"

        org-publish-project-alist
        `(("hsdotcom" :components ("hsdotcom-notes" "hsdotcom-static"))

        ("hsdotcom-notes"
         :base-directory ,hsdotcom-source-dir
         :base-extension "org"
         :exclude ,(concat hsdotcom-source-dir "/setup/*")
         :publishing-directory ,hsdotcom-dest-dir
         :recursive t
         :publishing-function org-html-publish-to-html
         :headline-levels 4
         :auto-preamble t)

        ("hsdotcom-static"
         :base-directory ,hsdotcom-source-dir
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
         :include ("CNAME")
         :publishing-directory ,hsdotcom-dest-dir
         :recursive t
         :publishing-function org-publish-attachment))))

(cd "/Users/polybulle/")
