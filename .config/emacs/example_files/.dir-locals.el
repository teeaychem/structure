((python-base-mode
  . ((eglot-workspace-configuration
      . (:pylsp (:plugins (:jedi (:environment "./.venv/")
                           :jedi_completion (:include_params t
                                             :fuzzy t)
                           :pylint (:enabled :json-false)))))
     (indent-tabs-mode . nil))))
