function SetupColors(color)
  color = color or "ayu-dark"
  vim.cmd.colorscheme(color)  

  -- Set transparent background
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end
-- TODO: Add support for configuring colorschemes
-- By project. Since we're already using direnv, maybe we can
-- use a set the colorscheme in the .envrc file as an env variable
SetupColors("pink-moon")
