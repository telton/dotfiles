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
      '<leader>n',
      function()
        Snacks.picker.notifications()
      end,
      desc = 'Notification History',
    },
    {
      '<leader>gg',
      function()
        Snacks.lazygit()
      end,
      desc = 'Lazygit',
    },
  },
}
