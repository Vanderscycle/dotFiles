;;; Compiled snippets and support files for `python-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'python-mode
                     '(("module_end" "if __name__ == \"__main__\":\n   pass\n" "module" nil nil nil "/home/henri/.config/doom/snippets/python-mode/module" nil nil)
                       ("function" "def ${1:name}(${2:parameters}) -> ${3:return_types}\n    \"\"\"docstrings\"\"\"\n    return" "function" nil nil nil "/home/henri/.config/doom/snippets/python-mode/func" nil nil)
                       ("enum_interface" "class ${1:enum}(Enum):\n    ACCOUNTING = 0\n" "enum" nil nil nil "/home/henri/.config/doom/snippets/python-mode/enum" nil nil)
                       ("class" "class ${1:}:\ndef __init__(self, ${2:arguments}) -> None:\n    \"\"\"docs\"\"\"\n    pass\ndef first_method(self) -> None:\n    pass\n" "class" nil nil nil "/home/henri/.config/doom/snippets/python-mode/class" nil nil)))


;;; Do not edit! File generated at Wed Jun 14 10:33:26 2023
