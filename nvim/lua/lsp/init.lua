if isModuleAvailable('lspconfig') then
  local nvim_lsp = require('lspconfig')
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  require('lspkind').init()

  -- Diagnostics symbols for display in the sign column.
  local signs = { Error = "", Warn = "", Hint = "", Info = "" }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
  vim.cmd('setlocal omnifunc=v:lua.vim.lsp.omnifunc')

  if isModuleAvailable('cmp_nvim_lsp') then
    require'lspconfig'.tsserver.setup {
      capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    }
    require'lspconfig'.pylsp.setup{
      capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    }
    require'lspconfig'.pyright.setup{
      capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    }

    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")

    require'lspconfig'.sumneko_lua.setup {
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
            -- Setup your lua path
            path = runtime_path,
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'},
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      },
    }

    require'lspconfig'.rust_analyzer.setup{
      on_attach = on_attach,
      settings = {
        ["rust-analyzer"] = {
          assist = {
            importMergeBehavior = "last",
            importPrefix = "by_self",
          },
          diagnostics = {
            disabled = { "unresolved-import" }
          },
          cargo = {
            loadOutDirsFromCheck = true
          },
          procMacro = {
            enable = true
          },
          checkOnSave = {
            command = "clippy"
          },
        }
      },
      capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    }
  else
    print("comp_nvim_lsp is not installed")
  end

end
