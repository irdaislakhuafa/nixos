-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
-- Create an autocommand to run this function whenever the colorscheme changes
-- In ~/.config/lvim/config.lua

-- Add flash.nvim to your plugins
lvim.plugins = {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    -- Configuration is optional, but setting a leader key is helpful
    opts = {
      modes = {
        -- Set 's' to start a forward search, which is the key you'll use
        search = {
          enabled = true,
          mode = "search",
          motion = true,
        },
      },
    },
    -- Optionally, map a key for the "Flash" command (search/jump)
    keys = {
      -- Normal mode mapping: Press 's' to start flash search
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },
  -- ... your other plugins
}
