-- [nfnl] bootstrap.fnl
local nfnl = require("nfnl.api")
local config_dir = vim.fn.stdpath("config")
local bootstrap_sentinel_file_path = (config_dir .. "/lua/sentinel.lua")
local fennel_dir = (config_dir .. "/fnl")
if (0 == vim.fn.filereadable(bootstrap_sentinel_file_path)) then
  nfnl["compile-all-files"](fennel_dir)
else
end
if require("sentinel").ready then
  return require("init")
else
  return nil
end
