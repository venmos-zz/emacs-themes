;; venmos .emacs.d/elisp/init-tabbar.el
;; http://venmos.com
;; venmos@fuck.gfw.es


;; require
(require 'uniquify)
(require 'tabbar)
(require 'ibuf-ext)
(require 'tabbar)

;; tabbar-extension
(defun tabbar-select-end-tab ()
  (interactive)
  (tabbar-select-beg-tab t))

(defun tabbar-select-beg-tab (&optional backward type)
  (interactive)
  (let* ((tabset (tabbar-current-tabset t))
         (ttabset (tabbar-get-tabsets-tabset))
         (cycle (if (and (eq tabbar-cycle-scope 'groups)
                         (not (cdr (tabbar-tabs ttabset))))
                    'tabs
                  tabbar-cycle-scope))
         selected tab)
    (when tabset
      (setq selected (tabbar-selected-tab tabset))
      (setq tabset (tabbar-tabs tabset)
            tab (car (if backward (last tabset) tabset)))
      (tabbar-click-on-tab tab type))))

(defun tabbar-backward-tab-other-window (&optional reversed)
  (interactive)
  (other-window 1)
  (if reversed
      (tabbar-forward-tab)
    (tabbar-backward-tab))
  (other-window -1))

(defun tabbar-forward-tab-other-window ()
  (interactive)
  (tabbar-backward-tab-other-window t))

(setq uniquify-buffer-name-style 'forward)
(tabbar-mode t)

;; 这里定义左右切换 Buffer 快捷键
(global-set-key (kbd "H-{") 'tabbar-backward)
(global-set-key (kbd "H-}") 'tabbar-forward)
(global-set-key (kbd "C-c [") 'tabbar-backward-group)
(global-set-key (kbd "C-c ]") 'tabbar-forward-group)

;; 这里隐藏了 Tabbar 上的三角按钮
(defcustom tabbar-hide-header-button t
	:type 'boolean
  :set (lambda (symbol value)
         (set symbol value)
         (if value
             (setq
              tabbar-scroll-left-help-function nil 
              tabbar-scroll-right-help-function nil
              tabbar-help-on-tab-function nil
              tabbar-home-help-function nil
              tabbar-buffer-home-button (quote (("") ""))
              tabbar-scroll-left-button (quote (("") ""))
              tabbar-scroll-right-button (quote (("") "")))))
  :group 'tabbar)

;; 这里定义 Tabbar 的颜色
(set-face-attribute 'tabbar-default nil
         :background "#ffffff"
         :family "Source Code Pro"
         :foreground "#ffffff"
         :height 1)
(set-face-attribute 'tabbar-unselected nil
         :inherit 'tabbar-default
         :background "#ffffff"
         :foreground "#89BEB7"
         :box nil)
(set-face-attribute 'tabbar-selected nil
         :inherit 'tabbar-default
         :background "#EEAD0D"
         :foreground "#ffffff"
         :box nil)
(set-face-attribute 'tabbar-separator nil
										:height 1)

;; 这里定义 Buffer <C-x C-b> 的分类
(defun venmos-tabbar-buffer-groups () 
  (list (cond ((string-equal "+" (substring (buffer-name) 0 1)) "Message")
              ((eq major-mode 'twittering-mode) "Message")
              ((eq major-mode 'mew-message-mode) "Message")
              ((eq major-mode 'mew-summary-mode) "Messenge")
              ((eq major-mode 'erc-mode) "Message")
              ((eq major-mode 'erc-modes) "Message")
              ((eq major-mode 'weibo-timeline-mode) "Message")
              ((eq major-mode 'weibo-post-mode) "Message")
              ((eq major-mode 'weibo-user-mode) "Message")
              ((eq major-mode 'weibo-image-mode) "Message")
              ((eq major-mode 'dired-mode) "Dired")
              ((eq major-mode 'sr-mode) "Dired")
              ((eq major-mode 'eshell-mode) "Shell")
              ((eq major-mode 'shell-mode) "Shell")
							((eq major-mode 'term-mode) "Shell")
              ((eq major-mode 'org-mode) "Documents")
              ((eq major-mode 'markdown-mode) "Documents")
              ((eq major-mode 'html-mode) "Website")
              ((eq major-mode 'web-mode) "Website")
              ((eq major-mode 'css-mode) "Website")
              ((eq major-mode 'php-mode) "Website")
              ((eq major-mode 'emacs-lisp-mode) "ELisp")
              ((eq major-mode 'calendar-mode) "Emacs")
              ((eq major-mode 'diary-mode) "Emacs")
              ((eq major-mode 'w3m-mode) "W3M")
							((eq major-mode 'eww-mode) "W3M")
							((eq major-mode 'text-mode) "Simplenote")
							((eq major-mode 'magit-mode) "Magit")
							((eq major-mode 'magit-log-mode) "Magit")
							((eq major-mode 'git-commit-mode) "Magit")
						  ((string-equal "*" (substring (buffer-name) 0 1)) "Emacs")
							(t "User"))))

(setq tabbar-buffer-groups-function 'venmos-tabbar-buffer-groups)

;; provide
(provide 'init-tabbar)
;;; init-tabbar.el ends here
