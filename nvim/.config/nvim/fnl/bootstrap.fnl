(local nfnl (require :nfnl.api))

(let [config-dir (vim.fn.stdpath "config")
      bootstrap-sentinel-file-path (.. config-dir "/lua/sentinel.lua")
      fennel-dir (.. config-dir "/fnl")]

  (when (= 0 (vim.fn.filereadable bootstrap-sentinel-file-path))
    (nfnl.compile-all-files fennel-dir))

  (when (. (require :sentinel) :ready)
    (require :init)))
