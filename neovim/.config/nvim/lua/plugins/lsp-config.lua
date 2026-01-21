return {
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },
      -- Allows extra capabilities provided by blink.cmp
      'saghen/blink.cmp',
    },
    config = function()
      -- LSP Attach autocmd for keybindings
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- LSP keybindings
          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('gra', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
          map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          map('gO', require('telescope.builtin').lsp_document_symbols, '[O]pen Document Symbols')
          map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[O]pen [W]orkspace Symbols')
          map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

          -- Helper function for version compatibility
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          -- TypeScript import sorting on save
          if client and client.name == 'ts_ls' then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = event.buf,
              callback = function()
                local params = {
                  textDocument = vim.lsp.util.make_text_document_params(),
                  range = { start = { line = 0, character = 0 }, ['end'] = { line = 0, character = 0 } },
                  context = {
                    diagnostics = {},
                    ---@diagnostic disable-next-line: assign-type-mismatch
                    only = { 'source.removeUnusedImports.ts' },
                  },
                }

                local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params, 1000)
                if not result or vim.tbl_isempty(result) then
                  return
                end

                for _, res in pairs(result) do
                  if res.result then
                    for _, action in pairs(res.result) do
                      if action.edit then
                        vim.lsp.util.apply_workspace_edit(action.edit, 'utf-16')
                      elseif action.command then
                        vim.lsp.buf.execute_command(action.command)
                      end
                    end
                  end
                end
              end,
            })
          end

          -- Go import organization on save
          if client and client.name == 'gopls' then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = event.buf,
              callback = function()
                local params = {
                  textDocument = vim.lsp.util.make_text_document_params(),
                  range = { start = { line = 0, character = 0 }, ['end'] = { line = 0, character = 0 } },
                  context = {
                    only = { 'source.organizeImports' },
                    diagnostics = {},
                  },
                }

                local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params, 1000)
                if not result or vim.tbl_isempty(result) then
                  return
                end

                for _, res in pairs(result) do
                  if res.result then
                    for _, action in pairs(res.result) do
                      if action.edit then
                        vim.lsp.util.apply_workspace_edit(action.edit, 'utf-16')
                      elseif action.command then
                        vim.lsp.buf.execute_command(action.command)
                      end
                    end
                  end
                end
              end,
            })
          end

          -- Document highlight on cursor hold
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- Inlay hints toggle
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Diagnostic configuration
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            return diagnostic.message
          end,
        },
      }

      -- Get capabilities from blink.cmp
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Enable additional completion details
      capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
      capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = { 'detail', 'documentation', 'additionalTextEdits' },
      }

      -- Global LSP configuration (applies to all servers)
      vim.lsp.config('*', {
        capabilities = capabilities,
      })

      -- Define all LSP servers here
      -- Just add a new entry to enable a language server!
      local servers = {
        -- Go
        gopls = {
          settings = {
            gopls = {
              completeUnimported = true,
              usePlaceholders = true,
              analyses = {
                unusedparams = true,
              },
            },
          },
        },

        -- TypeScript/JavaScript
        ts_ls = {
          settings = {
            typescript = {
              includePackageJsonAutoImports = 'on',
              suggest = {
                includeCompletionsForModuleExports = true,
                includeCompletionsForImportStatements = false,
                includeCompletionsWithSnippetText = false,
                includeAutomaticOptionalChainCompletions = false,
              },
              preferences = {
                includePackageJsonAutoImports = 'on',
                allowIncompleteCompletions = true,
                allowRenameOfImportPath = false,
              },
              inlayHints = {
                includeInlayParameterNameHints = 'none',
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = false,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = false,
                includeInlayFunctionLikeReturnTypeHints = false,
                includeInlayEnumMemberValueHints = false,
              },
            },
            javascript = {
              includePackageJsonAutoImports = 'on',
              suggest = {
                includeCompletionsForModuleExports = true,
                includeCompletionsForImportStatements = false,
                includeCompletionsWithSnippetText = false,
                includeAutomaticOptionalChainCompletions = false,
              },
              preferences = {
                includePackageJsonAutoImports = 'on',
                allowIncompleteCompletions = true,
                allowRenameOfImportPath = false,
              },
              inlayHints = {
                includeInlayParameterNameHints = 'none',
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = false,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = false,
                includeInlayFunctionLikeReturnTypeHints = false,
                includeInlayEnumMemberValueHints = false,
              },
            },
            completions = {
              completeFunctionCalls = false,
            },
          },
          init_options = {
            maxTsServerMemory = 8192,
            tsserver = {
              maxTsServerMemory = 8192,
            },
          },
        },

        -- Svelte
        svelte = {},

        -- Lua
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- Uncomment to ignore noisy 'missing-fields' warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },

        -- Rust
        rust_analyzer = {
          settings = {
            ['rust-analyzer'] = {
              checkOnSave = true,
              check = {
                command = 'clippy',
              },
              cargo = {
                allFeatures = true,
              },
              procMacro = {
                enable = true,
              },
            },
          },
        },

        -- Add more servers here as needed:
        -- pyright = {},
        -- clangd = {},
      }

      -- Configure and enable all servers
      for server_name, server_config in pairs(servers) do
        -- Configure the server with any specific settings
        if next(server_config) ~= nil then
          vim.lsp.config(server_name, server_config)
        end

        -- Enable the server (this makes it start for matching filetypes)
        vim.lsp.enable(server_name)
      end
    end,
  },
}
