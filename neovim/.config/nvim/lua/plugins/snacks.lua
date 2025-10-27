return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    dashboard = { enabled = true },
    lazygit = {
      configure = true,
      enabled = true,
    },
    notifier = { enabled = true },
    notify = {
      enabled = true,
      timeout = 2000,
    },
    words = { enabled = true },
  },
  keys = {
    {
      '<leader>gg',
      function()
        Snacks.lazygit()
      end,
      desc = 'Lazygit',
    },
  },
}
