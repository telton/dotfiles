return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    local ts = require 'nvim-treesitter'

    -- Ensure parsers are installed via ensure_installed in setup
    local languages = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }

    ts.setup {
      ensure_installed = languages,
    }

    -- Enable treesitter features automatically via autocommands
    -- This replaces the old 'highlight = { enable = true }' and 'indent = { enable = true }'
    local group = vim.api.nvim_create_augroup('treesitter-features', { clear = true })

    vim.api.nvim_create_autocmd('FileType', {
      group = group,
      callback = function(args)
        local bufnr = args.buf
        local ft = vim.bo[bufnr].filetype
        local lang = vim.treesitter.language.get_lang(ft)

        if not lang then
          return
        end

        -- Try to start treesitter highlighting
        if vim.treesitter.query.get(lang, 'highlights') then
          pcall(vim.treesitter.start, bufnr, lang)
        end

        -- Set up indentation if queries are available
        if vim.treesitter.query.get(lang, 'indents') then
          vim.bo[bufnr].indentexpr = 'v:lua.vim.treesitter.indentexpr()'
        end

        -- Set up folding if queries are available
        if vim.treesitter.query.get(lang, 'folds') then
          -- Note: foldmethod/foldexpr are window-local
          vim.wo.foldmethod = 'expr'
          vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        end
      end,
    })
  end,
}
