return {
  {
    dir = vim.fn.stdpath("config") .. "/lua/local/", -- where your autosave module lives
    name = "autosave-local",                         -- give it a unique name
    lazy = false,                                    -- load at startup
    dev = true,                                      -- tells Lazy not to install or fetch this
    config = function()
      require("local.autosave").setup()
    end
  }
}
