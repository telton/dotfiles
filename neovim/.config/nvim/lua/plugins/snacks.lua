return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    dashboard = { enabled = true },
    picker = {
      enabled = true,
      ui_select = true, -- replaces telescope-ui-select
    },
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
    -- Top pickers
    { '<leader><leader>', function() Snacks.picker.buffers() end, desc = 'Buffers' },
    { '<leader>/', function() Snacks.picker.lines() end, desc = 'Buffer Lines' },
    { '<leader>sf', function() Snacks.picker.files() end, desc = 'Find Files' },
    { '<leader>sg', function() Snacks.picker.grep() end, desc = 'Grep' },
    { '<leader>sw', function() Snacks.picker.grep_word() end, desc = 'Visual selection or word', mode = { 'n', 'x' } },
    { '<leader>s.', function() Snacks.picker.recent() end, desc = 'Recent' },
    -- Search
    { '<leader>sd', function() Snacks.picker.diagnostics() end, desc = 'Diagnostics' },
    { '<leader>sh', function() Snacks.picker.help() end, desc = 'Help Pages' },
    { '<leader>sk', function() Snacks.picker.keymaps() end, desc = 'Keymaps' },
    { '<leader>ss', function() Snacks.picker.smart() end, desc = 'Smart Search' },
    { '<leader>sr', function() Snacks.picker.resume() end, desc = 'Resume' },
    { '<leader>s/', function() Snacks.picker.grep_buffers() end, desc = 'Grep Open Buffers' },
    {
      '<leader>sn',
      function()
        Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
      end,
      desc = 'Search Neovim Config',
    },
    -- Other
    { '<leader>n', function() Snacks.picker.notifications() end, desc = 'Notification History' },
    { '<leader>gg', function() Snacks.lazygit() end, desc = 'Lazygit' },
  },
}
